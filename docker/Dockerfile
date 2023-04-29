# We use multi-stage build contexts to generate different versions of the image from one dockerfile
#  base: the complete software system is installed, non executable
#  app:  executable app
#
# See https://medium.com/@tonistiigi/advanced-multi-stage-build-patterns-6f741b852fae 

# built upon the rocker/tidyverse image, which includes remotes and shiny

FROM rocker/tidyverse:latest AS tidyverse

# Build args, default to the base image from the main branch

ARG image_name "base"
ARG event_sha "HEAD"

RUN echo "Building $image_name image from $event_sha"

# Install ShinyDocker from github

RUN echo "Installing ShinyDocker from github at ref $event_sha"
RUN R -e "remotes::install_github('dapperstats/ShinyDocker', ref = '$event_sha')"


# dev

# Each image branches for specific run code

FROM tidyverse AS base-branch

FROM tidyverse AS app-branch
RUN R -e "library(ShinyDocker); setup_dir( )"
EXPOSE 3838
CMD ["R", "-e", "print(1312)"]

FROM ${image_name}-branch AS final
