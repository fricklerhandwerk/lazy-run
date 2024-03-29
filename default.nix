{ sources ? import ./npins
, system ? builtins.currentSystem
,
}:
let
  pkgs = import sources.nixpkgs {
    inherit system;
    config = { };
    overlays = [ ];
  };
in
{
  inherit (pkgs.callPackage ./lib.nix { }) lazy-path;

  shell = pkgs.mkShellNoCC {
    packages = [
      pkgs.npins
    ];
  };
}
