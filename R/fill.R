#' @title Fill a Portalcasting Directory with Basic Components
#'
#' @description Fill the directory with components including:
#'              * Web Application ([`fill_app`]) 
#'                * transfers app files from package to main
#'             
#' @param main `character` value of the name of the main component of the directory tree.
#'
#' @return `NULL`, [`invisible`][base::invisible]-ly.
#'
#' @family orchestration
#' @family content-prep
#'
#' @name directory filling
#'
#' @aliases fill
#'
NULL

#' @rdname directory-filling
#'
#' @export
#'
fill_dir <- function (main = ".") {

  settings <- read_directory_settings(main = main)

  messageq("Filling directory with content: \n", quiet = settings$quiet)

  fill_app(main = main)

  messageq("\nDirectory filling complete.", quiet = settings$quiet)

  invisible( )

}




#' @rdname directory-filling
#'
#' @export
#'
fill_app <- function (main = ".") {

  settings <- read_directory_settings(main = main)

  messageq("Setting up local web app instance ... ", quiet = settings$quiet)

  app_directory <- system.file(...     = "app", 
                               package = "ShinyDocker")

  file.copy(from      = list.files(app_directory, full.names = TRUE),
            to        = app_path(main = main),
            recursive = TRUE,
            overwrite = TRUE)

  messageq(" ... complete.\n", quiet = settings$quiet)
  invisible( )

}


