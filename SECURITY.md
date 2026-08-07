# Security

## Reporting a vulnerability

Report privately through GitHub's **[Report a vulnerability](https://github.com/arturgaliev3099-ux/realmanagement/security/advisories/new)**
button, not through a public issue. That keeps the details out of sight until there is a fix.

If private reporting is unavailable, write to the author on
[Instagram](https://instagram.com/arti_galiev).

## What this plugin does on your machine

Installing a plugin means running someone else's code. Here is the whole surface:

**At runtime — one script.** [`skills/negociar/scripts/buscar.mjs`](skills/negociar/scripts/buscar.mjs),
133 lines of plain Node. It searches `casos.json` by keyword and prints matches.

- **Reads only** — `readFileSync`, `existsSync`, `readdirSync`, all against files inside the plugin
  directory. It writes nothing, spawns no subprocess, opens no socket.
- The rest of the plugin is Markdown and one JSON data file.

**At install time — only if you run the installer.** [`install.sh`](install.sh) and
[`install.ps1`](install.ps1) are optional; the Claude Code plugin manager does not use them. If you
do run one:

- It writes **only** inside the install directories it reports before starting —
  `~/.claude/skills/negociar/` and `~/.codex/skills/negociar/`, or the `.claude/` and `.agents/`
  equivalents under a `--target` project. It replaces that one folder and touches no other skill.
- It runs [`scripts/postinstall.mjs`](scripts/postinstall.mjs), which edits `SKILL.md` **inside the
  copy it just made** — rewriting the plugin-root placeholder to an absolute path and, for Codex,
  shortening the description. Nothing outside the install directory is modified.
- **The one-liner (`curl … | bash`, `irm … | iex`) clones this repo** over HTTPS into a temp folder
  and deletes it afterwards. That is the only network access anywhere in this project. Installing
  from a clone you already have makes no network call at all. If piping a remote script into a shell
  isn't a habit you want, clone the repo, read `install.sh`, and run it locally.

**No network at runtime.** No telemetry, no analytics, no external API. The skill itself works with
the machine offline. **No dependencies** — there is no `package.json` and nothing is installed from
npm.

You can verify all of this by reading the scripts in one sitting. Please do — that is the right habit
with any plugin, this one included.

## Integrity of what you install

- Commits are **signed**. An unsigned commit on `main` is a red flag; check the *Verified* badge.
- `main` is protected: force pushes and deletions are blocked.
- Only the repository owner can write. Pull requests are not merged — fork and maintain your own copy
  instead, as the licence allows.

## Data in this repository

The 1019 cases come from recorded training sessions. Participants appear as *Participante A/B/C*,
relabelled independently in every case, so no individual's path can be reconstructed across the
corpus. If you believe something in here identifies you, use the private reporting channel above and
it will be removed.
