{ pkgs, ... }:

{
  cs =
    let
      script = ''
        ls "$out"
        for i in $out/share/dotnet/sdk/*
        do
          i=$(basename $i)
          length=$(printf "%s" "$i" | wc -c)
          substring=$(printf "%s" "$i" | cut -c 1-$(expr $length - 2))
          i="$substring""00"

          echo $i

          mkdir -p $out/share/dotnet/metadata/workloads/''${i/-*}
          touch $out/share/dotnet/metadata/workloads/''${i/-*}/userlocal
        done
      '';

      sdkOverride = (
        finalAttrs: previousAttrs: {
          src = (
            previousAttrs.src.overrideAttrs (
              finalAttrs: previousAttrs: {

                postBuild = (previousAttrs.postBuild or '''') + script;
              }
            )
          );
        }
      );

      dotnet-full = (
        with pkgs.dotnetCorePackages;
        combinePackages [
          (sdk_9_0.overrideAttrs sdkOverride)
          (sdk_8_0.overrideAttrs sdkOverride)
        ]
      );

    in
    pkgs.mkShell {
      packages = [
        dotnet-full
      ];

      DOTNET_PATH = "${dotnet-full}/bin/dotnet";
      DOTNET_ROOT = "${dotnet-full}/share/dotnet";

      shellHook = ''
        echo "C# dev shell is ready !"
      '';
    };
}
