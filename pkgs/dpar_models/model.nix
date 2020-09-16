# We take attribute sets of arguments. The first set are arguments
# that are constant between the models (such as the dpar
# derivation to use). The second set of arguments defines specific
# models.

{ lib
, stdenvNoCC
, fetchurl

, dockerTools
, makeWrapper

, dpar
}:

{
  # Short name of the model. E.g.: nl-ud.
  modelName

  # Version of the model, typically a date. E.g.: 20200128
, version

  # The SHA-256 hash of the model.
, sha256
}:

rec {
  inherit modelName;

  dockerImage = lib.makeOverridable dockerTools.buildLayeredImage {
    name = "registry.gitlab.com/sfs-ascl/dpar-docker/${modelName}";
    tag = version;
    contents = wrapper;
    maxLayers = 100;
  };

  model = stdenvNoCC.mkDerivation rec {
    inherit version;

    pname = "dpar-model-${modelName}";

    src = fetchurl {
      inherit sha256;

      url = let
        fullName = "${modelName}-${version}";
      in "http://www.sfs.uni-tuebingen.de/a3-public-data/dpar-models/${fullName}.tar.gz";
    };

    installPhase = ''
      install -Dt $out/share/dpar/models/${modelName} -m 0644 *
    '';

    meta = with stdenvNoCC.lib; {
      homepage = https://github.com/danieldk/dpar/;
      description = "dpar ${modelName} model";
      license = licenses.unfreeRedistributable;
      maintainers = with maintainers; [ danieldk ];
      platforms = platforms.unix;
    };
  };

  wrapper = stdenvNoCC.mkDerivation rec {
    inherit version;

    pname = "dpar-${modelName}-wrapper";

    nativeBuildInputs = [ makeWrapper ];

    dontUnpack = true;

    installPhase = ''
      makeWrapper ${dpar}/bin/dpar-parse $out/bin/dpar-parse-${modelName} \
        --add-flags "${model}/share/dpar/models/${modelName}/parser.conf"
    '';

    meta = with stdenvNoCC.lib; {
      homepage = https://github.com/danieldk/dpar/;
      description = "dpar ${modelName} model wrapper";
      license = licenses.unfreeRedistributable;
      maintainers = with maintainers; [ danieldk ];
      platforms = platforms.unix;
    };
  };
}
