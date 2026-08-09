# pi-profile instructions

- `profile.json` is the canonical package and provenance manifest.
- `profile.lock.json` pins the exact Git revisions and npm versions; update it
  through `scripts/update` rather than editing it by hand.
- `.pi/settings.json` is generated from the lockfile for project-local smoke
  testing. Run `scripts/check` after changing the manifest or lockfile.
- Keep package contents in their source repositories. Add profile-specific
  resources here only when they belong to the profile itself.
- `scripts/apply` may reconcile only package entries owned by this profile; it
  must preserve credentials, models, sessions, and unrelated Pi settings.
- Never commit credentials, session files, machine-specific absolute paths, or
  generated package checkouts.
