{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mu
    isync
    protonmail-bridge
  ];

  home.file.".mbsyncrc".text = ''
    IMAPAccount proton
    Host 127.0.0.1
    Port 1143
    User raskpaul@protonmail.com
    PassCmd "cat /run/secrets/protonmail_bridge_password"
    SSLType NONE

    IMAPStore proton-remote
    Account proton

    MaildirStore proton-local
    Subfolders Verbatim
    Path ~/mail/proton/
    Inbox ~/mail/proton/inbox

    Channel proton
    Far :proton-remote:
    Near :proton-local:
    Patterns *
    Create Both
    SyncState *
  '';
}
