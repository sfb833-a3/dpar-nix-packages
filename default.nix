{ pkgs ? import (import ./nix/sources.nix).nixpkgs {} }:

rec {
  dpar = pkgs.callPackage pkgs/dpar {
    inherit libtensorflow;
  };

  dpar_models = pkgs.callPackage pkgs/dpar_models {
    inherit dpar;
  };

  # Pin Tensorflow to our preferred version.
  libtensorflow = with pkgs; callPackage ./pkgs/libtensorflow {
    inherit (linuxPackages) nvidia_x11;
    cudatoolkit = cudatoolkit_10_1;
    cudnn = cudnn_cudatoolkit_10_1;
  };
}
