# Copy this to private.nix, then do
# git add --intent-to-add private.nix
# git update-index --assume-unchanged private.nix
{ config, lib, pkgs, ... }:

{
  users.users.myname = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "PASSWORD";
    openssh.authorizedKeys.keys = [
      # put your ssh keys here
    ];
  };
  users.users.root.openssh.authorizedKeys.keys = [
    # put your ssh keys here
  ];
}
