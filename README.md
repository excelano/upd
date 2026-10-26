# upd

One command that updates every package manager and self-updating tool on a
Debian machine. It runs apt first, then each other package manager and tool
it covers, such as flatpak, rustup, pipx and Claude Code, skipping anything
that is not installed. When it finishes it prints which updates completed
and which failed, so a failure partway through a long run does not scroll
past unnoticed.

## Install

From the Excelano apt repository:

```bash
curl -fsSL https://excelano.com/apt/setup.sh | sudo sh   # one-time
sudo apt install upd
```

Once installed, `upd` updates itself along with everything else from apt.

## Use

```bash
upd
```

It asks for your sudo password for apt and runs unattended after that.
Firmware updates are off by default, because fwupd can stop to ask for
confirmation and a reboot.

## Choosing what runs

`~/.config/upd/config` lists the updates upd runs, one name per line. The
first run writes it with every update upd knows, and with firmware commented
out:

```
apt
flatpak
#fwupd
brew
```

Delete or comment out a line to skip that update, and uncomment `fwupd` to
turn firmware updates on. A package upgrade never touches the file. When an
upgrade adds an update upd knows, it stays off until you add its name; the
names upd recognizes are the ones in a freshly written config, which you get
by moving yours aside and running upd once.
