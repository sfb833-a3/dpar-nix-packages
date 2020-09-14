{ lib
, rustPlatform
, fetchFromGitHub

, pkg-config

, libtensorflow
, openssl
}:

rustPlatform.buildRustPackage rec {
  pname = "dpar";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "danieldk";
    repo = "dpar";
    rev = version;
    sha256 = "02zw4dw8nanvbc2sngv5rwqszc3rp0lgr2gjrr6ag9p4d82s6jny";
  };

  cargoSha256 = "11zmjmkvblar094nn57cpxr1zyx07a15cyxbi7rq65hmavhbkmr2";

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
