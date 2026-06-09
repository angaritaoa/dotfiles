# Workflow
## Install

```bash
sudo apt install make curl
ssh-add /mnt/archivos/config/ssh/github
git clone git@github.com:angaritaoa/dotfiles.git
cd dotfiles
cp -f bash/bashrc ~/.bashrc
cp -f plasma/* ~/.config
mkdir -p ~/.local/share/konsole
cp -f plasma/konsole/* ~/.local/share/konsole
make debian
make
sudo reboot
```

## inotify

```
inotifywait -m -e modify,create,move --format '%w%f -> %e' ~/.config/
```
