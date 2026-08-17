#!/usr/bin/env node
/**
 * reweight-casos.mjs — paso de construcción para casos.json (revisión H3).
 *
 * Dos cosas, ambas derivadas del propio contenido, así que es idempotente:
 *
 *   1. Re-etiqueta el tier según la presencia del bloque **Retroalimentación**,
 *      que es lo que el SKILL.md define como la marca del tier A ("diálogo +
 *      retroalimentación de Arti"). Antes, 92 casos tier A NO traían ese bloque
 *      —justo el que el modelo va a leer en el top-3— y 27 casos tier B sí lo
 *      traían y quedaban penalizados. Reglas:
 *        · tier A sin retroalimentación  -> B   (no cumple la definición de A)
 *        · tier B con retroalimentación  -> A   (sí la cumple)
 *        · el resto (A con retro, B sin retro, todo C) se queda igual
 *
 *   2. Añade el campo `peso`: un multiplicador de score continuo derivado de la
 *      LONGITUD de la enseñanza, no del tier binario (que con el 90 % en A no
 *      ordenaba nada). Se calcula aquí, al construir, para no pagarlo en cada
 *      búsqueda. buscar.mjs lo usa con `c.peso ?? TIER_BOOST[c.tier]`, así que
 *      un casos.json viejo sin `peso` sigue funcionando.
 *        0 caracteres -> 0.70 · ~140 -> ~1.05 · ~845 -> ~1.25 · 2775+ -> ~1.35
 *
 * Uso:  node build/reweight-casos.mjs [ruta-casos.json]   (por defecto, la del repo)
 */
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const HERE = dirname(fileURLToPath(import.meta.url));
const FILE = process.argv[2] || join(HERE, "..", "skills", "negociar", "data", "casos.json");

// Localiza el bloque de retroalimentación y devuelve su texto (o "" si no hay).
// El bloque es siempre la última sección del cuerpo; medimos de ahí al final.
function retroDe(body) {
  const m = (body || "").search(/Retroalimentaci[oó]n/i);
  if (m < 0) return "";
  return (body || "").slice(m).replace(/^Retroalimentaci[oó]n\s*:?\s*\*{0,2}\s*:?\s*/i, "").trim();
}

// Multiplicador continuo por longitud de la enseñanza (fórmula de la revisión H3).
function pesoDe(len) {
  return +(0.7 + 0.65 * Math.min(1, Math.log10(1 + len) / 3.45)).toFixed(3);
}

const orig = readFileSync(FILE, "utf8");
const casos = JSON.parse(orig);

const antes = {}, despues = {};
let retag = 0;
for (const c of casos) {
  const retro = retroDe(c.body);
  const hasRetro = retro.length > 0;
  antes[c.tier] = (antes[c.tier] || 0) + 1;

  let tier = c.tier;
  if (tier === "A" && !hasRetro) tier = "B";
  else if (tier === "B" && hasRetro) tier = "A";
  if (tier !== c.tier) retag++;
  c.tier = tier;

  c.peso = pesoDe(retro.length);
  despues[tier] = (despues[tier] || 0) + 1;
}

writeFileSync(FILE, JSON.stringify(casos, null, 1) + "\n");

const pesos = casos.map((c) => c.peso).sort((a, b) => a - b);
const pct = (q) => pesos[Math.floor(q * (pesos.length - 1))];
console.log("casos:", casos.length, "| re-etiquetados:", retag);
console.log("tier antes  :", JSON.stringify(antes));
console.log("tier después:", JSON.stringify(despues));
console.log("peso  min/p25/med/p75/max:",
  pesos[0], pct(0.25), pct(0.5), pct(0.75), pesos[pesos.length - 1]);
