{
  writeShellApplication,
  beets,
  fzf,
  coreutils,
  gnugrep,
  gnused,
  findutils,
}:
writeShellApplication {
  name = "playlist-tool";
  runtimeInputs = [
    beets
    fzf
    coreutils
    gnugrep
    gnused
    findutils
  ];
  text = builtins.readFile ./playlist-tool.sh;
}
