# Security Policy

## Reporting a vulnerability

Please report suspected vulnerabilities privately, using the **Report a vulnerability** button on the Security tab of the repository concerned. If that button is not there, or you would rather not go through GitHub, email david.anderson@excelano.com instead. I aim to respond within seven days.

Please do not open public issues for security problems.

## Supported versions

The latest release receives security fixes. Older versions are not supported. A fix ships in a new release; update the way you installed.

## What upd can access

upd is a shell script that runs each package manager's own update commands, in turn, as the user who started it. It downloads nothing itself and makes no network connection of its own: what reaches the network is apt, flatpak, Homebrew, rustup and the other tools it calls, from the sources each is already configured to trust. It runs no daemon and sends no telemetry.

**sudo is used for apt alone.** `sudo apt update`, `full-upgrade` and `autoremove` are the only commands run with elevated rights; every other update runs unprivileged.

**The config file decides what runs, and is matched by name.** Each line of the config file (`$XDG_CONFIG_HOME/upd/config`, by default `~/.config/upd/config`) is compared whole against the names upd knows; a line is never executed, so editing the file can turn an update on or off but cannot add a command.

## What upd stores

Only its config file, on the first run. Everything else on disk is changed by the package managers it calls.
