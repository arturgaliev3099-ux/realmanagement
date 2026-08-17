# Real Management

> **v1.0.8** · Claude Code + Codex · 275 principles · 1019 recorded negotiations · **answers in Spanish**

**A negotiation advisor that runs inside Claude Code or Codex.**

Install it, type `/negociar`, and describe what you're stuck in. It tells you what to do next: what
to say, in what order, what the other person will say back, and your answer to that.

It's for situations with something real at stake. A client who won't pay, a boss, a raise, an unfair
accusation, a deal that won't close. Also a partner, a family member, a neighbour, a landlord.

The answers don't come from general knowledge about negotiation. They come from 157 recorded classes
where real people brought their own conflicts and worked them in front of a room — the full dialogue,
plus the correction of what they got wrong. That material was written up into 275 principles and 1019
catalogued cases. It searches them on every question and answers from what's there.

It answers in Spanish.

> **A full worked answer, start to finish** — €5,000 owed on a referral for a €1.3M flat, by a friend
> who now wants to settle for €1,000: [`EJEMPLO-NOVATO.md`](skills/negociar/EJEMPLO-NOVATO.md)
> *(written in Russian)*

---

## What to actually type into it

It works out what happened from what you hand it, so what you hand it decides the answer. Describe
your problem in one paragraph and you get advice you could have written yourself. Give it the real
material and you get something specific to your situation.

**The messages themselves, not your summary of them.** Paste the thread, the email, the screenshot.
Their exact words matter more than your description of their tone — a lot of the read comes from how
short their replies got and which of your points they walked past.

**What was already said out loud.** In person, on a call, the apology you already made, what you
already agreed to. Without this it hands you a message repeating things the other person has heard
ten times. This is the most common way its answers go wrong.

**Dates, amounts, deadlines, silences.** A reply written the same day is a different situation from
one sent after three weeks of silence, where not answering has already been taken as a yes.

**Who these people are to each other.** Who depends on whom, who can walk away, who has other
options, what each side loses if this goes badly. The one who sounds weak in your telling is often
the one holding the leverage.

**What you want, and what you're afraid of.** The money, an apology, to close it quietly, to keep the
relationship, to never deal with them again. The same facts with a different goal produce a genuinely
different plan.

**Your constraints.** *"No apology in writing." "It has to be a phone call." "I can't threaten to
sue."* Without them you get a plan you can't actually carry out.

Then it asks up to three questions — only the ones that would change what it recommends. And if it
read the situation wrong, tell it what it missed: it redoes the diagnosis instead of defending its
first answer.

---

## Install

Works in **Claude Code** and **Codex**. Every route needs `node` on your PATH — that's what searches
the 1019 cases.

### Claude Code — plugin manager

```bash
/plugin marketplace add arturgaliev3099-ux/realmanagement
```

```bash
/plugin install negociar@negociar-marketplace
```

### Either agent — installer

Same source, both agents. Defaults to a **user-level** install, because this is about your boss and
your partner, not about one repository — you want it in every session.

macOS / Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/arturgaliev3099-ux/realmanagement/main/install.sh | bash
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/arturgaliev3099-ux/realmanagement/main/install.ps1 | iex
```

| | Claude Code | Codex |
|---|---|---|
| user install *(default)* | `~/.claude/skills/negociar/` | `~/.codex/skills/negociar/` |
| project install *(`--target DIR`)* | `DIR/.claude/skills/negociar/` | `DIR/.agents/skills/negociar/` |

Then **`/negociar`** in Claude Code, **`$negociar`** in Codex. Restart the agent so it picks the
skill up.

Flags: `--target DIR`, `--claude-only`, `--codex-only` — in PowerShell `-Target`, `-ClaudeOnly`,
`-CodexOnly`. Re-running is idempotent: it replaces the `negociar` folder in place and leaves every
other skill you have installed alone.

<details>
<summary>What the installer changes in the copy it installs</summary>

The skill's paths are written as `${CLAUDE_PLUGIN_ROOT}/skills/negociar/…`. That variable only exists
when Claude Code loads the plugin through the marketplace — under Codex, or in a hand-copied install,
it's undefined and the skill never finds its canon or its cases.

So [`scripts/postinstall.mjs`](scripts/postinstall.mjs) rewrites that prefix to the absolute install
path in the copy it just made, and swaps in a shorter `description` for Codex, which truncates skill
descriptions at 1024 characters. The source file here is left untouched — one `SKILL.md` to maintain,
not two.

</details>

---

## Why not just ask the model directly

You can, and for something simple it's fine. Two differences show up once there is money or a job or
a relationship on the line.

**It works from one specific tradition instead of the average of everything ever written about
negotiation.** The material is Vladimir Tarasov's social technology. It is not what the Anglo-Saxon
books teach and not what a language model has mostly read, so asking directly gets you the average
and this gets you the tradition. No win-win, no BATNA: it looks at who controls the story both sides
are telling themselves, what each side is genuinely prepared to do, and the roles people slide into
without noticing.

**It looks things up instead of improvising.** On every question it searches the 1019 cases and the
part of the canon that applies, then builds the answer out of what it found. When the material
doesn't cover your situation it says so, rather than producing something that merely sounds right.

One consequence worth knowing in advance: you're describing your own conflict, so you're describing
it from inside. It will tell you how your last message probably read to the other person, which is
usually the part you can't see from where you're standing.

---

## What's inside

**The canon — 275 principles across 10 domains.** "The canon" is the written-up material: each entry
states the mechanism, when it applies, how to run it step by step, and real examples. It was
distilled from 1992 raw principles pulled out of those 157 classes — 2.2M words — then consolidated,
so one entry can merge up to 50 separate mentions of the same thing.

| Domain | # | | Domain | # |
|---|--:|---|---|--:|
| Fundamentals of Hard Management | 44 | | Authority and leadership | 34 |
| Social capital and alliances | 30 | | Productivity and habits | 28 |
| Conflict and discipline | 27 | | Role dynamics | 26 |
| Positional negotiation | 25 | | Complex B2B sales | 24 |
| Influence and persuasion | 23 | | Conflicting worldviews | 14 |

**The library — 1019 recorded negotiations.** Live, with the full dialogue and Arti's feedback on
what failed and what would have been stronger. Not invented examples: real people negotiating real
situations and getting it wrong in front of a room.

| Sphere | Cases | | Quality | Cases |
|---|--:|---|---|--:|
| Work | 830 | | **A** — dialogue + teaching | 854 |
| Social (neighbours, friends, haters) | 79 | | **B** — scenario + dialogue | 162 |
| Couple | 72 | | **C** — fragmentary | 3 |
| Family | 38 | | | |

Participants appear as *Participante A/B/C*, relabelled independently in every case, so nobody's path
can be traced across the corpus.

---

## What it does on your machine

Installing a plugin is running a stranger's code. So, the whole surface:

- **At runtime, one script:** [`buscar.mjs`](skills/negociar/scripts/buscar.mjs) — 133 lines — which
  searches `casos.json` by keyword. It **only reads** its own data files. No writes, no subprocesses,
  no sockets.
- **At install time, only if you use the installer:** [`install.sh`](install.sh) /
  [`install.ps1`](install.ps1) copy `skills/negociar/` into the directories listed above and run
  [`postinstall.mjs`](scripts/postinstall.mjs), which rewrites paths inside that copy. They write
  nowhere else, and the one-liner clones this repo to a temp folder and deletes it after.
- **Nothing leaves your machine.** No telemetry, no analytics, no external APIs. Works offline. No
  `package.json`, nothing from npm.

A few hundred lines you can read in one sitting. Read them before you install — that's the right
habit with any plugin, this one included.

---

## Author

**Arti Galiev** — [instagram.com/arti_galiev](https://instagram.com/arti_galiev)

The canon wasn't written. It was extracted. 157 live classes where people brought their own messes —
a boss, a client who won't pay, an unfair accusation, a partner, a neighbour — and fought them in
real time, in front of everyone. What got recorded is what they got wrong and how it was corrected.

The tradition is **Vladimir Tarasov's** social technology, which diverges hard from the Anglo-Saxon
negotiation literature that dominates both the bookshelf and the language models.

---

## Language

The canon, the cases and the answers are in **Spanish**. This README is in English so people can find
it.

---

## Licence

Content under [**CC BY-NC-SA 4.0**](LICENSE), code under **MIT**.

Apply the methodology in your own work and your own company without limit — the non-commercial clause
restricts only commercial redistribution of the material itself.

**Disclaimer.** This gives opinion and strategy, not legal, financial, medical or psychological
advice. Your decisions and their consequences are yours. Provided as is, without warranty.
