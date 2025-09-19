# home/modules/cli/git.nix
{ pkgs, user, ... }: # <-- 'user' is also available here

{
  programs.git = {
    enable = true;
    userName = user.gitUsername;
    userEmail = user.gitEmail;
  };
}
