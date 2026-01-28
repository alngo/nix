{ pkgs, inputs,  ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};

    users.alngo = { 
      imports = [
        inputs.nixvim.homeModules.nixvim
        ./alngo/home.nix
      ];

      home.username = "alngo";
      home.homeDirectory = "/home/alngo";
      home.stateVersion = "25.11";
      programs.home-manager.enable = true;
    };
  };
}
