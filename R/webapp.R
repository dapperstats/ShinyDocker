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
messageq(break_lines(5))
print(list.files())
messageq(break_lines())
print(list.files(".."))


  deployApp(appDir = app_path(main = main), forceUpdate = TRUE, appName = "ShinyDocker")

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
