FROM bioconductor/bioconductor_docker:3.20

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN export BIOCONDUCTOR_USE_CONTAINER_REPOSITORY=FALSE && \
    Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); BiocManager::install(ask=FALSE)" && \
    Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); devtools::install('.', dependencies=TRUE, build_vignettes=TRUE, repos = BiocManager::repositories())"
