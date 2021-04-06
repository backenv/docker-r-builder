# DOCKER IMAGE FOR BUILDING R PACKAGES

Runs `devtools`'s `check()` and `build()`on `WORKDIR`.

Container default working directory is `/pkg`, so only `-v </your/Rpkg/name>:/pkg` option is needed.

## Preinstalled code

From debian repository (with `--no-install-recommends` flag)

- `build-essential`
- `r-base-core`
- `r-cran-rmarkdown`
- `r-cran-rcpp`
- `libcurl4-openssl-dev`
- `libssl-dev`
- `libxml2`

From r-cran repository

- `devtools`
- `dplyr`
- `rlang`
- `roxygen2`

> NOTE: Package dependencies MUST be added as additional layer before container usage,
>
> `--build_arg DEB_DEPS | PKG_DEPS` allow for `apt` and `install.packages` from build

## Usage

```bash
# Pass package dependencies at build time
docker build -t r-builder:deps \
    --build-arg DEB_DEPS="<debian-package-1> ... <debian-package-n>" \
    --build-arg PKG_DEPS="<R-package-1> ... <R-package-n>" \
    https://raw.githubusercontent.com/burgeon-env/docker-r-builder/main/Dockerfile

# Reuse container with dependencies to check code
docker run \
    -v /<path>/<to>/<R>/<package>:/pkg
    r-builder:deps

```

## Examples

For a package with no extra dependencies requirement:

```bash
# Image from Docker Hub
docker run \
    -v /my-R-package:/pkg
    burgeonenv/r-builder:latest

```

For a package that imports `ggplot2` and `plumber` packages (local rebuild):

```bash
# Dockerfile from GitHub
docker build -t r-builder:deps \
    --build-arg DEB_DEPS="libsodium-dev" \
    --build-arg PKG_DEPS="ggplot2 plumber" \
    https://raw.githubusercontent.com/burgeon-env/docker-r-builder/main/Dockerfile

docker run \
    -v /my-R-package:/pkg
    r-builder:deps

```
