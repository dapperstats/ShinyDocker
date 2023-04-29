
#' @title Generate the User Interface for the Web App
#' 
#' @description `app_ui` constructs the user interface (UI) for the web application
#'              See `Details` for hierarchy of functions. 
#'
#' @details The UI is hierarchical built as:
#'   * `app_ui` 
#'
#' @param main `character` value of the name of the main component of the directory tree.
#'
#' @param global A `list` of global values for the app.
#'
#' @return A UI definition, component shiny tags, or bootswatch theme.
#'
#' @family shinyapp
#'
#' @aliases web-app-ui app-ui ui
#'
#' @name app ui
#'
#'
NULL



#' @rdname app-ui
#'
#' @export
#'
app_ui <- function (global = global_list( )) {

  fluidPage(title = "HI HOW ARE YOU?",
            theme = app_theme( ))


}

#' @rdname app-ui
#'
#' @export
#'
app_theme <- function ( ) {

  bs_theme(bootswatch = "materia",
           font_scale = 1.1)

}
