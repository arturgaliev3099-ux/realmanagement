# Real Management — communication, people management, sales and negotiation

> **v1.0.8** · Claude Code plugin · 275 canon principles · 1019 recorded negotiations · **answers in Spanish**

You give it everything you have on the situation — the actual messages, the history, the numbers,
what you already said out loud. It tells you what is really happening, including the part you left
out about yourself, and gives you the moves.

**It is only as good as what you feed it.** A two-line summary gets you a two-line-summary answer.
See [Getting a real answer out of it](#getting-a-real-answer-out-of-it) below — that section matters
more than anything else in this README.

---

## What it looks like

**You** — dumping the whole thing, not summarising it:

> Client owes me the final payment on a document job. Started in April, was supposed to be two weeks,
> it's been three months. Here's the whole Telegram thread, screenshots attached. Short version: on
> 24 July I proposed we send scans + originals + tracking, then he pays in full — he replied
> *"perfect, let's do that."* On the 29th he threatened to demand a refund. On the 30th he paid €533
> for notary costs. On 1 August I sent a long message saying if he won't honour the 24 July terms we
> stop. On the 3rd I wrote that we'd finish the whole process anyway. He replied with a thumbs up.
> Since then, silence. I still hold the notarised originals and the apostille. The nominee director
> on his German entity is our person. My remaining balance is ~€2,400.

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

Notice what the answer used: the exact date of the *"perfect, let's do that,"* the wording of his
five-word replies, the fact that the ultimatum was withdrawn two days later, who the nominee belongs
to. **None of that survives a summary.** Had the input been *"a client owes me money and won't pay,"*
the answer would have been a lecture on collecting debts.

> Full worked example, start to finish: [`EJEMPLO-NOVATO.md`](skills/negociar/EJEMPLO-NOVATO.md)

---

## Getting a real answer out of it

This is not a prompt that rewards brevity. The diagnosis is reconstruction: it works out what
actually happened from the raw material, and it can only work with material you give it.

**Paste the raw thing, don't retell it.** The actual messages, the thread, the email, the screenshot.
Their exact words matter more than your description of their tone — half the diagnosis comes from how
short their replies are and which of your arguments they ignored.

**Say what already happened out loud.** What you've said in person or on a call, what you already
apologised for, what's already been agreed. Otherwise it will hand you a message repeating things the
other person has heard ten times — the single most common way its answers go wrong.

**Give the timeline and the numbers.** When it started, when each thing was said, how long the
silences were, the amounts, the deadlines. Timing changes the play completely: a reply in the heat of
the moment is a different situation from one that has gone cold, where your silence has already
become a "yes."

**Say who these people really are to each other.** Who depends on whom, who can walk away, who has
alternatives, what each side actually stands to lose. The side that looks weak in your telling is
often the one holding the leverage.

**Say what you actually want** — the money, an apology, to close it quietly, to keep the relationship,
to never deal with them again. And what you're afraid of. Different goals produce genuinely different
moves from the same facts.

**Answer its questions.** It resolves the branches it can and then asks up to three questions — only
the ones that would flip the recommendation. Those are the expensive gaps. Answering them is cheap.

**Push back when it's wrong.** If it misread the situation, say so with the missing fact. It
re-diagnoses instead of defending its previous answer.

**Tell it the constraints.** *"Don't put an apology in writing," "this has to be a phone call,"
"I can't threaten legal action."* Constraints shape the play; without them you'll get a move you
can't actually execute.

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

**The unit is not the agreement, it's what is actually happening between the people.** No win-win,
no BATNA. Whose picture of the world is running the room; what is solid and what is hollow; the
roles each side has taken without noticing; and how a position is won or lost move by move.

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
| Fundamentals of Hard Management | 44 | | Authority and leadership | 34 |
| Social capital and alliances | 30 | | Productivity and habits | 28 |
| Conflict and discipline | 27 | | Role dynamics | 26 |
| Positional negotiation | 25 | | Complex B2B sales | 24 |
| Influence and persuasion | 23 | | Conflicting worldviews | 14 |

**The library — 1019 recorded negotiations.** Live, with the full dialogue and Arti's feedback on
what failed and what would have been stronger. Not invented examples: real people negotiating real
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

- One local script, [`buscar.mjs`](skills/negociar/scripts/buscar.mjs) — 133 lines — which searches
  `casos.json` by keyword.
- It **only reads** its own data files. No writes, no subprocesses, no network.
- **Nothing leaves your machine.** No telemetry, no analytics, no external APIs. Works offline.

133 lines you can read in one sitting. Read them before installing — that's the right habit with any
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
