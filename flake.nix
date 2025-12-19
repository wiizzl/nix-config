{
  description = "My garden of configurations";

  nixConfig = {
    trusted-extra-substituters = [
      "https://hyprland.cachix.org"
      "https://vicinae.cachix.org"
    ];
    trusted-extra-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    agenix.url = "github:ryantm/agenix";
    nixcord.url = "github:KaylorBen/nixcord";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    vicinae.url = "github:vicinaehq/vicinae";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib.extend (
        self: super: {
          extraMkOptions = import ./lib {
            inherit inputs;
            lib = self;
          };
        }
      );

      secrets = host: {
        age.secrets = lib.listToAttrs (
          map (name: {
            name = lib.removeSuffix ".age" name;
            value = {
              file = ./hosts/${host}/secrets/${name};
            };
          }) (lib.attrNames (import ./hosts/${host}/secrets/secrets.nix))
        );
      };

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkNixosConfig =
        host: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs lib host; };
          modules = [
            (secrets host)
            inputs.agenix.nixosModules.default
            ./hosts/${host}/configuration.nix
          ];
        };
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
      templates = import ./shells; # see https://github.com/the-nix-way/dev-templates
      darwinConfigurations = { }; # TODO: add Darwin hosts here
      nixosConfigurations = {
        desktop = (mkNixosConfig "desktop" "x86_64-linux");
        vivobook = (mkNixosConfig "vivobook" "x86_64-linux");
      };
    };
}
