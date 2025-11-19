{
  description = "fbDOOM cross-compile environment for armv7 (Braiins Forge Deck)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      pkgsCross = pkgs.pkgsCross.armv7l-hf-multiplatform;
    in pkgs.mkShell {
      nativeBuildInputs = [
        pkgsCross.stdenv.cc
        pkgs.gnumake
      ];

      buildInputs = [
        pkgsCross.glibc.static
      ];

      shellHook = ''
        export CROSS_COMPILE="${pkgsCross.stdenv.cc.targetPrefix}"
        export CC="${pkgsCross.stdenv.cc}/bin/${pkgsCross.stdenv.cc.targetPrefix}gcc"
        export CFLAGS="-static -std=gnu99 $CFLAGS"
        export LDFLAGS="-static $LDFLAGS"
        export NOSDL="1"

        echo "fbDOOM cross-compile environment for Braiins Forge Deck"
        echo ""
        echo "Environment configured:"
        echo "  CROSS_COMPILE=$CROSS_COMPILE"
        echo "  CC=$CC"
        echo "  Target: armv7l-hf"
        echo ""
        echo "To build:"
        echo "  cd fbdoom"
        echo "  make"
        echo ""
        echo "Binary will be: ./fbdoom/fbdoom"
        echo ""
      '';
    };
  };
}
