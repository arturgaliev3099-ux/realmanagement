# Canon de la Lucha Gerencial / Management-Fight Canon

Fuente de verdad destilada de 157 directos de Arti Galiev (2.2 M de palabras, 1.992 principios)
en un canon estructurado al estilo de la *Tecnología Social* de Vladímir Tarásov.

- **10 dominios** · **275 entradas canónicas** · ~107k palabras
- Arquitectura y **principios raíz**: [00-ARQUITECTURA.md](00-ARQUITECTURA.md)

## Dominios / Domains

| # | Dominio | Subtemas | Entradas |
|---|---------|:--------:|:--------:|
| 1 | [Fundamentos de la lucha gerencial / Fundamentals of Management Fight](01-fundamentos-lucha-fundamentals-management-fight.md) | 9 | 44 |
| 2 | [La imagen del mundo e información asimétrica / Picture of the World and Information Asymmetry](02-imagen-mundo-picture-world.md) | 6 | 14 |
| 3 | [Dinámica de roles y escenarios de poder / Role Dynamics and Power Scenarios](03-dinamica-roles-role-dynamics.md) | 7 | 26 |
| 4 | [Negociación posicional y distribución de beneficios / Positional Negotiation and Benefit Distribution](04-negociacion-posicional-positional-negotiation.md) | 7 | 25 |
| 5 | [Ventas complejas y soluciones B2B / Complex Sales and B2B Solutions](05-ventas-complejas-complex-sales.md) | 7 | 24 |
| 6 | [Autoridad, distanciamiento y liderazgo de equipos / Authority, Distancing and Team Leadership](06-autoridad-distanciamiento-authority-distancing.md) | 6 | 34 |
| 7 | [Tecnología social, influencia y persuasión / Social Technology, Influence and Persuasion](07-tecnologia-social-social-technology.md) | 6 | 23 |
| 8 | [Gestión del conflicto, castigo y disciplina / Conflict Management, Punishment and Discipline](08-gestion-conflicto-conflict-management.md) | 8 | 27 |
| 9 | [Productividad personal, hábitos y las seis verticales / Personal Productivity, Habits and the Six Verticals](09-productividad-habitos-productivity-habits.md) | 9 | 28 |
| 10 | [Capital social, networking y alianzas / Social Capital, Networking and Alliances](11-capital-social-social-capital.md) | 8 | 30 |

## Coherencia interna

- [RECONCILIACION.md](RECONCILIACION.md) — tensiones aparentes entre dominios, reconciliadas (Fase 4).
- Cross-links `[[..]]`: 375 enlaces, 100% resueltos, 0 danglers (Fase 5). Auditar con `node canon-links-audit.mjs`.
- [EVALS.md](EVALS.md) — 8 relatos vagos pasados por el skill (Fase 7), 8/8 pasan el contrato.
- [SKILL-SPEC.md](SKILL-SPEC.md) — el contrato de respuesta del skill `/negociar`.

## El skill y la biblioteca de casos

Este canon alimenta el **skill `/negociar`** (`.claude/skills/negociar/`), que responde desde el
canon + la **biblioteca de casos** (`casos.json`, 1019 casos reales curados: laborales y de
pareja/familia/vida social/haters, con dominio · tier de calidad · esfera). El skill nunca responde
desde conocimiento genérico: cita el principio y el caso que respaldan cada jugada.

De las 157 clases procesadas, 144 aportaron al menos un caso a la biblioteca; las 13 restantes no
dejaron ningún caso catalogable en la curación. Por eso los textos hablan de «157 clases» (lo
procesado) y `casos.json` contiene 144 identificadores de clase.

## Cómo se usa este canon

Es la base de conocimiento que alimenta el **skill de negociación** (y futuros skills).
Cada entrada canónica sigue el formato: **tesis → ley/mecanismo → cuándo aplica → cómo se
ejecuta → ejemplos (fusionados de todo el corpus) → ver también → procedencia**.

Los conceptos transversales (sólido y hueco, unirse a la imagen del mundo, acercarse al ciervo,
la llave gerencial, suave-en-forma/duro-en-contenido, derecho a la ignorancia, camino a la vida,
fuerza de la indiferencia) son los **principios raíz** — ver la arquitectura.
