#!/usr/bin/env bash
# negociar — instalador para Claude Code y Codex (macOS / Linux / Bash).
# Windows (PowerShell): usa install.ps1.
#
# Instala el mismo skill en los dos agentes. Por defecto, a nivel de USUARIO —
# este skill trata de tu jefe y de tu pareja, no de un repositorio concreto,
# así que lo normal es quererlo disponible en todas las sesiones:
#
#   ~/.claude/skills/negociar/     Claude Code   -> se invoca con  /negociar
#   ~/.codex/skills/negociar/      Codex         -> se invoca con  $negociar
#
# Con --target DIR lo instala dentro de un proyecto concreto:
#
#   <DIR>/.claude/skills/negociar/   Claude Code
#   <DIR>/.agents/skills/negociar/   Codex
#
# Qué hace en cada copia, además de copiar los ficheros:
#   1. Reescribe ${CLAUDE_PLUGIN_ROOT}/skills/negociar por la ruta absoluta de
#      la instalación. Esa variable solo existe cuando Claude Code carga el
#      plugin desde el marketplace; en Codex y en una copia manual no existe.
#      Por eso el fichero fuente se deja intacto y lo que se reescribe es la
#      copia instalada: un solo SKILL.md que mantener.
#   2. En la copia de Codex sustituye la description por la de
#      description-codex.txt (Codex corta las descriptions a 1024 caracteres;
#      la de Claude es más larga).
#   3. Comprueba que la instalación funciona ejecutando buscar.mjs.
#
# Reejecutarlo es idempotente: reemplaza la carpeta negociar/ en su sitio y no
# toca ningún otro skill que tengas instalado.
#
# Uso:
#   # A) una línea, sin clonar nada:
#   curl -fsSL https://raw.githubusercontent.com/arturgaliev3099-ux/realmanagement/main/install.sh | bash
#
#   # B) desde un clon del repo:
#   bash install.sh                    # instalación de usuario (por defecto)
#   bash install.sh --target .         # dentro del proyecto actual
#   bash install.sh --claude-only      # solo Claude Code
#   bash install.sh --codex-only       # solo Codex
set -euo pipefail

REPO_URL="https://github.com/arturgaliev3099-ux/realmanagement.git"

TARGET=""
WANT_CLAUDE=1
WANT_CODEX=1
while [ $# -gt 0 ]; do
  case "$1" in
    --target) TARGET="${2:?--target necesita un directorio}"; shift 2 ;;
    --claude-only) WANT_CODEX=0; shift ;;
    --codex-only) WANT_CLAUDE=0; shift ;;
    -h|--help) sed -n '2,42p' "$0" 2>/dev/null || true; exit 0 ;;
    *) echo "argumento desconocido: $1" >&2; exit 1 ;;
  esac
done

command -v node >/dev/null 2>&1 || {
  echo "ERROR: hace falta 'node' en el PATH — el skill busca en los 1019 casos con él." >&2
  exit 1
}

# Localizar el origen: o estamos dentro de un clon, o hay que clonar a un temporal.
SELF="${BASH_SOURCE[0]:-}"
CLEANUP_SRC=0
if [ -n "$SELF" ] && [ -f "$SELF" ] && [ -f "$(cd "$(dirname "$SELF")" && pwd)/skills/negociar/SKILL.md" ]; then
  SRC="$(cd "$(dirname "$SELF")" && pwd)"
else
  command -v git >/dev/null 2>&1 || { echo "ERROR: hace falta 'git'." >&2; exit 1; }
  SRC="$(mktemp -d)"
  CLEANUP_SRC=1
  echo "Clonando $REPO_URL ..."
  git clone --depth 1 "$REPO_URL" "$SRC" >/dev/null 2>&1
fi
trap '[ "$CLEANUP_SRC" = "1" ] && rm -rf "$SRC"' EXIT

SKILL_SRC="$SRC/skills/negociar"
[ -f "$SKILL_SRC/SKILL.md" ] && [ -f "$SKILL_SRC/data/casos.json" ] || {
  echo "ERROR: $SRC no parece el repo de negociar (falta skills/negociar/)." >&2
  exit 1
}

# Destinos.
if [ -n "$TARGET" ]; then
  TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || { echo "ERROR: no existe el directorio: $TARGET" >&2; exit 1; }
  [ "$TARGET" = "$SRC" ] && { echo "ERROR: el destino es el propio clon. Ejecútalo desde tu proyecto o pasa --target <proyecto>." >&2; exit 1; }
  DEST_CLAUDE="$TARGET/.claude/skills/negociar"
  DEST_CODEX="$TARGET/.agents/skills/negociar"
  SCOPE="proyecto: $TARGET"
else
  DEST_CLAUDE="$HOME/.claude/skills/negociar"
  DEST_CODEX="$HOME/.codex/skills/negociar"
  SCOPE="usuario: $HOME"
fi

echo "Instalando negociar"
echo "  origen:  $SRC"
echo "  alcance: $SCOPE"

# Copia una variante e inyecta las rutas absolutas (y, en Codex, la description corta).
install_one() {
  dest="$1"; flavor="$2"
  rm -rf "$dest"
  mkdir -p "$(dirname "$dest")"
  cp -R "$SKILL_SRC" "$dest"
  # description-codex.txt solo sirve al instalador; no debe quedarse en el destino.
  rm -f "$dest/description-codex.txt"
  node "$SRC/scripts/postinstall.mjs" "$dest" "$flavor" "$SKILL_SRC/description-codex.txt"
  echo "  instalado -> $dest"
}

[ "$WANT_CLAUDE" = "1" ] && install_one "$DEST_CLAUDE" claude
[ "$WANT_CODEX" = "1" ] && install_one "$DEST_CODEX" codex

# Comprobación real: el script tiene que encontrar su canon y sus casos.
for d in "$DEST_CLAUDE" "$DEST_CODEX"; do
  [ -d "$d" ] || continue
  out="$(node "$d/scripts/buscar.mjs" --canon D4 2>&1)" || {
    echo "ERROR: la comprobación falló en $d" >&2; echo "$out" >&2; exit 1
  }
  [ -f "$out" ] || { echo "ERROR: buscar.mjs devolvió una ruta que no existe: $out" >&2; exit 1; }
done
echo "  comprobado: buscar.mjs encuentra el canon y los 1019 casos."

echo ""
cat <<EOF
============================================================================
  negociar instalado.
============================================================================

  Claude Code   /negociar     $( [ "$WANT_CLAUDE" = "1" ] && echo "$DEST_CLAUDE" || echo "(omitido)" )
  Codex         \$negociar     $( [ "$WANT_CODEX" = "1" ] && echo "$DEST_CODEX" || echo "(omitido)" )

  Reinicia el agente para que lo detecte.

  No le resumas el problema: pégale los mensajes tal cual, las fechas, las
  cantidades y lo que ya dijiste en persona. Con un resumen de dos líneas
  te devuelve una respuesta de dos líneas.

  Actualizar (idempotente, no toca tus otros skills):
      curl -fsSL https://raw.githubusercontent.com/arturgaliev3099-ux/realmanagement/main/install.sh | bash

  https://github.com/arturgaliev3099-ux/realmanagement
EOF
