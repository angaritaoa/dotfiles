# Workflow
## Install

```bash
sudo apt install make curl
git clone git@github.com:angaritaoa/dotfiles.git
cd dotfiles
cp -f bash/bashrc ~/.bashrc
cp -f plasma/* ~/.config
make debian
make
sudo reboot
```

## inotify

```
inotifywait -m -e modify,create,move --format '%w%f -> %e' ~/.config/
```
