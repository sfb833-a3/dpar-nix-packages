{ lib
, rustPlatform
, fetchFromGitHub

, pkg-config

, libtensorflow
, openssl
}:

let
  generic = import ./generic.nix {
    inherit lib rustPlatform pkg-config libtensorflow openssl;
  };
in {
  dpar = generic rec {
    version = "0.2.0";

    src = fetchFromGitHub {
      owner = "danieldk";
      repo = "dpar";
      rev = version;
      sha256 = "02zw4dw8nanvbc2sngv5rwqszc3rp0lgr2gjrr6ag9p4d82s6jny";
    };

    cargoSha256 = "11zmjmkvblar094nn57cpxr1zyx07a15cyxbi7rq65hmavhbkmr2";
  };

  dpar-fifu-pmi = generic rec {
    version = "unstable-20200916";

    src = fetchFromGitHub {
      owner = "DiveFish";
      repo = "assoc-parsing";
      rev = "8312f0f6b5711776ea2f41a3f8643de2e9583665";
      sha256 = "0bm9qc6bssm1kd95i7n2b9i7z22lcy0h6hxxr4hb3wxmphaypxiz";
    };

    cargoSha256 = "1vr8v64h0k9vykjv0kvsy849gsgfkjw5s7njizn437v5cz4z312n";
  };
}
