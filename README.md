# Workflow
## Install

```bash
sudo apt install make curl
ssh-add /mnt/archivos/config/ssh/github
git clone git@github.com:angaritaoa/dotfiles.git
cd dotfiles
cp -f bash/bashrc ~/.bashrc
make debian
make
```

## inotify

```bash
inotifywait -m -e modify,create,move --format '%w%f -> %e' ~/.config/
```

## dconf

```bash
dconf watch /
```
