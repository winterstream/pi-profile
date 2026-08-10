# Split local and external Pi resources

Track the migration so `agent-stuff` remains mutable and portable while external resources use Pi's native package manager.

## 1. Local `agent-stuff` source

- [ ] Add a portable `agent-stuff` setup command.
  - [ ] Support `PI_AGENT_STUFF_DIR` and a portable default checkout location.
  - [ ] Clone the repository when the checkout is absent.
  - [ ] Refuse to overwrite unrelated existing resource directories without a backup.
  - [ ] Create `~/.pi/agent/skills -> <agent-stuff>/skills`.
  - [ ] Create `~/.pi/agent/extensions -> <agent-stuff>/extensions`.
  - [ ] Install or verify runtime dependencies required by local extensions.
- [ ] Decide whether `themes` and `prompts` also need local symlinks.
- [ ] Migrate the existing profile-managed skill links and extension wrappers safely.
- [ ] Verify edits made through `~/.pi/agent/skills` and `~/.pi/agent/extensions` appear in the `agent-stuff` repository.

## 2. Source-aware editing and publishing

- [ ] Update `agent-stuff/AGENTS.md` with symlink/source-of-truth guidance.
- [ ] Update task-observer authoring guidance so in-place edits through the Pi symlinks are treated as repository edits.
- [ ] Document that Pi runtime state remains outside `agent-stuff` and must not be committed.
- [ ] Document the explicit publish workflow:
  - [ ] Inspect the `agent-stuff` JJ status and diff.
  - [ ] Exclude unrelated changes.
  - [ ] Run relevant checks.
  - [ ] Set a concise JJ commit description.
  - [ ] Move `main` to the intended change.
  - [ ] Push `main` to `origin`.

## 3. Convert `pi-profile` to a native meta-package

- [ ] Add a native Pi-installable `package.json` for `pi-profile`.
- [ ] Declare only external skills, extensions, and packages with reproducible pins.
- [ ] Remove `agent-stuff` from the external package set.
- [ ] Use the native package lock/provenance mechanism instead of custom profile state.
- [ ] Verify that Pi installs and resolves resources from nested package dependencies.
- [ ] Remove custom resource materialization and reconciliation scripts.
- [ ] Remove generated profile state and obsolete package-source machinery.
- [ ] Update the README with native `pi install` and external-package usage.

## 4. Simplify Home Manager

- [ ] Remove Home Manager ownership of `agent-stuff`.
- [ ] Remove the mutable Pi repository configuration used for profile application.
- [ ] Configure Home Manager to run `pi install` for the external `pi-profile` package.
- [ ] Keep Home Manager responsible only for Pi, stable settings, and optional installation convenience.
- [ ] Ensure Home Manager does not clean, materialize, or replace the local skills/extensions symlinks.
- [ ] Preserve unrelated Home Manager working-copy changes.

## 5. External package workflow

- [ ] Verify external packages install through `pi-profile` without appearing in the local skills/extensions directories.
- [ ] Verify individual external packages can still be installed directly with `pi install`.
- [ ] Confirm Pi resolves external package resources from its normal Git/npm package roots.
- [ ] Confirm local and external resources do not load twice.

## 6. Validation and migration

- [ ] Test local setup from a clean non-Nix Pi directory.
- [ ] Test local skill/extension edits through the symlinks.
- [ ] Test Pi startup with no duplicate-extension or broken-relative-import warnings.
- [ ] Verify expected skills and extensions through Pi's resolver.
- [ ] Run `pi list` and relevant package-install checks.
- [ ] Run `nix flake check --no-build --impure`.
- [ ] Run `home-manager switch --flake ~/.config/home-manager#wynand-mac -b backup --show-trace`.
- [ ] Review final diffs in `agent-stuff`, `pi-profile`, and Home Manager.
- [ ] Commit and push each repository separately using its repository-specific JJ workflow.
