# home/modules/development/editors.nix
{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "editor.fontSize" = 14;
      "editor.fontFamily" = "JetBrains Mono, monospace";
      "workbench.colorTheme" = "Default Dark+";
    };
  };

  # programs.neovim = {
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;
  # };

  programs.git.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
