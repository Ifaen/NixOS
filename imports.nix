# TODO: Move all imports in here
{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager # Imports home-manager as a nixos module
    inputs.nur.modules.nixos.default # Adds the NUR overlay

    ./modules/browsers/brave
    ./modules/browsers/google-chrome
    ./modules/tools/olive-editor
    ./modules/utilities/ripdrag # Drag and drop application
  ];
}
