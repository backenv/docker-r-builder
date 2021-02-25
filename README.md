# DOCKER IMAGE FOR BUILDING R PACKAGES

### Includes `devtools` and `roxygen2`

## Usage

Runs `document()`,`check()`,`build()` and `build_manual()` on `WORKDIR`.

Container default working directory is `/pkg`, so only `-v </your/Rpkg/name>:/pkg` option is needed.

> NOTE: Package dependencies MUST be added as additional layer before container usage
