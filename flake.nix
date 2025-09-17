{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      beamPackages = pkgs.beamPackages;
      mixNixDeps = import ./mix.nix {
        inherit beamPackages;
        lib = pkgs.lib;
        overrides = final: prev: {
          vix = prev.vix.overrideDerivation (pvix: {
            buildInputs = pvix.buildInputs ++ [
              pkgs.pkg-config
              pkgs.vips.dev
            ];
            buildPhase = ''
              export HOME=$(pwd)/cache
              export VIX_COMPILATION_MODE=PLATFORM_PROVIDED_LIBVIPS
              ${pvix.buildPhase}
            '';
          });
        };
      };
      writeConfigRoot = s: pkgs.stdenv.mkDerivation {
        name = "lichat-write-config-root";
        phases = [ "installPhase" ];
        installPhase = ''
          ${pkgs.lib.toShellVar "lichat_conf" s}
          mkdir -p $out/config
          echo "$lichat_conf" >$out/config/secret.exs
        '';
      };
      lichat = beamPackages.mixRelease {
        inherit mixNixDeps;
        src = ./.;
        pname = "ex-lichat";
        version = "git";
        postPatch = ''
          sed -i s/RELEASE_ROOT/LICHAT_CONFIG_ROOT/ mix.exs
        '';
      };
      lichatModule = { config, lib, ... }:
        let
          cfg = config.colonq.services.lichat;
        in {
          options.colonq.services.lichat = {
            enable = lib.mkEnableOption "Enable the Lichat server";
            cookie = lib.mkOption {
              type = lib.types.str;
              default = "defaultcookie";
              description = "Elixir COOKIE for the Lichat server";
            };
            config = lib.mkOption {
              type = lib.types.str;
              default = "";
              description = "Extra configuration for the Lichat server";
            };
          };
          config = lib.mkIf cfg.enable {
            systemd.services."colonq.lichat" = {
              after = ["network-online.target"];
              wantedBy = ["network-online.target"];
              environment = {
                RELEASE_COOKIE = cfg.cookie;
                LICHAT_CONFIG_ROOT = writeConfigRoot cfg.config;
              };
              serviceConfig = {
                Restart = "on-failure";
                ExecStart = "${lichat}/bin/lichat start";
                DynamicUser = "yes";
                RuntimeDirectory = "colonq.lichat";
                RuntimeDirectoryMode = "0755";
                StateDirectory = "colonq.lichat";
                StateDirectoryMode = "0700";
                CacheDirectory = "colonq.lichat";
                CacheDirectoryMode = "0750";
              };
            };
          };
        };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          pkgs.elixir
          pkgs.beamPackages.hex
        ];
      };
      packages.x86_64-linux = {
        inherit lichat;
        default = lichat;
      };
      nixosModules = {
        lichat = lichatModule;
      };
    };
}
