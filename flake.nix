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
      inherit (pkgs) fetchurl;
    in {
      packages.mc-tech-scot =
        (minecraft.legacyPackages.${system}.v1_19_4.fabric.client.withConfig [{
          mods = [
            (fetchurl {
              # file name must have a ".jar" suffix to be loaded by fabric
              name = "fabric-api.jar";
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/uIYkhRbX/fabric-api-0.86.1%2B1.19.4.jar";
              hash = "sha256-Ztz1c03gBM4twnM7mT14MbbfshR2cstFPozQxlhzL/Y=";
            })
            (fetchurl {
              # CC:Tweaked
              url = "https://cdn.modrinth.com/data/gu7yAYhd/versions/mtL4uUWR/cc-tweaked-1.19.4-fabric-1.108.0.jar";
              hash = "sha256-3VGx5C3jEv/H9oGKA7b2++g44MhEefPZuUCWqjw9/tA=";
            })
            # (fetchurl {
            #   # Create
            #   url = "https://cdn.modrinth.com/data/Xbc0uyRg/versions/okpdciJG/create-fabric-0.5.1-c-build.1160%2Bmc1.19.2.jar";
            #   hash = "sha256-bBlRh1rV6I1w131AhncVnMeMJnHyfUxH5qFvY2bx35g=";
            # })
            # (fetchurl {
            #   # Phosphor
            #   url = "https://cdn.modrinth.com/data/hEOCdOgW/versions/mc1.18.x-0.8.1/phosphor-fabric-mc1.18.x-0.8.1.jar";
            #   hash = "";
            # })
            # (fetchurl {
            #   # Lithium
            #   url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/ALnv7Npy/lithium-fabric-mc1.18.2-0.10.3.jar";
            #   hash = "";
            # })
            # (fetchurl {
            #   # Sodium
            #   url = "https://cdn.modrinth.com/data/AANobbMI/versions/mc1.18.2-0.4.1/sodium-fabric-mc1.18.2-0.4.1%2Bbuild.15.jar";
            #   hash = "";
            # })
            # (fetchurl {
            #   # Mod menu
            #   url = "https://cdn.modrinth.com/data/mOgUt4GM/versions/nVxObSbX/modmenu-3.2.5.jar";
            #   hash = "";
            # })
            (fetchurl {
              # Moonlight Lib
              url = "https://cdn.modrinth.com/data/twkfQtEc/versions/gmoV0tyd/moonlight-1.19.4-2.4.16-fabric.jar";
              hash = "sha256-qBuNfmnva1iFl8Fq9V+/l58W9eklUaSDQEjV2PEl2IM=";
            })
            (fetchurl {
              # Supplementaries
              url = "https://cdn.modrinth.com/data/fFEIiSDQ/versions/1mQDVX91/supplementaries-1.19.4-2.4.15-fabric.jar";
              hash = "sha256-u5iZcG7I66eNUxHxVQFcciqpbj0xk/2dSDHaLEyFQVY=";
            })
          ];
          # withConfig is also composable
        }]).withConfig {
          resourcePacks = [
          ];
        };
    });
}
