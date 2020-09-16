{ lib
, rustPlatform

, pkg-config

, libtensorflow
, openssl
}:

{ # Source of the dpar to build.
  src

  # Vendored dependencies hash.
, cargoSha256

  # Version
, version
}:

rustPlatform.buildRustPackage rec {
  inherit cargoSha256 src version;

  pname = "dpar";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    libtensorflow
    openssl
  ];

  OPENSSL_NO_VENDOR = 1;

  meta = with lib; {
    description = "Neural transition-based dependency parser";
    license = licenses.asl20;
    maintainers = with maintainers; [ danieldk ];
    platforms = platforms.unix;
  };
}
