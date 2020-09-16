## Introduction

This repository contains [Nix](https://nixos.org/) derivations for
[dpar](https://github/danieldk/dpar) and dpar models.

## Building dpar

The different `dpar` flavors can be built as follows from this
repository:

dpar:

```bash
$ nix-build -A dpar
$ result/bin/dpar-parse
```

Patricia Fisher's dpar extension supporting PMIs:

```bash
$ nix-build -A dpar-fifu-pmi
```

## dpar models

The model can be built as a Nix package or as a docker image,
the following attributes are used:

* Nix package: `dpar_models.<modelname>.wrapper`
* Docker image: `dpar_models.<modelname>.dockerImage`

[Prebuilt Docker images](https://gitlab.com/SfS-ASCL/dpar-docker)
are also available.

### German Harmburg-style dependencies

Nix package:

```bash
$ nix-build -A dpar_models.de.wrapper
$ result/bin/dpar-parse-de
```

Docker image:

```bash
$ nix-build -A dpar_models.de.dockerImage
$ docker load < ./result
```
