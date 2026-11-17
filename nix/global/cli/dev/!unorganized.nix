{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lazygit
    pnpm
    nodejs
  ];
}
