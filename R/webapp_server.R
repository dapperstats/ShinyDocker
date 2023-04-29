
#' @title Generate the Server Code for the Web App
#' 
#' @param main `character` value of the name of the main component of the directory tree.
#'
#' @param rv [`reactiveValues`][shiny::reactiveValues] `list` for the UI.
#'
#' @param input `input` `list` for the UI.
#'
#' @param output `output` `list` for the UI.
#'
#' @param event `character` value of the server event. \cr
#'
#' @param session Environment for the UI.
#'
#' @param global A `list` of global values for the app.
#'
#' @return `app_server`: an observer reference class object (see [`observeEvent`][shiny::observeEvent] and [`observe`][shiny::observe]). \cr
#'         `initial_reactive_values`: a [`reactiveValues`][shiny::reactiveValues] `list`. \cr
#'         `initial_output`: an `output` `list`. \cr
#'
#' @family shinyapp
#'
#' @aliases web-app-server app-server server
#'
#' @name app server
#'
#' @examples
#' \dontrun{
#'    main1 <- file.path(tempdir(), "app")
#'    setup_dir(main = main1)
#'
#'    global <- global_list(main = main1)
#'  
#'    rv     <- initial_reavtive_values(global = global)
#'
#'    output <- initial_output(main   = main1,
#'                             global = global,
#'                             rv     = rv,
#'                             output = list())
#'
#'    unlink(main1, recursive = TRUE)
#'  }
#'
NULL


#' @rdname app-server
#'
#' @export
#'
app_server <- function (input, 
                        output, 
                        session) {

  rv     <- initial_reactive_values(global = global)

  output <- initial_output(main   = main,
                           global = global,
                           rv     = rv, 
                           output = output)

}


#' @rdname app-server
#'
#' @export
#'
initial_reactive_values <- function (global = global_list( )) {

  reactiveValues( )
  
}


#' @rdname app-server
#'
#' @export
#'
initial_output <- function (main = ".",
                            global,
                            rv, 
                            output) {

  output 

}
