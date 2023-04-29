# Package Creation Workflow

install.packages(pkgs         = c("devtools", "usethis"),
                 repos        = "http://cran.us.r-project.org",
                 dependencies = TRUE)

usethis::create_package(path   = ".",
                        fields = list(Title       = "R Package Shiny App in Docker",
                                      Description = "Toy example package with a shiny app that is dockerized and served",
                                      Version     = "0.0.1",
                                      License     = usethis::use_gpl3_license( ),
                                      `Authors@R` = person(given    = "Juniper L.",
                                                           family   = "Simonis",
                                                           email    = "simonis@dapperstats.com",
                                                           role     = c("aut", "cre"),
                                                           comment  = c(ORCID = "0000-0001-9798-0460"))))

devtools::document()