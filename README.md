# Real Management — negotiation and managerial combat

> **v1.0.8** · Claude Code plugin · 275 canon principles · 1019 recorded fights · **answers in Spanish**

You describe a mess in one messy paragraph. It tells you what is actually happening — including the
part you left out about yourself — and gives you the moves.

---

## What it looks like

**You:**

> A client owes me the final payment. Three months of chasing. I've explained everything, sent long
> messages, told him my team hasn't been paid. He replies in five words and keeps stalling. Last week
> I said we'd stop working. Two days later I backed down.

**It answers:**

> **You lost this on the day you backed down.** An ultimatum you don't execute is worse than no
> ultimatum: he has now tested whether your words carry anything, and found out they don't. His
> five-word replies aren't rudeness — they're the correct response to someone who has asked seven
> times and never once made a "no" cost anything.
>
> **Your blind spot:** re-read your own messages. *"My team has been working for months and hasn't
> been paid," "people are increasingly frustrated," "I kindly ask."* You believe you are making an
> argument. You are asking for a favour. There is a law for this in the canon — *"I gave you time"*
> means *"this is unfair"* means *"please pay me."* A valid argument names a concrete consequence
> that happens whether he agrees or not.
>
> **What you have never used:** the documents are physically in your possession. He cannot close his
> registration without them. Everything you've done so far is words; your actual leverage is objects.
>
> **The move — questions, not arguments.** You've spent all your arguments and they failed…

Then comes the ladder of moves, what he will object at each step and your counter, the worst case
prepared in advance, and the branches for everything you didn't mention.

> Full worked example, start to finish: [`EJEMPLO-NOVATO.md`](skills/negociar/EJEMPLO-NOVATO.md)

---

## Install

```bash
/plugin marketplace add arturgaliev3099-ux/realmanagement
```

```bash
/plugin install negociar@negociar-marketplace
```

Then `/negociar` in any session. Needs `node` on your PATH.

<details>
<summary>Manual install, without the plugin manager</summary>

```bash
git clone https://github.com/arturgaliev3099-ux/realmanagement.git
cp -r realmanagement/skills/negociar ~/.claude/skills/
```

</details>

---

## Why it isn't another negotiation prompt

**The unit is not the deal, it's the fight.** No win-win, no BATNA. Grip, takedown and fixation;
solid and hollow; whose picture of the world is running the room; the roles each side occupies
without noticing.

**It doesn't take your side.** Whoever asks casts themselves as the good guy and omits their own
part. It reconstructs what actually happened and names your blind spot — soft in form, hard in
substance.

**It gives the move, not advice.** Not "be more assertive," but the exact order of steps, what to
ask at each one and why, what the other will object and what you answer.

**It refuses to improvise.** Every move rests on a principle from the canon and, where it helps, on
a recorded case. When the canon doesn't cover something, it says so instead of filling the gap with
generic advice.

---

## What's inside

**The canon — 275 principles across 10 domains.** Each one carries its law (the mechanism), when it
applies, how to execute it step by step, and real examples. Distilled from 1992 atomic principles
extracted from 157 live classes (2.2M words), then consolidated and reconciled — a single entry can
merge up to 50 separate mentions.

| Domain | # | | Domain | # |
|---|--:|---|---|--:|
| Fundamentals of the fight | 44 | | Authority and leadership | 34 |
| Social capital and alliances | 30 | | Productivity and habits | 28 |
| Conflict and discipline | 27 | | Role dynamics | 26 |
| Positional negotiation | 25 | | Complex B2B sales | 24 |
| Influence and persuasion | 23 | | Picture of the world | 14 |

**The library — 1019 recorded fights.** Live sparring with the full dialogue and Arti's feedback on
what failed and what would have been stronger. Not invented examples: real people fighting real
situations and getting it wrong in front of everyone.

| Sphere | Cases | | Quality | Cases |
|---|--:|---|---|--:|
| Work | 830 | | **A** — dialogue + teaching | 920 |
| Social (neighbours, friends, haters) | 79 | | **B** — scenario + dialogue | 96 |
| Couple | 72 | | **C** — fragmentary | 3 |
| Family | 38 | | | |

Participants are anonymised as *Participante A/B/C*, relabelled in every case, so nobody's path can
be traced across the corpus.

---

## What it does on your machine

Installing a plugin means running someone else's code, so:

- One local script, [`buscar.mjs`](skills/negociar/scripts/buscar.mjs) — 132 lines — which searches
  `casos.json` by keyword.
- It **only reads** its own data files. No writes, no subprocesses, no network.
- **Nothing leaves your machine.** No telemetry, no analytics, no external APIs. Works offline.

132 lines you can read in one sitting. Read them before installing — that's the right habit with any
plugin, this one included.

---

## Author

**Arti Galiev** — [instagram.com/arti_galiev](https://instagram.com/arti_galiev)

The canon wasn't written in one go. It was distilled from 157 live classes where participants brought
their own messes — a boss, a client who won't pay, an unfair accusation, a partner, a neighbour — and
fought them in real time. What got recorded is what they got wrong and how it was corrected.

The tradition is **Vladimir Tarasov's** social technology, which diverges substantially from the
Anglo-Saxon negotiation literature that dominates both the books and the language models.

---

## Language

The canon, the cases and the answers are in **Spanish**. This README is in English so people can find
it.

---

## Licence

Content under [**CC BY-NC-SA 4.0**](LICENSE), code under **MIT**.

You may apply the methodology in your own work and your own company without limit — the
non-commercial clause restricts only commercial redistribution of the material itself.

**Disclaimer.** This gives opinion and strategy, not legal, financial, medical or psychological
advice. Your decisions and their consequences are yours. Provided as is, without warranty.
