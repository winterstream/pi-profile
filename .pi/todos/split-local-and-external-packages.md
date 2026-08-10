# Split local and external Pi resources

Track the migration so `agent-stuff` remains mutable and portable while external
resources use Pi's native package manager.

## 1. Local `agent-stuff` source

- [x] Add a portable `agent-stuff` setup command.
  - [x] Support `PI_AGENT_STUFF_DIR` and a portable default checkout location.
  - [x] Clone the repository when the checkout is absent.
  - [x] Refuse to overwrite unrelated existing resource directories without a
        backup.
  - [x] Create `~/.pi/agent/skills -> <agent-stuff>/skills`.
  - [x] Create `~/.pi/agent/extensions -> <agent-stuff>/extensions`.
  - [x] Install or verify runtime dependencies required by local extensions.
- [x] Decide whether `themes` and `prompts` also need local symlinks; both are
      linked (`prompts` maps to `commands`).
- [x] Migrate the existing profile-managed skill links and extension wrappers
      safely.
- [x] Verify edits made through `~/.pi/agent/skills` and
      `~/.pi/agent/extensions` appear in the `agent-stuff` repository.

## 2. Source-aware editing and publishing

- [x] Update `agent-stuff/AGENTS.md` with symlink/source-of-truth guidance.
- [x] Update task-observer authoring guidance so in-place edits through the Pi
      symlinks are treated as repository edits while retaining staged skill
      delivery.
- [x] Document that Pi runtime state remains outside `agent-stuff` and must not
      be committed.
- [x] Document the explicit publish workflow:
  - [x] Inspect the `agent-stuff` JJ status and complete diff.
  - [x] Exclude unrelated changes.
  - [x] Run relevant checks.
  - [x] Set a concise JJ commit description.
  - [x] Move `main` to the intended change.
  - [x] Push `main` to `origin`.

## 3. Convert `pi-profile` to a native meta-package

- [x] Add a native Pi-installable `package.json` for `pi-profile`.
- [x] Declare only external skills, extensions, and packages with reproducible
      pins.
- [x] Remove `agent-stuff` from the external package set.
- [x] Use the native package lock/provenance mechanism instead of custom profile
      state.
- [x] Verify that Pi installs and resolves resources from nested package
      dependencies.
- [x] Remove custom resource materialization and reconciliation scripts.
- [x] Remove generated profile state and obsolete package-source machinery.
- [x] Update the README with native `pi install` and external-package usage.

## 4. Simplify Home Manager

- [x] Remove Home Manager ownership of `agent-stuff`.
- [x] Remove the mutable Pi repository configuration used for profile
      application.
- [x] Configure Home Manager to run `pi install` for the external `pi-profile`
      package.
- [x] Keep Home Manager responsible only for Pi, stable settings, and optional
      installation convenience.
- [x] Ensure Home Manager does not clean, materialize, or replace the local
      skills/extensions symlinks.
- [x] Preserve unrelated Home Manager working-copy changes.

## 5. External package workflow

- [x] Verify external packages install through `pi-profile` without appearing in
      the local skills/extensions directories.
- [x] Verify individual external packages can still be installed directly with
      `pi install`.
- [x] Confirm Pi resolves external package resources from its normal Git/npm
      package roots.
- [x] Confirm local and external resources do not load twice.

## 6. Validation and migration

- [x] Test local setup from a clean non-Nix Pi directory.
- [x] Test local skill/extension edits through the symlinks.
- [x] Test Pi startup with no duplicate-extension or broken-relative-import
      warnings.
- [x] Verify expected skills and extensions through Pi's resolver.
- [x] Run `pi list` and relevant package-install checks.
- [x] Run `nix flake check --no-build --impure`.
- [x] Run
      `home-manager switch --flake ~/.config/home-manager#wynand-mac -b backup --show-trace`.
- [x] Review final diffs in `agent-stuff`, `pi-profile`, and Home Manager.
- [ ] Push the Home Manager change to `origin` once its configured SSH remote is
      reachable.

## Current external blocker

Home Manager's configured `origin` is
`ssh://wynand@winterzwaen.org:54321/~/.config/home-manager`; two push attempts
failed with `Network is unreachable`. The local `main` bookmark is already at
the completed change `bad2e3cf`.
