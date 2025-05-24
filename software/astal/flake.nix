{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    ags.url = "github:aylur/ags";
  };

  outputs = {self, ...} @ inputs: {
    devShells.x86_64-linux.default = inputs.nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = [
        # includes astal3 astal4 astal-io by default
        (inputs.ags.packages.x86_64-linux.default.override {
          extraPackages = [
            # cherry pick packages
          ];
        })
      ];
    };
  };
}
