# pi-profile instructions

- `package.json` is the canonical Pi meta-package manifest.
- `package-lock.json` is the native npm lockfile; update it with npm rather than
  hand-editing it.
- `agent-stuff` is intentionally not a dependency of this profile. It is a
  separate mutable local checkout.
- Keep external package resources in their package roots. Do not add scripts
  that materialize or reconcile resources under `~/.pi/agent`.
- Use `npm install --package-lock-only --ignore-scripts` for dependency-pin
  changes, then run `npm ci --ignore-scripts --omit=dev` and Pi resolver checks.
- Never commit credentials, session files, machine-specific absolute paths,
  generated package checkouts, or `node_modules`.
