# home/modules/development/neovim.nix
{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    
    # Basic editor options
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
    };

    # Set leader key
    globals.mapleader = " ";

    # Example Plugins
    plugins = {
      lualine.enable = true;
      # Add LSP support
      lsp = {
        enable = true;
        servers = {
          # Example: For web development
          tsserver.enable = true;
          # Example: For Nix development
          nil_ls.enable = true;
        };
      };
    };
    
    # Example Colorscheme
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha"; # frappe, macchiato, mocha
    };
  };
}
