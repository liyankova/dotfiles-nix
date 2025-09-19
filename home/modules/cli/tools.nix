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

    # Editors
    vim
    neovim
  ];
}
