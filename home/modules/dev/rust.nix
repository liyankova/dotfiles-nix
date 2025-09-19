# home/modules/development/rust.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    pkg-config
    openssl
  ];
}
