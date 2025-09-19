# home/modules/cli/zsh.nix
{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "sudo"
      ];
    };

    shellAliases = {
      # -- General Tools --
      cat = "bat --paging=never";
      ff = "fastfetch -c $HOME/.config/fastfetch/config.jsonc";
      st = "kitty --class special_term";

      # -- eza (ls replacement) --
      ls = "eza --icons";
      l = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --level=2 --icons";

      # -- Config Shortcuts --
      zshrc = "nvim ~/.zshrc";
      gozsh = "source ~/.zshrc";
      hyprland = "nvim ~/.config/hypr/hyprland.conf";
      hypr = "cd ~/.config/hypr";
      conf = "cd ~/.config";
      hyconf = "cd ~/.config/hypr/UserConfigs";
      hykeyb = "nvim ~/.config/hypr/UserConfigs/UserKeybinds.conf";
      hyenv = "nvim ~/.config/hypr/UserConfigs/ENVariables.conf";
      hydecor = "nvim ~/.config/hypr/UserConfigs/UserDecorations.conf";
      nvkitty = "nvim ~/.config/kitty/kitty.conf";
      cdwaybar = "cd ~/.config/waybar";

      # -- Distrobox --
      arch = "distrobox enter dev-box";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      share = true;
    };

    initContent = ''
      # Custom Functions
      mkcd () {
        mkdir -p "$@" && cd "$_";
      }

      # Oh My Posh Prompt Initialization
      eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/wallust.omp.json)"

      # Load custom environment variables if file exists
      if [ -f ~/.keyenv ]; then
        source ~/.keyenv
      fi
    '';
  };

  # --- Declarative Tool Integrations ---
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
  };
  programs.bat.enable = true;

  # --- Declarative Environment Variables ---
  home.sessionVariables = {
    VOLTA_HOME = "$HOME/.volta";
    ANDROID_HOME = "$HOME/Android/Sdk";
    PNPM_HOME = "$HOME/.local/share/pnpm";
    GOPATH = "$HOME/go";
    # GOROOT is managed by Nix automatically
  };

  # --- Declarative PATH ---
  home.sessionPath = [
    "$HOME/.volta/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/share/pnpm"
    "$HOME/.local/bin"
    "$HOME/SDKs/flutter/bin"
    "$HOME/Android/Sdk/platform-tools"
    "$HOME/go/bin"
  ];
}
