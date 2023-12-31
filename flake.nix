{
  description = "Optimised vanilla+ modpack with CC:Tweaked.";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.minecraft = {
    url = "github:viluon/minecraft.nix/feature/offline";
    inputs.metadata.follows = "minecraft-metadata";
  };
  inputs.minecraft-metadata.url = "github:Ninlives/minecraft.json";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-config = {
    url = "path:./flake-config.json";
    flake = false;
  };

  outputs = { self, nixpkgs, minecraft, flake-utils, flake-config, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      modded = (side:
        (minecraft.legacyPackages.${system}.v1_20_1.fabric.${side}.withConfig [{
          mods = builtins.map fetchurl [
            {
              # file name must have a ".jar" suffix to be loaded by fabric
              name = "fabric-api.jar";
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/tFw0iWAk/fabric-api-0.90.0%2B1.20.1.jar";
              hash = "sha256-AFrtcV1tFOFrik8Dfv93BchMOZZ409AC7bQ4mchb6AI=";
            }

            {
              # CC:Tweaked
              url = "https://cdn.modrinth.com/data/gu7yAYhd/versions/taNGLI3t/cc-tweaked-1.20.1-fabric-1.108.3.jar";
              hash = "sha256-TneKVNvt0A9QoD7lJtrjDWyzNWJfWUgoFXI1+kU5u0o=";
            }

            # currently incompatible with Sodium 5
            {
              # Create
              url = "https://cdn.modrinth.com/data/Xbc0uyRg/versions/qlA1WuOK/create-fabric-0.5.1-d-build.1161%2Bmc1.20.1.jar";
              hash = "sha256-c7mBDzuY0Xjqnj0QG46gAPDD92Kcn9Ol5sAXdn7LRhQ=";
            }

            # hasn't been updated for 1.20 yet
            # {
            #   # Phosphor
            #   url = "https://cdn.modrinth.com/data/hEOCdOgW/versions/mc1.18.x-0.8.1/phosphor-fabric-mc1.18.x-0.8.1.jar";
            #   hash = "";
            # }

            {
              # Lithium
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/ZSNsJrPI/lithium-fabric-mc1.20.1-0.11.2.jar";
              hash = "sha256-oMWVNV1oDgyHv46uuv7f9pANTncajWiU7m0tQ3Tejfk=";
            }

            # {
            #   # Sodium
            #   url = "https://cdn.modrinth.com/data/AANobbMI/versions/vgceLbdH/sodium-fabric-mc1.20-0.4.10%2Bbuild.27.jar";
            #   hash = "sha256-MMhvfuCk8JT8qhIoNCpy5QJJ88D+ZSNmfnL1f5JwCFo=";
            # }

            # {
            #   # Indium
            #   url = "https://cdn.modrinth.com/data/Orvt0mRa/versions/WTH3T2cR/indium-1.0.18%2Bmc1.20.jar";
            #   hash = "sha256-jrr292qwE+78f/+GvxifiL3tt2Tjq6L/E8cSbT2eUU4=";
            # }

            # currently disabled for weird culling behaviour
            # {
            #   # Iris
            #   url = "https://cdn.modrinth.com/data/YL57xq9U/versions/P8R7yx6t/iris-mc1.20.1-1.6.9.jar";
            #   hash = "sha256-R/qCMKD/CJamDYgioZzHWH7Sp6jU+BhxNamv3qRUJ48=";
            # }

            {
              # Immediately Fast
              url = "https://cdn.modrinth.com/data/5ZwdcRci/versions/mbeaDZtb/ImmediatelyFast-1.2.6%2B1.20.2.jar";
              hash = "sha256-GysqplQ+83NohqA1MTCVD+B8XdDpJhz1QXxGTskR3Kc=";
            }

            {
              # Mod menu
              url = "https://cdn.modrinth.com/data/mOgUt4GM/versions/lEkperf6/modmenu-7.2.2.jar";
              hash = "sha256-oEGw8DBf+l65ASCqI3aOHPuydYOQSxdR43g8D2k4Lxo=";
            }

            {
              # Moonlight Lib, dependency of Supplementaries
              url = "https://cdn.modrinth.com/data/twkfQtEc/versions/h6yrGow9/moonlight-1.20-2.8.44-fabric.jar";
              hash = "sha256-KEWaYiCl9ENGysI460Ht2M8DdKPAbLqb0pVqtlwVVdI=";
            }

            {
              # Supplementaries
              url = "https://cdn.modrinth.com/data/fFEIiSDQ/versions/SJkKNUtS/supplementaries-1.20-2.6.11-fabric.jar";
              hash = "sha256-Dw1gLci/Zi2FuzO4Jdh0ZB8hg/P1M5vYn0FBfrA3TbE=";
            }

            # currently incompatible with Sodium 5 (https://github.com/ValkyrienSkies/Valkyrien-Skies-2/issues/556)
            {
              # Valkyrien Skies, dependency of Eureka
              url = "https://cdn.modrinth.com/data/V5ujR2yw/versions/LZnRLeUW/valkyrienskies-1201-2.3.0-beta.4.jar";
              hash = "sha256-LFDbeXvPtwBX3Mv2SWygh8GkjhpKGlFauKK3bTzI9d4=";
            }

            {
              # CT's Overhauled Village
              url = "https://cdn.modrinth.com/data/fgmhI8kH/versions/7LYJgioY/ctov-3.3.5a.jar";
              hash = "sha256-DI/C1tfQyawjpnqSAlkJvDmfKLxGvB2DgPAU1sB8D9I=";
            }

            {
              # Farmer's Delight
              url = "https://cdn.modrinth.com/data/4EakbH8e/versions/rlm3hWGx/farmers-delight-fabric-mc1.20.1-1.4.2.jar";
              hash = "sha256-GjMSc/yvQTSZsoJ/Pkj/PmYzlP03Xw2mSHhs99Wlljg=";
            }

            {
              # CTOV + FD compatibility
              url = "https://cdn.modrinth.com/data/CdRC4fyI/versions/Bp3TnFpM/ctov-farmers-delight-compat-2.0.jar";
              hash = "sha256-9+jLrzKR0NCG3FPlvOEhIX3waKFbvZ0xE6gEeqzr90g=";
            }

            {
              # Appleskin
              url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/xcauwnEB/appleskin-fabric-mc1.20.1-2.5.1.jar";
              hash = "sha256-heI6QpY0BIoumt3ICJFMHEMIMIP14h8r88OcSeWvOLU=";
            }

            {
              # Better Combat
              url = "https://cdn.modrinth.com/data/5sy6g3kz/versions/Z6wHaEla/bettercombat-fabric-1.7.4%2B1.20.1.jar";
              hash = "sha256-5W1BimEeRVo2qzAkriTSRgmcgyCznNWFHt2KmE7f89U=";
            }

            {
              # playerAnimator, dependency of Better Combat
              url = "https://cdn.modrinth.com/data/gedNE4y2/versions/yDqYTUaf/player-animation-lib-fabric-1.0.2-rc1%2B1.20.jar";
              hash = "sha256-CxACH6Y4mXOYEQd3dHcmsct6J7w/j/GxLiuTrAF4QBg=";
            }

            {
              # Minecraft Comes Alive Reborn
              url = "https://cdn.modrinth.com/data/1W98a849/versions/OiRMI8Og/minecraft-comes-alive-7.5.8%2B1.20.1-universal.jar";
              hash = "sha256-i+wncuPLYdQgF6YAlZZ1+apZXoGLPVUouoepaz5ohXw=";
            }

            {
              # Architectury, dependency of MCA
              url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/Sbew3kXe/architectury-9.1.12-fabric.jar";
              hash = "sha256-DFXtoJyqQsYlyh2R4yB49zqLHQ7vYvILdIVpyEyxMUc=";
            }

            {
              # Item Highlighter
              url = "https://cdn.modrinth.com/data/cVNW5lr6/versions/bEkFFVMh/Highlighter-1.20.1-fabric-1.1.6.jar";
              hash = "sha256-ieluT5nCj8AvwlBh/3tQ1xPjrg1voQBwU/Y6H97Sng0=";
            }

            {
              # Iceberg, dependency of Item Highlighter
              url = "https://cdn.modrinth.com/data/5faXoLqX/versions/SLE7PvYD/Iceberg-1.20.1-fabric-1.1.15.jar";
              hash = "sha256-LlclL3tdLWZFo794Cd0fLB4xXfswdzumAPWvi0qSQTY=";
            }

            {
              # Forge Config API Port, dependency of Item Highlighter
              url = "https://cdn.modrinth.com/data/ohNO6lps/versions/CtENDTlF/ForgeConfigAPIPort-v8.0.0-1.20.1-Fabric.jar";
              hash = "sha256-keaFkl//L8qlGnMgKm7cnSQ192VSqNl6+IlCw3ZD/YY=";
            }

            {
              # ForgeConfigScreens, optional dependency of Forge Config API Port
              url = "https://cdn.modrinth.com/data/5WeWGLoJ/versions/nwy63zfI/ForgeConfigScreens-v8.0.2-1.20.1-Fabric.jar";
              hash = "sha256-29z0EL7dyGBNzrMI+9th94lHn+OQP5NV5HIR9RhgEO8=";
            }

            {
              # Comforts
              url = "https://cdn.modrinth.com/data/SaCpeal4/versions/35QTsWN6/comforts-fabric-6.3.3%2B1.20.1.jar";
              hash = "sha256-oUcfblqZ5Kg8FK5Iw60nbv4DUwXhIuCK5GycvUVbeKE=";
            }

            {
              # Spawn Animations
              url = "https://cdn.modrinth.com/data/zrzYrlm0/versions/dJbCLsdr/spawnanimations-v1.9.2-mc1.17x-1.20x-mod.jar";
              hash = "sha256-mt2hNvYLRPv2BbUR7h3yL+TCCqitvnE8f/6Hc+SvVR0=";
            }

            {
              # Mod Menu Badges Lib, optional dependency of Spawn Animations
              url = "https://cdn.modrinth.com/data/eUw8l2Vi/versions/n5smDDrP/modmenu-badges-lib-2023.6.1.jar";
              hash = "sha256-Eq8xR5ZoL7mOGRBdkcWK6XmOPBkXNBDgcpt1FHfMlT0=";
            }

            {
              # Axes Are Weapons
              url = "https://cdn.modrinth.com/data/1jvt7RTc/versions/Pxrg8h3r/AxesAreWeapons-1.7.1-fabric-1.19.3.jar";
              hash = "sha256-LmAovMBpUQUXePNFRUwn3Jr/7ewuTYj+sqKudiXzB84=";
            }

            {
              # Tax-free Levels
              url = "https://cdn.modrinth.com/data/jCBrrLTs/versions/1.3.3/TaxFreeLevels-1.3.3-fabric-1.19.jar";
              hash = "sha256-cmzIl9CYrPyByYgZAlZGpUVtvg8lnLLHOOi6RLpHx8g=";
            }

            {
              # Dismount Entity
              url = "https://cdn.modrinth.com/data/H7N61Wcl/versions/IOWwuxky/dismountentity-1.20.1-3.0.jar";
              hash = "sha256-gwkVdHxygLPQxdpwOKuav8oRA/69j/qTnVtGGMco9d0=";
            }

            {
              # Healing Campfire
              url = "https://cdn.modrinth.com/data/kOuPUitF/versions/Af56JzSn/healingcampfire-1.20.1-5.1.jar";
              hash = "sha256-8G06oE/i/2xhOumQ+gHYdOcsJk8JQ18qwTdnSGm41qU=";
            }

            {
              # Collective, dependency of Healing Campfire, Just Mob Heads, No Hostiles Around Campfire, Nutritious Milk, Paper Books
              url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/TobnIU5c/collective-1.20.1-6.66.jar";
              hash = "sha256-L5Yh7c9o7XniyfAEA1+NXzQUdr0+wvCUyJZiX+o+TQw=";
            }

            {
              # Just Mob Heads
              url = "https://cdn.modrinth.com/data/jzTUm9hE/versions/oKbNARSo/justmobheads-1.20.1-7.3.jar";
              hash = "sha256-4UDV73huuA7EPGEW38epoGr5+Gs+KHowEZRKN4a1oi4=";
            }

            {
              # No Hostiles Around Campfire
              url = "https://cdn.modrinth.com/data/EJqeyaVz/versions/PUrIyMeI/nohostilesaroundcampfire-1.20.1-5.6.jar";
              hash = "sha256-0pHKcEB0S0DbTKmTFfnp03+xrmXUA5GwlN/DiwjrmOI=";
            }

            {
              # Nutritious Milk
              url = "https://cdn.modrinth.com/data/V4iy0Bhx/versions/x3cS26oS/nutritiousmilk-1.20.1-3.1.jar";
              hash = "sha256-pQ5i19dd4pkdqu55FleZhb61gxGXFXApnpKI9766PnU=";
            }

            {
              # Paper Books
              url = "https://cdn.modrinth.com/data/QM2wt9X3/versions/8JR9tOg6/paperbooks-1.20.1-3.0.jar";
              hash = "sha256-cNBTVHeA6Ixxgnr1Azg5MdXN9otmr0HO2hJ0LVy/9Qk=";
            }

            {
              # Not Enough Animations
              url = "https://cdn.modrinth.com/data/MPCX6s5C/versions/6auoqhMp/notenoughanimations-fabric-1.6.4-mc1.20.jar";
              hash = "sha256-IErjGVtsSyG9e9uni23JGU/mQlJvLoKKIKGhRbhrVAA=";
            }

            {
              # Eating Animation
              url = "https://cdn.modrinth.com/data/rUgZvGzi/versions/OcHlWpeQ/eating-animation-1.9.4%2B1.20.jar";
              hash = "sha256-kvZ8yu0hQjsueEB8TZ+gMOhmADuETvXycx2U+sGXPhw=";
            }

            {
              # Fastload
              url = "https://cdn.modrinth.com/data/kCpssoSb/versions/ys9T20o4/Fastload%2B1.18.2-1.20-3.4.0.jar";
              hash = "sha256-4Tq3E/l3liPeKbtQOWsyAtZwUyvUYF90yQfU94NMFjc=";
            }

            {
              # Enhanced Block Entities
              url = "https://cdn.modrinth.com/data/OVuFYfre/versions/i3v1Skck/enhancedblockentities-0.9%2B1.20.jar";
              hash = "sha256-HEziwA2MxtImnePK2rpVFgfGJpKo5a0dfGGEYu1+0Fs=";
            }

            {
              # Entity Culling
              url = "https://cdn.modrinth.com/data/NNAgCjsB/versions/BDwHAdWc/entityculling-fabric-1.6.2-mc1.20.1.jar";
              hash = "sha256-4trtbW/ywCdwY9CsVcU0WviYA0+W2j4b4B4mR19hwTw=";
            }

            {
              # C2ME
              url = "https://cdn.modrinth.com/data/VSNURh3q/versions/T5Pkyhit/c2me-fabric-mc1.20.1-0.2.0%2Balpha.11.0.jar";
              hash = "sha256-VQIWNH3BLLtfKc6PAt5cRPSI9eVMoqGcS/6E+b6HaiE=";
            }

            {
              # Dynamic FPS
              url = "https://cdn.modrinth.com/data/LQ3K71Q1/versions/MJxmQ042/dynamic-fps-3.2.1%2Bminecraft-1.20.0.jar";
              hash = "sha256-V8Oo0Q9Fi0uPK4eIB5IrZH7w06vIrbVng6kflIQvDcs=";
            }

            {
              # Krypton
              url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/jiDwS0W1/krypton-0.2.3.jar";
              hash = "sha256-aa0YECBs4SGBsbCDZA8ETn4lB4HDbJbGVerDYgkFdpg=";
            }

            {
              # BlueMap
              url = "https://cdn.modrinth.com/data/swbUV1cr/versions/xgcQSkBc/BlueMap-3.17-fabric-1.20.jar";
              hash = "sha256-rOsITKL30MiKeT8JYm4lnX0MtnvjAXUYIxm5nBy78dw=";
            }

            {
              # EasyAuth
              url = "https://cdn.modrinth.com/data/aZj58GfX/versions/hKFWKzLt/easyauth-mc1.20-3.0.19.jar";
              hash = "sha256-eaaIZ9msPjmMTc5wYq9HOXyrg3CHi/mL2EKVLEhLKnU=";
            }

            {
              # Disable Insecure Chat Toast
              url = "https://cdn.modrinth.com/data/i090SePT/versions/UGKpfpZ6/DisableInsecureChatToast-mc1.20-1.1.0.jar";
              hash = "sha256-AXGEP8EKwQvGeu6j/Ae1dEkXmO5HkBbYcLRUiMjoQ8I=";
            }

            {
              # Wandering Collector
              url = "https://cdn.modrinth.com/data/enYiOcBu/versions/STgaTh8X/wanderingcollector-1.2.1%2Bmc1.20-pre5.jar";
              hash = "sha256-uaYjveVMqGsFA4fzl8QOtCSdYWR4pX9joT/Yv72LquA=";
            }

            {
              # Enchantment Lore
              url = "https://cdn.modrinth.com/data/YHdR6hMt/versions/M5LOhlR4/enchantment-lore-1.3.2%2BMC1.20-1.20.1.jar";
              hash = "sha256-iYmRf8A6Y43W7hcTefihLswnWx3yryPFL+1S/Ban23M=";
            }

            {
              # Better F3
              url = "https://cdn.modrinth.com/data/8shC1gFX/versions/FtJ0KSLo/BetterF3-7.0.1-Fabric-1.20.1.jar";
              hash = "sha256-ICn7DQNEwE/9kGvg4zF+Q6R7w0/G44b5+qTKKCMWUeI=";
            }

            {
              # Eureka
              url = "https://cdn.modrinth.com/data/EO8aSHxh/versions/inFFe9Gn/eureka-1201-1.3.0-beta.2.jar";
              hash = "sha256-RtcyysOOoy/s/i+79sm2WfJrelWBenuCZIMTQtDFR+k=";
            }
          ];
          # withConfig is also composable
        }]).withConfig (if side == "server" then {} else {
          # client-only config
          username = (builtins.fromJSON (builtins.readFile flake-config)).username;
          # TODO: resource pack https://modrinth.com/resourcepack/create-computercraft
          shaderPacks = builtins.map fetchurl [
            {
              # BSL Shaders
              url = "https://cdn.modrinth.com/data/Q1vvjJYV/versions/Mshu5RrT/BSL_v8.2.05.zip";
              hash = "sha256-a1KyuJ4RwpiJ8JlK85HPVZQ6bgdxtLh2es0zZo7HYO8=";
            }

            {
              # Complementary Shaders Reimagined
              url = "https://cdn.modrinth.com/data/HVnmMxH1/versions/NKGyBgjH/ComplementaryReimagined_r5.0.1.zip";
              hash = "sha256-2K0LHKi9nfI7hKKb4IxKAHMAg+59FCsLLCPQ1L1EzK8=";
            }
          ];
        })
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
