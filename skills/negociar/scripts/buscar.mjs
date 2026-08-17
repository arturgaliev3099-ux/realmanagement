#!/usr/bin/env node
/**
 * buscar.mjs — recuperación determinista de casos para el skill /negociar.
 *
 * Cada caso: {id,date,dir,title,body,domain,tier,sphere,n}. El número global = índice+1.
 * Auto-localiza sus datos (casos.json y canon/) — primero vía CLAUDE_PLUGIN_ROOT (plugin
 * instalado), luego relativo a este script o al cwd (repo de desarrollo). Funciona sin importar
 * desde qué carpeta se ejecute.
 *
 * Uso:
 *   node buscar.mjs <términos...> [--dom D4[,D5]] [--tier A] [--sphere pareja] [--n 6]
 *   node buscar.mjs --show <N|N,M,...>       → imprime el/los caso(s) completo(s)
 *   node buscar.mjs --canon <Dn>             → imprime la RUTA del fichero de canon del dominio
 *   node buscar.mjs --canon-dir              → imprime la ruta de la carpeta canon/
 */
import { readFileSync, existsSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const HERE = dirname(fileURLToPath(import.meta.url));
const ROOT = process.env.CLAUDE_PLUGIN_ROOT;
const DATA_DIRS = [
  ROOT && join(ROOT, "skills", "negociar", "data"), // plugin instalado (cache)
  ROOT && join(ROOT, "data"),                        // plugin (data en raíz)
  join(HERE, "..", "data"),                          // plugin: skills/negociar/data (relativo)
  process.cwd(),                                     // repo dev: raíz
  join(HERE, "..", "..", "..", ".."),                // repo dev: raíz desde scripts/
].filter(Boolean);
const DATA = DATA_DIRS.find((d) => existsSync(join(d, "casos.json")));
if (!DATA) {
  console.error("No encuentro casos.json (ni en el plugin ni en el repo).");
  process.exit(1);
}
const CANON_DIR = existsSync(join(DATA, "canon")) ? join(DATA, "canon") : DATA;

const argv = process.argv.slice(2);

// --- localizar los ficheros del canon ---
if (argv.includes("--canon-dir")) { console.log(CANON_DIR); process.exit(0); }
const canonIx = argv.indexOf("--canon");
if (canonIx !== -1) {
  const dom = (argv[canonIx + 1] || "").toUpperCase().replace(/[^D0-9]/g, "");
  const num = dom.replace("D", "").padStart(2, "0");
  const files = existsSync(CANON_DIR) ? readdirSync(CANON_DIR) : [];
  const f = files.find((x) => x.startsWith(num + "-"));
  console.log(f ? join(CANON_DIR, f) : `(no encuentro el canon de ${dom} en ${CANON_DIR})`);
  process.exit(f ? 0 : 1);
}

const CASOS = JSON.parse(readFileSync(join(DATA, "casos.json"), "utf8"));

// --- modo --show N[,M] ---
const showIx = argv.indexOf("--show");
if (showIx !== -1) {
  const nums = (argv[showIx + 1] || "").split(",").map((s) => parseInt(s.trim(), 10)).filter(Boolean);
  for (const n of nums) {
    const c = CASOS[n - 1];
    if (!c) { console.log(`\n[Caso #${n} no existe — rango 1..${CASOS.length}]`); continue; }
    console.log(`\n===== Caso #${n} — ${c.title} =====`);
    console.log(`Directo ${c.dir} · ${c.date} · clase ${c.id} · dominio: ${c.domain} · tier ${c.tier} · esfera ${c.sphere}\n`);
    console.log(c.body.trim());
  }
  console.log();
  process.exit(0);
}

// --- búsqueda ---
const FLAGS = ["--dom", "--n", "--tier", "--sphere", "--show", "--canon"];

let doms = null;
const domIx = argv.indexOf("--dom");
if (domIx !== -1) doms = (argv[domIx + 1] || "").split(",").map((s) => s.trim().toUpperCase()).filter(Boolean);

let topN = 6;
const nIx = argv.indexOf("--n");
if (nIx !== -1) topN = Math.max(1, parseInt(argv[nIx + 1], 10) || 6);

let tierFilter = null;
const tIx = argv.indexOf("--tier");
if (tIx !== -1) tierFilter = (argv[tIx + 1] || "").toUpperCase();

let sphereFilter = null;
const spIx = argv.indexOf("--sphere");
if (spIx !== -1) sphereFilter = (argv[spIx + 1] || "").toLowerCase();

// Normaliza a minúsculas y quita diacríticos, para que "negociacion" y
// "negociación" recuperen el mismo caso: los términos los teclea el modelo
// derivándolos del relato, y no siempre trae las tildes. (H2)
const norm = (s) => s.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");

const terms = argv
  .filter((a, i) => !a.startsWith("--") && !FLAGS.includes(argv[i - 1]))
  .flatMap((a) => norm(a).split(/\s+/))
  .map((t) => t.replace(/[^\p{L}\p{N}áéíóúüñ]/giu, ""))
  .filter((t) => t.length >= 3);

if (!terms.length) {
  console.error('Sin términos de búsqueda. Ej: node ... buscar.mjs "jefe culpa retraso" --dom D3,D8');
  process.exit(1);
}

function domOf(c) { const m = (c.domain || "").match(/D\d+/); return m ? m[0] : "—"; }
const TIER_BOOST = { A: 1.15, B: 1.0, C: 0.7 };

const scored = CASOS
  .map((c, i) => {
    if (doms && !doms.includes(domOf(c))) return null;
    if (tierFilter && (c.tier || "") !== tierFilter) return null;
    if (sphereFilter && (c.sphere || "") !== sphereFilter) return null;
    const title = norm(c.title || "");
    const body = norm(c.body || "");
    let score = 0;
    for (const t of terms) {
      const inTitle = title.split(t).length - 1;
      const inBody = body.split(t).length - 1;
      score += inTitle * 3 + Math.min(inBody, 3); // cap body hits para no premiar repetición
    }
    score *= c.peso ?? (TIER_BOOST[c.tier] || 1); // peso por longitud de la enseñanza (H3); TIER_BOOST solo si el casos.json es viejo y no trae `peso`
    return score > 0 ? { n: i + 1, c, score: +score.toFixed(2) } : null;
  })
  .filter(Boolean)
  .sort((a, b) => b.score - a.score)
  .slice(0, topN);

if (!scored.length) {
  console.log(`Sin coincidencias para [${terms.join(", ")}]${doms ? " en " + doms.join("/") : ""}.`);
  console.log("Prueba términos más generales o quita el filtro --dom.");
  process.exit(0);
}

console.log(`Top ${scored.length} casos para [${terms.join(", ")}]${doms ? " · dominios " + doms.join("/") : ""}:\n`);
for (const { n, c, score } of scored) {
  const snip = (c.body || "").replace(/\s+/g, " ").slice(0, 180);
  console.log(`#${n}  [${domOf(c)}]  [tier ${c.tier || "?"} · ${c.sphere || "?"}]  ${c.title}  (score ${score})`);
  console.log(`      ${snip}…\n`);
}
console.log(`Para leer uno entero:  node <ruta>/buscar.mjs --show <N>`);
