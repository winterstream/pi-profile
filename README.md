# pi-profile

Portable Pi configuration for the skills, extensions, and packages used in my
workflow.

This repository is a **control plane**, not a copy of the package contents.
Private skills and extensions remain in
[`winterstream/agent-stuff`](https://github.com/winterstream/agent-stuff); the
other resources remain in their upstream repositories.

## Contents

- `profile.json` — canonical package list, resource filters, provenance, and
  edit policy.
- `profile.lock.json` — exact Git revisions and npm versions used for
  reproducible installs.
- `.pi/settings.json` — generated project-local Pi settings for testing this
  profile.
- `scripts/apply` — install the locked packages into the global Pi profile
  without replacing unrelated settings.
- `scripts/update` — refresh Git pins and validate npm pins.
- `scripts/check` — validate the manifest and generated settings.

## Project-local use

Clone this repository, install Pi by any supported method, then run Pi from the
checkout:

```sh
git clone git@github.com:winterstream/pi-profile.git
cd pi-profile
./scripts/check
pi
```

Pi will ask you to trust the project before loading `.pi/settings.json` and
installing its project-local packages.

## Global use

To make the profile available from unrelated workspaces, apply it to the
machine's global Pi settings:

```sh
./scripts/apply
```

The apply script manages only the package entries recorded in its own state
file. It preserves credentials, models, sessions, and unrelated settings.

Use `./scripts/apply --dry-run` to inspect the planned changes first.

## Updating

Review package updates explicitly:

```sh
./scripts/update
./scripts/check
git diff -- profile.lock.json .pi/settings.json
```

Git packages are pinned to commit revisions. Extensions execute with full
process access, so review upstream changes before applying updated pins.

## Platform-specific setup

The profile intentionally does not contain Nix, Home Manager, tmux binaries,
Hammerspoon configuration, credentials, or other machine-specific state. Those
can be installed by an optional platform bootstrap while this repository remains
the portable Pi layer.
