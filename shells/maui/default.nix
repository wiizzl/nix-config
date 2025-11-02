{ pkgs, ... }:

{
  maui = pkgs.mkShell {
    packages = with pkgs; [
      dotnetCorePackages.sdk_9_0-bin
      dotnetCorePackages.runtime_9_0-bin
      dotnetPackages.Nuget
    ];

    # TODO: postinstall MAUI, maybe custom dotnet build ?
    # dotnet workload install maui-android

    shellHook = ''
      echo "C# + MAUI dev shell is ready !"
    '';
  };
}
