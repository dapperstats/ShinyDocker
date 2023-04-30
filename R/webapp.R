#' @title Build and Launch the Web Application
#' 
#' @description `run_app` constructs and launches a local version of the web application by running [`shiny::runApp`] pointed to the `app` subdirectory.
#'              `global_list` creates a list of values that are globally available in an app run.
#'
#' @param main `character` value of the name of the main component of the directory tree.
#'
#' @return `global_list`: a `list` of values that will be globally available in the app. \cr
#'         `run_app` runs the app itself.
#'
#' @name app
#'
#' @family shinyapp
#'
#' @aliases web-app app
#'
#' @examples
#' \dontrun{
#'    main1 <- file.path(tempdir(), "app")
#'    setup_dir(main = main1)
#'
#'    global_list(main = main1)
#'
#'    if (getShinyOption("shiny.launch.browser")) {
#'      run_app(main = main1)
#'    }
#'
#'    unlink(main1, recursive = TRUE)
#'  }
#'
NULL

#' @rdname app
#'
#' @export
#'
run_app <- function(main = ".") {

  runApp(appDir = app_path(main = main))

}

#' @rdname app
#'
#' @export
#'
deploy_app <- function(main = ".") {

  setAccountInfo(name   = Sys.getenv("SHINY_ACCOUNT"),
                 token  = Sys.getenv("SHINY_TOKEN"),
                 secret = Sys.getenv("SHINY_SECRET"),
                 server = "shinyapps.io")

  deployApp(appDir = app_path(main = main))

}


#' @rdname app
#'
#' @export
#
global_list <- function (main = ".") {

  settings <- read_directory_settings(main = main)

  messageq("HI!", quiet = !settings$verbose)

  list(settings = settings$quiet)
 
}
