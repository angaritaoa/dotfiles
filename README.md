# Debian
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

# Archlinux

## Install

### Network

```bash
sudo mkdir -p /etc/systemd/network
sudo cp -f systemd/wired.network /etc/systemd/network
```


[Match]
Name=en*

[Network]
DHCP=yes
# Esto habilita DHCPv4 y obtiene automáticamente DNS del router

[DHCP]
UseDNS=yes
UseDomains=yes
UseHostname=yes

```bash
sudo nvim /etc/systemd/resolved.conf
```

[Resolve]
# Dejar DNS vacío para que use los del DHCP
DNS=
FallbackDNS=8.8.8.8 8.8.4.4 1.1.1.1
# Los fallback solo se usan si no hay DNS del DHCP

Domains=~.
LLMNR=no
MulticastDNS=no
DNSSEC=allow-downgrade
DNSOverTLS=no
Cache=yes
DNSStubListener=yes

```bash
# Eliminar el resolv.conf actual
sudo rm /etc/resolv.conf

# Crear enlace simbólico al stub de systemd-resolved
sudo ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

```bash
# Habilitar systemd-networkd
sudo systemctl enable systemd-networkd.service

# Habilitar systemd-resolved
sudo systemctl enable systemd-resolved.service

# Iniciar ambos servicios
sudo systemctl start systemd-networkd.service
sudo systemctl start systemd-resolved.service
```

Verificar

```bash
# Estado de networkd
systemctl status systemd-networkd

# Estado de resolved
systemctl status systemd-resolved
```

Verificar

```bash
# Ver direcciones IP asignadas
ip addr show

# Ver servidores DNS actuales
resolvectl status

# O alternativamente
systemd-resolve --status


# Prueba básica
dig google.com

# O usando resolvectl
resolvectl query google.com
```


