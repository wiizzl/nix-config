{ pkgs, ... }:

{
  cs = pkgs.mkShell {
    packages = with pkgs; [
      dotnetCorePackages.dotnet_9.sdk
      dotnetPackages.Nuget
    ];

    shellHook = ''
      echo "C# dev shell is ready !"
    '';
  };
}
