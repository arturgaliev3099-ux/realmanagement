#requires -Version 5.1
<#
.SYNOPSIS
  negociar — instalador para Claude Code y Codex (Windows / PowerShell).
  macOS y Linux: usa install.sh.

.DESCRIPTION
  Instala el mismo skill en los dos agentes. Por defecto, a nivel de USUARIO —
  este skill trata de tu jefe y de tu pareja, no de un repositorio concreto, así
  que lo normal es quererlo disponible en todas las sesiones:

    ~\.claude\skills\negociar\     Claude Code   -> se invoca con  /negociar
    ~\.codex\skills\negociar\      Codex         -> se invoca con  $negociar

  Con -Target DIR lo instala dentro de un proyecto concreto:

    <DIR>\.claude\skills\negociar\   Claude Code
    <DIR>\.agents\skills\negociar\   Codex

  Además de copiar los ficheros, ejecuta scripts\postinstall.mjs sobre cada
  copia: reescribe ${CLAUDE_PLUGIN_ROOT}/skills/negociar por la ruta absoluta de
  la instalación (esa variable solo existe cuando Claude Code carga el plugin
  desde el marketplace) y, en la copia de Codex, sustituye la description por la
  corta de description-codex.txt (Codex corta a 1024 caracteres). Después
  comprueba que buscar.mjs encuentra el canon y los casos.

  Reejecutarlo es idempotente: reemplaza la carpeta negociar\ en su sitio y no
  toca ningún otro skill que tengas instalado.

.EXAMPLE
  # Una línea, sin clonar nada:
  irm https://raw.githubusercontent.com/arturgaliev3099-ux/realmanagement/main/install.ps1 | iex

.EXAMPLE
  # Desde un clon del repo:
  .\install.ps1                  # instalación de usuario (por defecto)
  .\install.ps1 -Target .        # dentro del proyecto actual
  .\install.ps1 -ClaudeOnly      # solo Claude Code
  .\install.ps1 -CodexOnly       # solo Codex
#>
[CmdletBinding()]
param(
  [string] $Target,
  [switch] $ClaudeOnly,
  [switch] $CodexOnly
)

$ErrorActionPreference = 'Stop'
$REPO_URL = 'https://github.com/arturgaliev3099-ux/realmanagement.git'

$wantClaude = -not $CodexOnly
$wantCodex  = -not $ClaudeOnly

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  throw "Hace falta 'node' en el PATH — el skill busca en los 1019 casos con él."
}

# Localizar el origen: o estamos dentro de un clon, o hay que clonar a un temporal.
$cleanupSrc = $false
$src = $null
if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot 'skills\negociar\SKILL.md'))) {
  $src = $PSScriptRoot
} else {
  # Incluye el caso `irm ... | iex`, donde no hay fichero en disco.
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "Hace falta 'git'." }
  $src = Join-Path ([System.IO.Path]::GetTempPath()) ("negociar-" + [guid]::NewGuid().ToString('N'))
  $cleanupSrc = $true
  Write-Host "Clonando $REPO_URL ..."
  git clone --depth 1 $REPO_URL $src 2>&1 | Out-Null
  if ($LASTEXITCODE -ne 0) { throw "git clone falló." }
}

try {
  $skillSrc = Join-Path $src 'skills\negociar'
  if (-not (Test-Path (Join-Path $skillSrc 'SKILL.md')) -or
      -not (Test-Path (Join-Path $skillSrc 'data\casos.json'))) {
    throw "$src no parece el repo de negociar (falta skills\negociar\)."
  }

  # Destinos.
  if ($Target) {
    $resolved = (Resolve-Path -LiteralPath $Target -ErrorAction SilentlyContinue)
    if (-not $resolved) { throw "No existe el directorio: $Target" }
    $targetDir = $resolved.Path
    if ($targetDir -eq $src) {
      throw "El destino es el propio clon. Ejecútalo desde tu proyecto o pasa -Target <proyecto>."
    }
    $destClaude = Join-Path $targetDir '.claude\skills\negociar'
    $destCodex  = Join-Path $targetDir '.agents\skills\negociar'
    $scope = "proyecto: $targetDir"
  } else {
    $destClaude = Join-Path $HOME '.claude\skills\negociar'
    $destCodex  = Join-Path $HOME '.codex\skills\negociar'
    $scope = "usuario: $HOME"
  }

  Write-Host "Instalando negociar"
  Write-Host "  origen:  $src"
  Write-Host "  alcance: $scope"

  $postinstall = Join-Path $src 'scripts\postinstall.mjs'
  $descCodex   = Join-Path $skillSrc 'description-codex.txt'

  function Install-One {
    param([string] $Dest, [string] $Flavor)

    if (Test-Path -LiteralPath $Dest) { Remove-Item -LiteralPath $Dest -Recurse -Force }
    $parent = Split-Path -Parent $Dest
    if (-not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    Copy-Item -LiteralPath $skillSrc -Destination $Dest -Recurse -Force

    # description-codex.txt solo sirve al instalador; no debe quedarse en el destino.
    $stray = Join-Path $Dest 'description-codex.txt'
    if (Test-Path -LiteralPath $stray) { Remove-Item -LiteralPath $stray -Force }

    & node $postinstall $Dest $Flavor $descCodex
    if ($LASTEXITCODE -ne 0) { throw "postinstall.mjs falló en $Dest" }
    Write-Host "  instalado -> $Dest"
  }

  if ($wantClaude) { Install-One -Dest $destClaude -Flavor 'claude' }
  if ($wantCodex)  { Install-One -Dest $destCodex  -Flavor 'codex'  }

  # Comprobación real: el script tiene que encontrar su canon y sus casos.
  foreach ($d in @($destClaude, $destCodex)) {
    if (-not (Test-Path -LiteralPath $d)) { continue }
    $out = & node (Join-Path $d 'scripts\buscar.mjs') --canon D4 2>&1
    if ($LASTEXITCODE -ne 0) { throw "La comprobación falló en ${d}:`n$out" }
    if (-not (Test-Path -LiteralPath ($out | Select-Object -Last 1))) {
      throw "buscar.mjs devolvió una ruta que no existe: $out"
    }
  }
  Write-Host "  comprobado: buscar.mjs encuentra el canon y los 1019 casos."

  $lineaClaude = if ($wantClaude) { $destClaude } else { '(omitido)' }
  $lineaCodex  = if ($wantCodex)  { $destCodex }  else { '(omitido)' }

  Write-Host ""
  Write-Host "============================================================================"
  Write-Host "  negociar instalado."
  Write-Host "============================================================================"
  Write-Host ""
  Write-Host "  Claude Code   /negociar     $lineaClaude"
  Write-Host "  Codex         `$negociar     $lineaCodex"
  Write-Host ""
  Write-Host "  Reinicia el agente para que lo detecte."
  Write-Host ""
  Write-Host "  No le resumas el problema: pégale los mensajes tal cual, las fechas, las"
  Write-Host "  cantidades y lo que ya dijiste en persona. Con un resumen de dos líneas"
  Write-Host "  te devuelve una respuesta de dos líneas."
  Write-Host ""
  Write-Host "  Actualizar (idempotente, no toca tus otros skills):"
  Write-Host "      irm https://raw.githubusercontent.com/arturgaliev3099-ux/realmanagement/main/install.ps1 | iex"
  Write-Host ""
  Write-Host "  https://github.com/arturgaliev3099-ux/realmanagement"
}
finally {
  if ($cleanupSrc -and $src -and (Test-Path -LiteralPath $src)) {
    Remove-Item -LiteralPath $src -Recurse -Force -ErrorAction SilentlyContinue
  }
}
