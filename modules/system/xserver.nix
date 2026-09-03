{ username, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager.autoLogin = {
      enable = false;
      user = "${username}";
    };
    libinput = {
      enable = true;
    };
  };
}
