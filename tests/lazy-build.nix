{
  pkgs ? import <nixpkgs> { },
  lazy-drv ? pkgs.callPackage <lazy-drv> { },
}:
let
  example = pkgs.writeText "example-output" "Built on demand!";

  lazy = lazy-drv.lib.lazy-build {
    source = ./lazy-build.nix;
    attrs = { inherit example; };
  };
in
{
  inherit example;
  shell = pkgs.mkShellNoCC {
    packages = with pkgs.lib; collect isDerivation lazy;
  };
}
