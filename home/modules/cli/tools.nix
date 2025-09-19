# home/modules/cli/tools.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI tools
    htop
    fastfetch
    neofetch
    tree
    tmux
    wget
    curl
    gh
    stow
    kitty

    # Editors
    vim
    neovim
  ];
}
