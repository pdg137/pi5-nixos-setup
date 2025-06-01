This repository shows how to install NixOS on a Raspberry Pi 5 using a
minimal configuration for the
[nixos-raspberrypi](https://github.com/nvmd/nixos-raspberrypi) flake
configuration by [nvmd](https://github.com/nvmd).

My flake.nix comes from
[nixos-raspberrypi-demo](https://github.com/nvmd/nixos-raspberrypi-demo)
with modifications for simplicity.

I don't know what I'm doing here and writing it up clearly is a way
for me to learn.

## Prerequisites

* nix with flakes and cross-compilation enabled - put this in `/etc/nix/nix.conf`:
  ```
  sandbox = false
  extra-platforms = aarch64-linux
  experimental-features = nix-command flakes
  ```
* zstd (you can run `nix-shell -p zstd` for example)
* [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
* 8GB+ microSD card

## Installing via microSD

1. `nix build .#installerImages`
3. `zstd -d result/sd-image/nixos-installer-rpi5-kernelboot.img.zst -o nixos-installer-rpi5-kernelboot.img`
4. Load file in Raspberry Pi Imager
5. (Why can't we configure config.txt settings here?)
6. Write image to microSD card
7. Insert card into Raspberry Pi 5 and boot

## Initial configuration

1. For WiFi, run `iwctl`, then `station wlan0 connect <networkname>`
   where `<networkname>` is the name of your wireless network.
2. Exit `iwct`.
3. Set a root password with `passwd`.
4. Log back out to see the IP address.
5. Make sure you can connect with `ssh root@<ip>`.

## Configuration setup

1. Clone this repository.
2. Copy `private_template.nix` to `private.nix` and edit with your private user configuration.
3. Run these weird commands to make flakes work without having to add private.nix (!!!):
   ```
   git add --intent-to-add private.nix
   git update-index --assume-unchanged private.nix
   ```
4. Edit config as desired.

## Loading this nixos configuration

1. `nixos-rebuild switch --flake .#rpi5 --target-host root@<ip>`
2. Enter your root password twice.
3. When it says "Done" you can reboot and everything will be configured as specified.

Note: you can also run

```
nix build .#nixosConfigurations.rpi5.config.system.build.toplevel
```

to build the system as a `result` link. This might be useful, for
example, to prevent it from getting garbage collected between builds.

## TODO

* Desktop environments - I can't figure out how to get these to build now.
