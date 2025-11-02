{
  description = "My garden of configurations";

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
    vicinae.url = "github:vicinaehq/vicinae";
    agenix.url = "github:ryantm/agenix";
    hyprland.url = "github:hyprwm/Hyprland";
    nixcord.url = "github:KaylorBen/nixcord";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      lib = nixpkgs.lib.extend (
        self: super: {
          extraMkOptions = import ./lib {
            inherit inputs;
            lib = self;
          };
        }
      );

      secrets = {
        age.secrets = lib.listToAttrs (
          map (name: {
            name = lib.removeSuffix ".age" name;
            value = {
              file = ./secrets/${name};
            };
          }) (lib.attrNames (import ./secrets/secrets.nix))
        );
      };

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      darwinConfigurations = { };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs lib; };
          modules = [
            secrets
            inputs.agenix.nixosModules.default

            ./hosts/desktop/configuration.nix
          ];
        };
      };
      devShells = forAllSystems ({ pkgs, ... }: import ./shells/import.nix { inherit pkgs lib; });
    };
}
