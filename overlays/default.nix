# overlays/default.nix
{ pkgsUnstable, ... }:

final: prev: {
  unstable = pkgsUnstable;
}
