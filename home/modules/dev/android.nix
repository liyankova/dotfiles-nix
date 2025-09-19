# home/modules/development/android.nix
{ pkgs, inputs, ... }:

let
  androidSdk = inputs.android-nixpkgs.sdk.${pkgs.system} (sdkPkgs: with sdkPkgs; [
    cmdline-tools-latest
    build-tools-34-0-0
    platform-tools
    platforms-android-34
    emulator
  ]);
in
{
  home.packages = [ androidSdk ];

  home.sessionVariables = {
    ANDROID_SDK_ROOT = "${androidSdk}/share/android-sdk";
    ANDROID_HOME = "${androidSdk}/share/android-sdk";
  };

  programs.adb.enable = true;
}
