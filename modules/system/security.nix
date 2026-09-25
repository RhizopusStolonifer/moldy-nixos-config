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

    # plover
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"

    SUBSYSTEM=="tty", ATTRS{idVendor}=="3297", ENV{ID_MM_DEVICE_IGNORE}="1"

    SUBSYSTEM=="tty", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="1969", ENV{ID_USB_INTERFACE_NUM}=="02", SYMLINK+="moonlander-steno", MODE:="0660", GROUP="dialout"
  '';
}
