{
  description = "A simple modpack.";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.minecraft = {
    url = "github:Ninlives/minecraft.nix";
    inputs.metadata.follows = "minecraft-metadata";
  };
  inputs.minecraft-metadata.url = "github:Ninlives/minecraft.json";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, minecraft, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      modded = (side:
        (minecraft.legacyPackages.${system}.v1_20_1.fabric.${side}.withConfig [{
          mods = [
            (fetchurl {
              # file name must have a ".jar" suffix to be loaded by fabric
              name = "fabric-api.jar";
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/1sf8i9fy/fabric-api-0.89.0%2B1.20.1.jar";
              hash = "sha256-phvkSyGN6Yr1jq07qGcsC22ZG5WkQCCLUh5uW9pFsOc=";
            })

            (fetchurl {
              # CC:Tweaked
              url = "https://cdn.modrinth.com/data/gu7yAYhd/versions/s6Ov3R0y/cc-tweaked-1.20.1-fabric-1.108.1.jar";
              hash = "sha256-mWGdPIcuDBT4p88UPPxhO+9Ha759oBJnj9B65JecRk0=";
            })

            # currently incompatible with Sodium 5
            # (fetchurl {
            #   # Create
            #   url = "https://cdn.modrinth.com/data/Xbc0uyRg/versions/qlA1WuOK/create-fabric-0.5.1-d-build.1161%2Bmc1.20.1.jar";
            #   hash = "sha256-c7mBDzuY0Xjqnj0QG46gAPDD92Kcn9Ol5sAXdn7LRhQ=";
            # })

            # hasn't been updated for 1.20 yet
            # (fetchurl {
            #   # Phosphor
            #   url = "https://cdn.modrinth.com/data/hEOCdOgW/versions/mc1.18.x-0.8.1/phosphor-fabric-mc1.18.x-0.8.1.jar";
            #   hash = "";
            # })

            (fetchurl {
              # Lithium
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/ZSNsJrPI/lithium-fabric-mc1.20.1-0.11.2.jar";
              hash = "sha256-oMWVNV1oDgyHv46uuv7f9pANTncajWiU7m0tQ3Tejfk=";
            })

            (fetchurl {
              # Sodium
              url = "https://cdn.modrinth.com/data/AANobbMI/versions/4OZL6q9h/sodium-fabric-mc1.20.1-0.5.3.jar";
              hash = "sha256-sQ5guAABlLxhf9LDlqhYSlzDOjEYyLOCEoRSw/k/iB0=";
            })

            (fetchurl {
              # Indium
              url = "https://cdn.modrinth.com/data/Orvt0mRa/versions/Lue6O9z9/indium-1.0.27%2Bmc1.20.1.jar";
              hash = "sha256-l4mpPxrrI1101U326Bo3Gq8VzRqYBfaNHPrb30vpk2E=";
            })

            (fetchurl {
              # Immediately Fast
              url = "https://cdn.modrinth.com/data/5ZwdcRci/versions/cswW9vJQ/ImmediatelyFast-1.2.5%2B1.20.2.jar";
              hash = "sha256-qD31nvq8R7tG6kmSyUZhvo5m0LgLtF+QG2GWN5hHYLA=";
            })

            (fetchurl {
              # Mod menu
              url = "https://cdn.modrinth.com/data/mOgUt4GM/versions/lEkperf6/modmenu-7.2.2.jar";
              hash = "sha256-oEGw8DBf+l65ASCqI3aOHPuydYOQSxdR43g8D2k4Lxo=";
            })

            (fetchurl {
              # Moonlight Lib
              url = "https://cdn.modrinth.com/data/twkfQtEc/versions/pglf5GDl/moonlight-1.20-2.8.18-fabric.jar";
              hash = "sha256-A9a6BHS+XeAQTbrOT+8oIdGITKLOUleP24PKGsexFl8=";
            })

            (fetchurl {
              # Supplementaries
              url = "https://cdn.modrinth.com/data/fFEIiSDQ/versions/UYfKyS1v/supplementaries-1.20-2.6.2-fabric.jar";
              hash = "sha256-/d6jwp3Frk1jrEioKXqIzdCiFP1GUUSgxakuGHXeaSo=";
            })
          ];
          # withConfig is also composable
        }]).withConfig {
        }
      );
      inherit (pkgs) fetchurl;
    in {
      packages.mc-tech-scot = builtins.listToAttrs (
        builtins.map (
          side: {
            name = side;
            value = modded side;
          }
        )
        ["client" "server"]
      );
    });
}
