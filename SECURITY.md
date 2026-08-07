# Security

## Reporting a vulnerability

Report privately through GitHub's **[Report a vulnerability](https://github.com/arturgaliev3099-ux/realmanagement/security/advisories/new)**
button, not through a public issue. That keeps the details out of sight until there is a fix.

If private reporting is unavailable, write to the author on
[Instagram](https://instagram.com/arti_galiev).

## What this plugin does on your machine

Installing a plugin means running someone else's code. Here is the whole surface:

- **One script**, [`skills/negociar/scripts/buscar.mjs`](skills/negociar/scripts/buscar.mjs), 133
  lines of plain Node. It searches `casos.json` by keyword and prints matches.
- **Reads only** — `readFileSync`, `existsSync`, `readdirSync`, all against files inside the plugin
  directory. It writes nothing, spawns no subprocess, opens no socket.
- **No network.** No telemetry, no analytics, no external API. It works with the machine offline.
- **No dependencies.** There is no `package.json` and nothing is installed from npm.
- The rest of the plugin is Markdown and one JSON data file.

You can verify all of this by reading the script in one sitting. Please do — that is the right habit
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
