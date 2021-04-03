FROM debian:10

# Main Packages installation
RUN apt update && apt install -y \
  r-base \
  r-cran-devtools \
  r-cran-rmarkdown \
  r-cran-rcpp \
  texinfo \
  texlive-fonts-extra

# Add compilers
# RUN apt install -y ....

ARG PKG_DEPS
ARG DEB_DEPS

RUN if [ ! -z "${DEB_DEPS}" ]; then \
        apt install -y $(echo ${DEB_DEPS}); \
    fi

RUN for i in $(echo "roxygen2 ${PKG_DEPS}"); do \
        R -q -e "install.packages('${i}')"; \
    done

RUN R -q -e "require('devtools')" && echo "R::devtools:: ready"

WORKDIR /pkg

CMD ["R", "-q","-e require(devtools);document();check();build();build_manual()"]
