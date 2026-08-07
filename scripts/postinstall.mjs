#!/usr/bin/env node
/**
 * postinstall.mjs — adapta una copia recién instalada del skill a su destino.
 * Lo llaman install.sh e install.ps1; no forma parte del skill instalado.
 *
 * Uso:  node postinstall.mjs <dirDestino> <claude|codex> [descripcionCodex.txt]
 *
 * Hace dos cosas sobre <dirDestino>/SKILL.md:
 *
 *  1. Sustituye `${CLAUDE_PLUGIN_ROOT}/skills/negociar` por la ruta absoluta del
 *     destino. Esa variable solo existe cuando Claude Code carga el plugin desde
 *     el marketplace; en Codex y en una instalación manual no está definida, y el
 *     skill se quedaría sin encontrar su canon ni sus casos. El fichero fuente del
 *     repo se deja intacto — así solo hay un SKILL.md que mantener.
 *
 *  2. Solo en la copia de Codex: cambia la description de la frontmatter por la de
 *     description-codex.txt, porque Codex corta las descriptions a 1024 caracteres
 *     y la de Claude es más larga.
 */
import { readFileSync, writeFileSync, existsSync } from "node:fs";
import { join } from "node:path";

const [dest, flavor, descFile] = process.argv.slice(2);

if (!dest || !["claude", "codex"].includes(flavor)) {
  console.error("uso: node postinstall.mjs <dirDestino> <claude|codex> [descripcionCodex.txt]");
  process.exit(2);
}

const PLACEHOLDER = "${CLAUDE_PLUGIN_ROOT}/skills/negociar";
const LIMITE_CODEX = 1024;

const skillFile = join(dest, "SKILL.md");
if (!existsSync(skillFile)) {
  console.error(`ERROR: no existe ${skillFile}`);
  process.exit(1);
}

let texto = readFileSync(skillFile, "utf8");

const sustituciones = texto.split(PLACEHOLDER).length - 1;
texto = texto.split(PLACEHOLDER).join(dest);
if (texto.includes("CLAUDE_PLUGIN_ROOT")) {
  console.error(`AVISO: quedan referencias a CLAUDE_PLUGIN_ROOT sin reescribir en ${skillFile}`);
  process.exit(1);
}

let notaDesc = "";
if (flavor === "codex" && descFile && existsSync(descFile)) {
  const desc = readFileSync(descFile, "utf8").trim().replace(/\s+/g, " ");
  if (desc.length > LIMITE_CODEX) {
    console.error(`ERROR: description-codex.txt tiene ${desc.length} caracteres; Codex corta a ${LIMITE_CODEX}.`);
    process.exit(1);
  }
  if (!/^description:.*$/m.test(texto)) {
    console.error("ERROR: no se encontró la línea 'description:' en la frontmatter.");
    process.exit(1);
  }
  texto = texto.replace(/^description:.*$/m, `description: ${desc}`);
  notaDesc = `, description de Codex (${desc.length} car.)`;
}

writeFileSync(skillFile, texto);
console.log(`  ${flavor}: ${sustituciones} rutas reescritas${notaDesc}`);
