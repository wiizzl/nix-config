# nix-config

![Workflow status](https://github.com/wiizzl/nix-config/actions/workflows/flake-check.yml/badge.svg)
![Workflow status](https://github.com/wiizzl/nix-config/actions/workflows/flake-updater.yml/badge.svg)

This is my Nix configuration files. Much inspired by configurations found online.

## My Journey into declarative systems

After using Fedora for a while, I really thought I had found the perfect distribution for my needs. I was using GNOME and was very satisfied with my experience — everything just worked without having to fuss around too much.

But one day, when I wanted to reproduce my setup on another machine, it took me quite a bit of time (setting up RPM Fusion, installing my applications, etc.). That’s when I decided I wanted to automate the setup of my configuration from a fresh Fedora image.

I started by writing simple bash scripts — which was quite annoying — and eventually discovered Ansible, which turned out to be incredibly handy. It made my configuration process a lot simpler, even if far from perfect since I was just getting started with Ansible. This [configuration](https://github.com/wiizzl/fedora-setup) served me for a while, until I heard about NixOS through [tony's video](https://www.youtube.com/watch?v=2QjzI5dXwDY).

That’s when I started using NixOS, first with Qtile, which was my very first experience with a tiling window manager. I loved it! GNOME instantly felt far behind. I spent a lot of time configuring and exploring NixOS — not only the ability to make the system declarative, but also every single application configuration. Later, I moved on to i3, and then to Hyprland because I absolutely love animations. Yep, I'm like a kid.

## TODO

- Secrets management with [agenix](https://github.com/ryantm/agenix)
- Config [templates](./hosts/templates)
- Darwin modules

## Modules

The repository is split into several module types.

- [NixOS modules](https://github.com/wiizzl/nix-config/tree/main/modules/nixos): System configurations tailored for NixOS.
- [Home modules](https://github.com/wiizzl/nix-config/tree/main/modules/home): User-specific setups managed by [home-manager](https://github.com/nix-community/home-manager).
- [Darwin modules](https://github.com/wiizzl/nix-config/tree/main/modules/darwin): macOS system configurations using [nix-darwin](https://github.com/nix-darwin/nix-darwin).
- [Shared modules](https://github.com/wiizzl/nix-config/tree/main/modules/shared): Common settings for both NixOS and Darwin platforms.

Each module group contains an `import.nix` file at its root, which automatically locates and imports all `default.nix` files within its directory tree. These imports are referenced in the `configuration.nix` file for each host.

Modules are off by default and can be activated by setting options such as `type.name.enable = true;`.

The repository uses a modular, opinionated structure. While it may seem complex initially, this organization makes it straightforward to reuse existing modules or add support for new hosts.

## Layout

```
├── wallpapers/      # Image files for wallpapers
├── hosts/
│   ├── templates/   # Template hosts so you can see all available options
│   └── desktop/     # Main desktop setup
├── flake.nix
├── flake.lock
├── lib/             # Custom functions extending `nixpkgs.lib`
├── shells/          # Development shell environments
└── modules/
  ├── darwin/        # macOS-specific apps, system tweaks, CLI utilities
  ├── home/          # home-manager modules for user apps, desktops, CLI tools
  ├── nixos/         # NixOS modules for apps, desktops, services, system configs
  └── shared/        # Modules shared by NixOS and macOS (aliases, fonts, CLI utilities)
```

## Installation

### 1. Create your host and edit `flake.nix`

```sh
mkdir -p ~/nix-config/hosts/your-host
```

> [!TIP]
> Replace `your-host` with a short alias for your device.

```sh
nano ~/nix-config/flake.nix
```

```nix
nixosConfigurations = {
  nixos = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs lib; };
    modules = [ ./hosts/your-host/configuration.nix ];
  };
};
```

> [!IMPORTANT]
> Replace "x86_64-linux" with your system architecture. Make sure it is supported first!

### 2. Edit the configuration based on your needs

```sh
nano ~/nix-config/hosts/your-host/configuration.nix
```

> [!TIP]
> You will need to explore the configuration to understand how to add your own things.

### 3. Generate hardware-configuration.nix and move it yo your host

> [!NOTE]
> You can skip this step if you are not on NixOS.

```sh
nixos-generate-config # You probably need to sudo it
cp /etc/nixos/hardware-configuration.nix ~/nix-config/hosts/your-host/
```

### 4. Build the configuration and reboot your device
