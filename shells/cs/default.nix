{
  pkgs,
  android-nixpkgs,
  lib,
  ...
}:

let
  # Credit @anpin
  # https://github.com/anpin/maui-on-nix/blob/main/shell.nix

  android-sdk = android-nixpkgs.sdk.${pkgs.stdenv.hostPlatform.system} (
    sdkPkgs: with sdkPkgs; [
      build-tools-35-0-0
      build-tools-34-0-0
      cmdline-tools-latest
      emulator
      platform-tools
      platforms-android-35
      platforms-android-34
    ]
  );

  # This is needed to install workload in $HOME
  # https://discourse.nixos.org/t/dotnet-maui-workload/20370/2
  userlocal = ''
    for i in $out/sdk/*; do
      i=$(basename $i)
      length=$(printf "%s" "$i" | wc -c)
      substring=$(printf "%s" "$i" | cut -c 1-$(expr $length - 2))
      i="$substring""00"
      mkdir -p $out/metadata/workloads/''${i/-*}
      touch $out/metadata/workloads/''${i/-*}/userlocal
    done
  '';

  postInstallUserlocal = (
    finalAttrs: previousAttrs: {
      postInstall = (previousAttrs.postInstall or '''') + userlocal;
    }
  );

  dotnet-combined = pkgs.dotnetCorePackages.sdk_9_0.overrideAttrs postInstallUserlocal;
in
{
  cs = pkgs.mkShell {
    packages = with pkgs; [
      dotnet-combined
      android-sdk
      gradle
      jdk17
      aapt
      llvm_18
    ];

    DOTNET_ROOT = "${dotnet-combined}";
    ANDROID_HOME = "${android-sdk}/share/android-sdk";
    ANDROID_SDK_ROOT = "${android-sdk}/share/android-sdk";
    JAVA_HOME = pkgs.jdk17.home;

    # make sure you have `cli.nix-ld = enabled;` in your host config
    NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      (lib.getLib pkgs.llvm_18)
      (lib.getLib pkgs.glibc)
    ];

    NIX_LD = pkgs.runCommand "ld.so" { } ''
      ln -s "$(cat '${pkgs.stdenv.cc}/nix-support/dynamic-linker')" $out
    '';

    shellHook = ''
      echo "C# + MAUI dev shell is ready !"
    '';
  };
}
