# Lucha Gerencial: canon y skill de negociación

> **v1.0.8 — estable.** Plugin de Claude Code. 275 principios · 1019 casos reales · español.

Un asesor de **lucha gerencial** con el que hablas. Le cuentas tu lío en una frase —
incompleta, en primera persona, contándote como el bueno— y te devuelve la situación real
(incluido tu punto ciego), la ley que la gobierna y la jugada concreta, con el caso real que
la respalda.

No responde desde negociación de manual. Responde desde un canon destilado de **157 clases en
directo** de [Arti Galiev](https://instagram.com/arti_galiev), en la tradición de tecnología
social de Vladímir Tarásov.

---

## Empezar

```bash
/plugin marketplace add arturgaliev3099-ux/realmanagement
```

```bash
/plugin install negociar@negociar-marketplace
```

Después, en cualquier sesión: `/negociar` y cuenta tu situación.

<details>
<summary>Instalación manual (sin el gestor de plugins)</summary>

```bash
git clone https://github.com/arturgaliev3099-ux/realmanagement.git
cp -r realmanagement/skills/negociar ~/.claude/skills/
```

El skill necesita `node` en el PATH para el buscador de casos.

</details>

---

## Por qué esto no es "otro prompt de negociación"

**La unidad no es el acuerdo, es la lucha.** Aquí no se habla de *win-win* ni de *BATNA*. Se
habla de agarre, derribo y fijación; de lo sólido y lo hueco; de quién impone su imagen del
mundo; de los roles que cada uno ocupa sin darse cuenta.

**No te da la razón.** Quien consulta se cuenta a sí mismo como el bueno y omite su propia
parte. El skill reconstruye lo que pasó de verdad y te nombra tu punto ciego — suave en la
forma, duro en el fondo.

**Te da la jugada, no un consejo.** No "deberías ser más asertivo", sino el orden exacto de
los movimientos, qué preguntar en cada paso y por qué, qué va a objetar el otro y qué
respondes tú a cada objeción — incluido el peor escenario.

**Todo lo que dice está respaldado.** Cada jugada descansa en un principio del canon y, cuando
ilumina, en un caso real de la biblioteca. Si el canon no cubre algo, lo dice en vez de
rellenar con genérico.

---

## Qué hay dentro

### El canon — 275 principios en 10 dominios

Cada principio trae su **ley** (el mecanismo), **cuándo aplica**, **cómo se ejecuta** paso a
paso, y **ejemplos** reales.

| Dominio | Principios | De qué trata |
|---|---:|---|
| Fundamentos de la lucha | 44 | Combate verbal, aceptar o deshacer un agarre, etiquetas de culpa, la fuerza de la indiferencia |
| Imagen del mundo | 14 | Quién controla el relato, distancia informativa, datos contra opiniones, el derecho a la ignorancia |
| Dinámica de roles | 26 | Escudo de rol, rol de víctima, rol de maestro, usurpación de autoridad |
| Negociación posicional | 25 | Subidas de sueldo, el "no" del decisor, irreversibilidad de las concesiones, anclaje de precios |
| Ventas complejas B2B | 24 | Persona contra rol, mapa de roles de compra, disconfort y dolor, preventa |
| Autoridad y liderazgo | 34 | Distanciamiento, leales contra devotos, la regla del segundo grito, delegar |
| Influencia y persuasión | 23 | Encuadre, persuasión contra manipulación, nemawashi, la conclusión inducida |
| Conflicto y disciplina | 27 | Castigar sin perdonar, desescalar del pasado al futuro, gestionar la culpa, poner un límite |
| Productividad y hábitos | 28 | Las seis verticales, planificación inversa, energía y dopamina, la regla del 40% |
| Capital social | 30 | Construir capital social, comprobar lealtad, lazos débiles, conectores |

### La biblioteca — 1019 casos reales

Combates grabados en directo, con el diálogo completo y la retroalimentación de Arti sobre qué
falló y qué habría sido más fuerte. No son ejemplos inventados: son personas reales peleando
situaciones reales y equivocándose delante de todos.

| Esfera | Casos | | Calidad | Casos |
|---|---:|---|---|---:|
| Laboral | 830 | | **A** — diálogo + enseñanza de Arti | 920 |
| Social (vecinos, amigos, haters) | 79 | | **B** — escenario + diálogo | 96 |
| Pareja | 72 | | **C** — fragmentario | 3 |
| Familia | 38 | | | |

El buscador prioriza automáticamente los casos de calidad A, porque ahí está la enseñanza.

---

## Cómo se ve una respuesta

En **un solo mensaje** recibes cuatro bloques:

1. **Te leo la situación real** — la lucha que hay de verdad debajo de lo que contaste, los
   roles, dónde está tu fuerza y dónde tu hueco, el interés real del otro, y tu propio punto
   ciego dicho con tacto.
2. **Qué es esto en realidad** — el mecanismo y la ley que lo gobierna, explicada en palabras
   de la calle antes de nombrarla.
3. **La jugada** — la escalera de movimientos, cada peldaño con su porqué, lo que el otro va a
   objetar y tu respuesta a cada objeción, más el peor escenario preparado.
4. **Según lo que no me dijiste** — las bifurcaciones decisivas, cada una resuelta, para que la
   respuesta te sirva aunque no contestes ninguna pregunta.

Solo después, hasta tres preguntas de afinado — y únicamente las que cambiarían la
recomendación.

> **Desglose completo de un caso real:** [`EJEMPLO-NOVATO.md`](skills/negociar/EJEMPLO-NOVATO.md)
> — cómo se ve el skill trabajando de principio a fin, escrito para alguien que no sabe nada de
> negociación.

---

## Qué hace el skill en tu máquina

Transparencia, porque instalar un plugin es ejecutar código ajeno:

- El skill ejecuta **un único script local**, [`buscar.mjs`](skills/negociar/scripts/buscar.mjs)
  (132 líneas), que busca casos en `casos.json` por palabras clave.
- Ese script **solo lee** sus propios ficheros de datos (`readFileSync`, `existsSync`,
  `readdirSync`). No escribe nada, no ejecuta subprocesos, no abre conexiones de red.
- **Nada sale de tu máquina** hacia ningún servidor de este proyecto. No hay telemetría, ni
  analítica, ni llamadas a APIs externas.
- Todo el canon y todos los casos viajan dentro del repositorio: el skill funciona sin
  internet.

El código son 132 líneas legibles de un tirón. Léelas antes de instalar si te importa — es lo
correcto con cualquier plugin, incluido este.

---

## Estructura del repositorio

```
.
├── .claude-plugin/
│   ├── plugin.json              # manifiesto del plugin
│   └── marketplace.json         # manifiesto del marketplace
└── skills/negociar/
    ├── SKILL.md                 # las instrucciones del asesor
    ├── EJEMPLO-NOVATO.md        # desglose completo de un caso real
    ├── scripts/
    │   └── buscar.mjs           # buscador determinista de casos
    └── data/
        ├── canon/               # 275 principios en 10 dominios
        │   ├── 00-ARQUITECTURA.md
        │   ├── 01-fundamentos-lucha…md
        │   └── …
        └── casos.json           # 1019 casos reales
```

---

## Sobre el autor

**Arti Galiev** — [instagram.com/arti_galiev](https://instagram.com/arti_galiev)

El canon no se escribió de un tirón: se destiló de 157 clases en directo de lucha gerencial,
donde los participantes traían sus propios líos —un jefe, un cliente que no paga, una
acusación injusta, una pareja, un vecino— y los peleaban en vivo. Lo que quedó grabado es lo
que se equivocaron y lo que se corrigió. De ahí salen los 275 principios y los 1019 casos.

La tradición es la de **Vladímir Tarásov** y su tecnología social, que diverge de forma
sustancial de la negociación anglosajona que domina los libros y los modelos de lenguaje.

---

## Licencia y descargo

Publicado bajo [**CC BY-NC-SA 4.0**](LICENSE) — puedes usarlo, adaptarlo y compartirlo con
atribución, para fines no comerciales, manteniendo la misma licencia.

Puedes aplicar la metodología en tu propio trabajo y en tu empresa sin límite. La licencia
restringe únicamente la redistribución comercial del material.

**El código** (`scripts/`) se libera bajo MIT.

**Descargo.** Este skill da opinión y estrategia, no asesoramiento legal, financiero,
médico ni psicológico. Las decisiones y sus consecuencias son tuyas. Se entrega TAL CUAL, sin
garantía de ningún tipo.
