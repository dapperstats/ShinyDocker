
#' @title Generate the Server Code for the Web App
#'
#' @param rv [`reactiveValues`][shiny::reactiveValues] `list` for the UI.
#'
#' @param input `input` `list` for the UI.
#'
#' @param output `output` `list` for the UI.
#'
#' @param session Environment for the UI.
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
#'
NULL


#' @rdname app-server
#'
#' @export
#'
app_server <- function (input, 
                        output, 
                        session) {

  rv     <- initial_reactive_values( )

  output <- initial_output(rv     = rv, 
                           output = output)

messageq(break_lines(5))
print(list.files())
messageq(break_lines())
print(list.files(".."))

}


#' @rdname app-server
#'
#' @export
#'
initial_reactive_values <- function ( ) {

  reactiveValues( )
  
}


#' @rdname app-server
#'
#' @export
#'
initial_output <- function (rv, 
                            output) {

  output 

}
