# home/modules/development/android.nix
{ pkgs, inputs, config, ... }:

let
  # Define the Android SDK declaratively
  androidSdk = inputs.android-nixpkgs.sdk.${pkgs.system} (sdkPkgs: with sdkPkgs; [
    cmdline-tools-latest
    build-tools-34-0-0
    platform-tools
    platforms-android-34
    emulator
  ]);

  # Ensure we use a compatible JDK
  jdk = pkgs.jdk17;
in
{
  home.packages = with pkgs; [
    flutter
    android-studio
    jdk
    androidSdk
  ];

  home.sessionVariables = {
    ANDROID_SDK_ROOT = "${androidSdk}/share/android-sdk";
    ANDROID_HOME = "${androidSdk}/share/android-sdk";
    FLUTTER_ROOT = "${pkgs.flutter}";
    JAVA_HOME = "${jdk.home}";
  };

  # Declaratively create the .flutter-settings file
  home.file.".flutter-settings".text = ''
    {
      "android-studio-dir": "${pkgs.android-studio}/lib/android-studio",
      "jdk-dir": "${jdk.home}"
    }
  '';
}
