FROM rocker/r-ver:4.5.0

ENV RENV_VERSION=v1.0.3
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
RUN R -e "options(renv.config.repos.override = 'https://packagemanager.posit.co/cran/latest')"

COPY R ./fec
WORKDIR /fec

#RUN R -e "renv::restore()"

EXPOSE 3838

CMD ["R", "-e", "fec::run_app('./app.R', host = '0.0.0.0', port = 3838)"]

