{ pkgs, ... }:

let
  sdk_9_0_local = pkgs.dotnetCorePackages.sdk_9_0-bin.overrideAttrs (old: {
    postBuild = (old.postBuild or "") + ''
      for p in "$out/sdk"/*; do
        i=$(basename "$p")
        length=$(printf "%s" "$i" | wc -c)
        substring=$(printf "%s" "$i" | cut -c 1-$(expr $length - 2))
        i="$substring""00"
        featureband=$(printf "%s" "$i" | sed "s/-.*//")
        mkdir -p "$out/metadata/workloads/$featureband"
        touch "$out/metadata/workloads/$featureband/userlocal"
      done
    '';
  });
in
{
  cs = pkgs.mkShell {
    packages = with pkgs; [
      sdk_9_0_local
      dotnetCorePackages.runtime_9_0-bin
      dotnetPackages.Nuget
    ];

    shellHook = ''
      echo "C# + MAUI dev shell is ready !"
    '';
  };
}
