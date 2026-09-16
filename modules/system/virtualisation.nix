{ pkgs, username, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };

  virtualisation.podman = {
    enable = true;
  };

  users.groups.libvirt = { };
  virtualisation.spiceUSBRedirection.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [
    podman-compose
    virt-manager
    virtiofsd
    dnsmasq
  ];

  boot.kernelModules = [
    "ip_tables"
    "iptable_nat"
  ];

  services.samba = {
    enable = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "security" = "user";
      };
      vmshare = {
        "path" = "/home/${username}/vm-shared";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "force user" = username;
      };
    };
  };
  networking.firewall.allowedTCPPorts = [
    139
    445
  ];
}
