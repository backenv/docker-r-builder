FROM debian:10

# Main Package installation
RUN apt update && apt install -y \
  r-base \
  r-cran-devtools \
  r-cran-rmarkdown \
  r-cran-rcpp \
  texinfo \
  texlive-fonts-extra

# Add compilers
# RUN apt install -y ....

RUN R -q -e "install.packages('roxygen2')"
RUN R -q -e "require('devtools')" && echo "R::devtools:: ready"

WORKDIR /pkg

CMD ["R", "-q -e require(devtools);document();check();build();build_manual()"]
