# Security Policy

## Reporting a vulnerability

Please report suspected vulnerabilities privately through GitHub Security Advisories at https://github.com/excelano/upd/security/advisories/new. If you would rather not use GitHub, email david.anderson@excelano.com instead. I aim to respond within seven days.

Please do not open public issues for security problems.

## Supported versions

Security fixes ship in a new package version, which `upd` installs along with everything else from apt. There are no maintained release branches; only the latest version is supported.

## What upd does

upd is a shell script that runs each package manager's own update commands, in turn, as the user who started it. It downloads nothing itself and makes no network connection of its own: what reaches the network is apt, flatpak, Homebrew, rustup and the other tools it calls, from the sources each is already configured to trust. It runs no daemon and sends no telemetry.

**sudo is used for apt alone.** `sudo apt update`, `full-upgrade` and `autoremove` are the only commands run with elevated rights; every other update runs unprivileged.

**The config file decides what runs, and is matched by name.** Each line of `~/.config/upd/config` is compared whole against the names upd knows; a line is never executed, so editing the file can turn an update on or off but cannot add a command.

## What upd writes

Only `~/.config/upd/config`, on the first run. Everything else on disk is changed by the package managers it calls.
