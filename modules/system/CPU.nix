{ host, lib, ... }:
{
  config = lib.mkIf (host == "mycorrhiza") {
    services.undervolt = {
      enable = true;
      p1 = {
        limit = 125;
        window = 56;
      };
    };
  };
}
