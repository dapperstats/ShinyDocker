#' @title Create a Directory Settings List
#'
#' @description Compose parts of and complete directory settings controls lists. \cr \cr
#'              Most users will not want or need to change the directory folders and file names, but it is helpful to have them be flexible for certain circumstances, and `directory_files`, `directory_subdirectories`, and `directory_settings` gather them into a set of lists for pipeline functionality. \cr
#'
#' @param files `list` of `character` names of standard files, see [`directory_files`].
#'
#' @param subdirectories `list` of `character` names of standard subdirectories, see [`directory_subdirectories`].
#'
#' @param app `character` name for the app subdirectory.
#'
#' @param save `logical` indicator controlling if the output should be saved out.
#'
#' @param overwrite `logical` indicator of whether or not file writing should occur even if a local copy already exists.
#'
#' @param force `logical` indicator of whether or not existing files or folders (such as the archive) should be over-written if an up-to-date copy exists (most users should leave as `FALSE`).
#'
#' @return Named `list` of settings for the directory (for `directory_settings`) or `list` of settings components (for `directory_files`, `directory_subdirectories`).
#'
#' @name directory settings
#'
#' @aliases settings
#'
#' @family orchestration
#' @family customization
#'
#' @examples
#'    directory_settings( )
#'    directory_files( )
#'    directory_subdirectories( )
#'
#'
NULL

#' @rdname directory-settings
#'
#' @export
#'
directory_settings <- function (files             = directory_files( ),
                                subdirectories    = directory_subdirectories( ),
                                save              = TRUE,
                                overwrite         = TRUE, 
                                force             = FALSE) {

  list(files            = files,
       subdirectories   = subdirectories,
       save             = save, 
       overwrite        = overwrite,
       force            = force)

}


#' @rdname directory-settings
#'
#' @export
#'
directory_files <- function ( ) {

  list()

}


#' @rdname directory-settings
#'
#' @export
#'
directory_subdirectories <- function (app       = "app") {

  list(app       = app)

}







