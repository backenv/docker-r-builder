FROM debian:10

# Minimal Packages for R package development testing
RUN apt update && \
    apt install --no-install-recommends -y \
        build-essential \
        r-base-core \
        r-cran-rmarkdown \
        r-cran-rcpp \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev

RUN R -q \
    -e "install.packages(c('dplyr', 'rlang', 'roxygen2', 'devtools'))"

RUN apt install -y locales && \
    sed -i 's/^# \(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    sed -i 's/^# \(en_GB.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen

ARG PKG_DEPS=''
ARG DEB_DEPS=''

# Add debian dependencies
RUN if [ ! -z "${DEB_DEPS}" ]; then \
        apt install -y $(echo ${DEB_DEPS}); \
    fi

# Add R package dependencies
RUN if [ ! -z "${DEB_DEPS}" ]; then \
        for i in $(echo "${PKG_DEPS}"); do \
            R -q -e "install.packages('${i}')"; \
        done; \
    fi

RUN R -q -e "require('devtools')" && echo "R::devtools:: ready"

WORKDIR /pkg

CMD ["R", "-q","-e devtools::check();devtools::build(path='/pkg');"]
