# We use multi-stage build contexts to generate different versions of the image from one dockerfile
#  base: the complete software system is installed, non executable
#  app:  executable app
#
# See https://medium.com/@tonistiigi/advanced-multi-stage-build-patterns-6f741b852fae 

# ARG for image name needs to come before FROM so it can be used in a FROM at the end
# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact

ARG image_name "base"
RUN echo "Building $image_name image"

# built upon the rocker/tidyverse image, which includes remotes and shiny

FROM rocker/tidyverse:latest AS tidyverse

# Build args, default to the base image from the main branch

ARG event_sha "HEAD"

# Install ShinyDocker from github

RUN echo "Installing ShinyDocker from github at ref $event_sha"
RUN R -e "remotes::install_github('dapperstats/ShinyDocker', ref = '$event_sha')"

# Each image branches for specific run code

FROM tidyverse AS base-branch


FROM tidyverse AS app-branch
RUN R -e "library(ShinyDocker); setup_dir( )"


# Bring the branches together

FROM ${image_name}-branch AS final
