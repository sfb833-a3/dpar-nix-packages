{ lib
, recurseIntoAttrs
, stdenvNoCC
, fetchurl
, dockerTools
, makeWrapper
, dpar
}:

let
  dparModel = import ./model.nix {
    inherit lib stdenvNoCC fetchurl dockerTools makeWrapper dpar;
  };
in lib.mapAttrs (_: value: recurseIntoAttrs value) {
  de = dparModel {
    modelName = "de";
    version = "20190325";
    sha256 = "0r2xlywgr2gaqnf48j2z30vnnwvhpk90ll3y1153x2nr6qqxkqbs";
  };
}
