{ config, pkgs, inputs, ... }:

let
  rawDotfilesPath = inputs.dotfiles-raw;
  topLevelItems = builtins.attrNames (builtins.readDir rawDotfilesPath);

  # --- XDG Configs (~/.config) ---
  xdgFolders = [
    "btop" "fastfetch" "hypr" "kitty" "oh-my-posh" "rofi"
    "swaync" "swappy" "waybar" "wlogout" "yazi" "wallust"
  ];

  xdgConfigs = pkgs.lib.listToAttrs (map (folderName:
    let
      packagePath = "${rawDotfilesPath}/${folderName}";
      nestedConfigPath = "${packagePath}/.config/${folderName}";
    in
    {
      name = folderName;
      value.source =
        if builtins.pathExists nestedConfigPath
        then nestedConfigPath
        else packagePath;
    }
  ) xdgFolders);


  # --- Non-XDG Configs ($HOME) ---
  # homeFileConfigs = {
  #   ".zshrc" = {
  #     source = "${rawDotfilesPath}/zsh/.zshrc";
  #     enable = builtins.pathExists "${rawDotfilesPath}/zsh/.zshrc";
  #   };
  #   ".tmux.conf" = {
  #     source = "${rawDotfilesPath}/tmux/.tmux.conf";
  #     enable = builtins.pathExists "${rawDotfilesPath}/tmux/.tmux.conf";
  #   };
  #   ".config/oh-my-tmux" = {
  #     source = "${rawDotfilesPath}/oh-my-tmux/.config/oh-my-tmux";
  #     enable = builtins.pathExists "${rawDotfilesPath}/oh-my-tmux/.config/oh-my-tmux";
  #   };
  # };
  #
in
{
  xdg.configFile = xdgConfigs;

  home.file = homeFileConfigs;
}
