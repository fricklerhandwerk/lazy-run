#!/usr/bin/env bash

set -e
nixpkgs="$(npins show -d ../npins | rg url | cut -d' ' -f6)"

test_lazy_run() {
  nix-shell lazy-run.nix -A shell -I nixpkgs=$nixpkgs -I lazy-drv=../. --run example-command
}

[ "$(test_lazy_run)" = "I am lazy" ]

test_lazy_build() {
  nix-shell lazy-build.nix -A shell -I nixpkgs=$nixpkgs -I lazy-drv=../. --run example-output
  cat result
}

[ "$(test_lazy_build | tail -n +2)" = "Built on demand!" ] 
