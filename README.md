# DOCKER IMAGE FOR BUILDING R PACKAGES

### Includes `devtools` and `roxygen2`

## Usage

```bash
docker build -t r-builder:deps \
    --build-arg DEB_DEPS="libsodium-dev" \
    --build-arg PKG_DEPS="ggplot2 plumber" \
    https://raw.githubusercontent.com/burgeon-env/docker-r-builder/main/Dockerfile

```

Runs `document()`,`check()`,`build()` and `build_manual()` on `WORKDIR`.

Container default working directory is `/pkg`, so only `-v </your/Rpkg/name>:/pkg` option is needed.

> NOTE: Package dependencies MUST be added as additional layer before container usage,
>
> `--build_arg DEB_DEPS | PKG_DEPS` allow for `apt` and `install.packages` from build
