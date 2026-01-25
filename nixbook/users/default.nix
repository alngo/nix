{ pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.alngo = { 
      imports = [ ./alngo/home.nix ];

      home.username = "alngo";
      home.homeDirectory = "/home/alngo";
      home.stateVersion = "25.11";
      programs.home-manager.enable = true;
    };
  };
}
