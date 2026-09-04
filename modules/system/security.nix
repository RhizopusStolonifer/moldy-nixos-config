{
  config,
  lib,
  pkgs,
  ...
}:

{
  security = {
    sudo-rs.enable = true;

    pam.services = {
      swaylock.enableGnomeKeyring = true;
    };
  };

  services.udev.extraRules = ''
    # ZSA keyboards — normal mode (USB + HID)
    SUBSYSTEM=="usb", ATTR{idVendor}=="3297", MODE:="0666"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3297", MODE:="0666"

    # STM32 DFU bootloader (generic)
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", MODE:="0666"
  '';
}
