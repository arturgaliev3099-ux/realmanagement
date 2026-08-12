# Real Management

> **v1.0.8** · Claude Code + Codex · 275 principles · 1019 recorded negotiations · **answers in Spanish**

Paste in the whole thing — the thread, the dates, the amounts, what you already said out loud — and
get back the move. Not "be more assertive": the order of the steps, what to say at each one, what
the other side will object, and your answer to it.

Work and life both. A client who won't pay, a boss, a raise, an unfair accusation, a deal that won't
close — and a partner, a family member, a neighbour, a landlord, a hater.

It runs on a canon of 275 principles and 1019 recorded negotiations — real ones, full dialogue,
including what the person got wrong and what would have worked better. Not on what a language model
picked up about negotiation along the way. That difference shows up in the first paragraph.

> **A full worked answer, start to finish** — €5,000 owed on a referral for a €1.3M flat, by a friend
> who now wants to settle for €1,000: [`EJEMPLO-NOVATO.md`](skills/negociar/EJEMPLO-NOVATO.md)
> *(written in Russian)*

---

## It is only as good as what you feed it

This section matters more than anything else in this README. The diagnosis is reconstruction — it
works out what happened from the raw material, so it can only be as good as the material.

**Paste the thing, don't retell it.** The actual messages, the thread, the email, the screenshot.
Their exact words beat your description of their tone. Half the diagnosis comes from how short their
replies got and which of your arguments they walked past.

**Say what was already said out loud.** In person, on the call, the apology you already made, what's
already agreed. Skip this and it hands you a message repeating things the other person has heard ten
times — the single most common way its answers go wrong.

**Give the timeline and the numbers.** Dates, silences, amounts, deadlines. A reply in the heat of it
is a different situation from one gone cold, where your silence has already been read as a yes.

**Say who these people really are to each other.** Who depends on whom, who can walk, who has
alternatives, what each side actually stands to lose. The side that looks weak in your telling is
usually the one holding the leverage.

**Say what you actually want** — the money, an apology, to close it quietly, to keep the
relationship, to never see them again. And what you're afraid of. Same facts, different goal,
genuinely different move.

**Answer its questions.** It resolves what it can, then asks up to three — only the ones that would
flip the recommendation. Those are the expensive gaps and they're cheap to close.

**Tell it your constraints.** *"No apology in writing." "This has to be a phone call." "I can't
threaten legal action."* Without them you get a move you can't actually execute.

**Push back when it's wrong.** Give it the missing fact. It re-diagnoses instead of defending its
last answer.

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

## Why this isn't another negotiation prompt

**The unit isn't the agreement. It's what is actually happening between the people.** No win-win, no
BATNA. Whose picture of the world is running the room. What is solid and what is hollow. The roles
each side took without noticing. How a position is won or lost move by move.

**It tells you how your moves are actually landing.** You wrote those messages knowing what you
meant by them. It reads them the way the other side read them — which is where most of the useful
information is, and the one thing you can't get at from inside the situation.

**It gives the move, not advice.** Not "be more assertive." The order of the steps, what to ask at
each one and why, what the other will object, and what you say back.

**It refuses to improvise.** Every move rests on a principle from the canon and, where it helps, on a
recorded case. Where the canon is silent, it says so instead of filling the hole with something
plausible.

---

## What's inside

**The canon — 275 principles across 10 domains.** Each one carries its law (the mechanism), when it
applies, how to run it step by step, and real examples. Distilled from 1992 atomic principles pulled
out of 157 live classes — 2.2M words — then consolidated and reconciled. A single entry can merge up
to 50 separate mentions.

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
| Work | 830 | | **A** — dialogue + teaching | 920 |
| Social (neighbours, friends, haters) | 79 | | **B** — scenario + dialogue | 96 |
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
