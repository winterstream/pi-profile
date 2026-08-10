# pi-profile

A native Pi meta-package for the external skills, extensions, and packages used
in my workflow.

`pi-profile` contains package metadata only. It does not copy package contents,
manage `~/.pi/agent/skills`, or manage `agent-stuff`.

## Install

Install the profile globally with Pi:

```sh
pi install git:github.com/winterstream/pi-profile@main
```

For a local checkout while developing the profile:

```sh
npm ci
pi install "$PWD"
```

Pi installs the profile's pinned dependencies and loads their resources from the
profile package root. The profile's external package pins are maintained in
`package.json` and `package-lock.json`.

## Local agent-stuff

Private, frequently edited resources are intentionally separate from this
package. Clone `winterstream/agent-stuff`, then run its setup command:

```sh
git clone git@github.com:winterstream/agent-stuff.git ~/.pi/agent-stuff
~/.pi/agent-stuff/scripts/setup
```

The setup command links the checkout's skills, extensions, themes, and prompt
commands into the global Pi resource directories. Changes made through those
links modify the `agent-stuff` checkout directly; they can be reviewed and
published with its JJ workflow.

Set `PI_AGENT_STUFF_DIR` to use a different checkout location. Set
`PI_CODING_AGENT_DIR` to use a different Pi state directory.

## Updating external packages

Review upstream changes explicitly, then update the dependency specification and
lockfile:

```sh
npm install --package-lock-only --ignore-scripts
npm ci --ignore-scripts --omit=dev
```

GitHub dependencies are pinned to commit-specific HTTPS tarballs. Review source
changes before updating those pins. Pi packages execute with full process
access; review third-party extensions before installing them.

## Home Manager

Home Manager may run the same `pi install` command during activation as a
convenience. It should manage Pi and stable settings, not local `agent-stuff`
resources or package materialization.
