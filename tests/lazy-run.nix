{
  pkgs ? import <nixpkgs> { },
  lazy-drv ? pkgs.callPackage <lazy-drv> { },
}:
let
  example = pkgs.writeShellScriptBin "example-command" "echo I am lazy";

  lazy = lazy-drv.lib.lazy-run {
    source = ./lazy-run.nix;
    attrs = { inherit example; };
    nix-build-args = [ "--no-out-link" ];
  };
in
{
  inherit example;
  shell = pkgs.mkShellNoCC {
    packages = with pkgs.lib; collect isDerivation lazy;
  };
}
