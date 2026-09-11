{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true; # emulated TPM 2.0 — Windows 11 setup checks for this
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ]; # UEFI firmware, needed for Win11 + Secure Boot
      };
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;
  services.spice-vdagentd.enable = true; # clipboard sharing, dynamic resolution

  environment.systemPackages = with pkgs; [
    virt-manager
    virtiofsd
  ];
}
