# home/modules/dev/neovim.nix
{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
    };

    globals.mapleader = " ";

    plugins = {
      lualine.enable = true;

      lsp = {
        enable = true;
        servers = {
          # Renamed from 'tsserver' and 'ts-ls'
          ts_ls.enable = true;

          nil_ls.enable = true;
          
          # Add the missing package for dockerfile-language-server
          # docker-ls.enable = true;
          dockerls.enable = true;
        };
      };

    };
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      gruvbox
    ];

    colorschemes.gruvbox.enable = true;
    
    
    # colorschemes.catppuccin = {
    #   enable = true;
    #   # Renamed from 'flavour'
    #   settings.flavour = "mocha"; # frappe, macchiato, mocha
    # };
  };
}
