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
