#' @title Create or Update the Structure of a Directory and Fill It with Content or Update an Existing Directory
#'
#' @description Instantiates the necessary folder structure for a directory, writes the setup configuration file, and fills the directory with content. \cr 
#'              Options for pre-defined setups include `setup_sandbox` for quick and flexible builds and `setup_production` for robust, rigid builds, as defined in [`directory_settings`]. \cr
#'              `update_dir` updates an existing directory and `update_sandbox` and `update_production` are companions akin to their `setup_<>` functions.
#'
#' @param quiet `logical` indicator if progress messages should be quieted.
#'
#' @param main `character` value of the name of the main component of the directory tree. Default value (`"."`) roots the directory in the present location. 
#'
#' @param settings `list` of controls for the directory, with defaults set in [`directory_settings`].
#'
#' @param verbose `logical` indicator of whether or not to produce all of the messages.
#'
#' @return The `list` of directory settings [`invisible`][base::invisible]-ly.
#'
#' @name directory creation
#'
#' @aliases create setup update directory directory-setup directory-creation directory-update
#'
#' @family orchestration
#'
NULL

#' @rdname directory-creation
#'
#' @export
#'
create_dir <- function(main     = ".", 
                       settings = directory_settings( ), 
                       quiet    = FALSE, 
                       verbose  = FALSE){

  out <- mapply(FUN          = dir.create, 
                path         = file.path(main, settings$subdirectories),
                recursive    = TRUE,
                showWarnings = FALSE)

  if (any(out)) {
    messageq(" Creating folders: \n", paste0("   ", names(out)[out], "\n"), quiet = quiet)
  }

  write_directory_configuration(main     = main, 
                                settings = settings, 
                                quiet    = quiet)

}



#' @rdname directory-creation
#'
#' @export
#'
update_dir <- function (main     = ".",
                        settings = directory_settings( ), 
                        quiet    = FALSE, 
                        verbose  = FALSE) {

  core_package <- package_version_finder("setup_dir")

  messageq(break_lines( ), "This is ", core_package[["package"]], " v", core_package[["version"]], "\n", 
           break_line( ), "Updating directory at\n  ", normalizePath(file.path(main = main), mustWork = FALSE), "\n  ",
           format(Sys.time(), "%x %T %Z"), "\n", break_lines( ), quiet = quiet)

  out <- mapply(FUN          = dir.create, 
                path         = file.path(main, settings$subdirectories),
                recursive    = TRUE,
                showWarnings = FALSE)

  if (any(out)) {
    messageq(" Creating folders: \n", paste0("   ", names(out)[out], "\n"), quiet = quiet)
  }

  messageq("Updating directory configuration file ... \n ... done.\n", quiet = quiet)

  write_directory_configuration(main     = main, 
                                settings = settings, 
                                quiet    = quiet)

  fill_dir(main = main)

  messageq(break_lines( ), "Directory successfully updated.\n", break_lines( ), quiet = quiet)

  read_directory_configuration(main = main)

}

#' @rdname directory-creation
#'
#' @export
#'
setup_dir <- function (main     = ".",
                       settings = directory_settings( ), 
                       quiet    = FALSE, 
                       verbose  = FALSE) {

  core_package <- package_version_finder("setup_dir")

  messageq(break_lines( ), "This is ", core_package[["package"]], " v", core_package[["version"]], "\n", 
           break_line( ), "Establishing directory at\n  ", normalizePath(file.path(main = main), mustWork = FALSE), "\n  ",
           format(Sys.time(), "%x %T %Z"), "\n", break_lines( ), quiet = quiet)

  create_dir(main     = main, 
             settings = settings,
             quiet    = quiet,
             verbose  = verbose)

  fill_dir(main = main)

  messageq(break_lines( ), "Directory successfully instantiated.\n", break_lines( ), quiet = quiet)

  read_directory_configuration(main = main)

}



#' @title Create, Write, and Read the Directory Configuration File
#' 
#' @description The directory configuration file is a special file within the directory setup and has its own set of functions. \cr \cr
#'              `write_directory_configuration` creates the YAML metadata configuration file. It is (and should only be) called from within [`setup_dir`], as it captures information about the compute environment used to instantiate the directory. \cr \cr
#'              `read_directory_configuration` reads the YAML config file into the R session. \cr \cr
#'              `read_directory_settings` reads the YAML config file into the R session and pulls just the directory settings list in.
#'
#' @param quiet `logical` indicator if progress messages should be quieted.
#'
#' @param main `character` value of the name of the main component of the directory tree. 
#'
#' @param verbose `logical` indicator of whether or not to print out all of the messages.
#'
#' @param settings `list` of controls for the directory, with defaults set in [`directory_settings`].
#'
#' @return `list` of directory configurations, [`invisible`][base::invisible]-ly.
#'
#' @name directory configuration file
#'
#' @aliases config configuration dir-config directory-config
#'
#' @family orchestration
#' @family read-write
#'
NULL

#' @rdname directory-configuration-file
#'
#' @export
#'
write_directory_configuration <- function (main     = ".", 
                                           settings = directory_settings( ), 
                                           quiet    = FALSE,
                                           verbose  = FALSE){

  core_package_version <- package_version_finder("write_directory_configuration")

  config <- list(setup = list(date                 = as.character(Sys.Date()),
                              R_version            = sessionInfo()$R.version,
                              core_package_name    = core_package_version[["package"]],
                              core_package_version = core_package_version[["version"]]),
                 tree  = list(main                 = main, 
                              subdirectories       = settings$subdirectories))
  settings <- c(settings, 
                quiet    = quiet,
                verbose  = verbose)
  config <- update_list(list     = config, 
                        settings = settings)

  write_yaml(x    = config, 
             file = file.path(main, "directory_configuration.yaml"))

  invisible(config)

}



#' @rdname directory-configuration-file
#'
#' @export
#'
read_directory_configuration<- function (main = ".") {
  
  if (!file.exists(main)) {

    stop("Directory not found at '", main, "' -- run `create_dir`")

  }

  config <- tryCatch(
              read_yaml(file.path(main, "directory_configuration.yaml")),
              error = function(x){NA}, 
              warning = function(x){NA})
  
  if (length(config) == 1 && is.na(config)) {

    stop("Directory configuration file not found in '", main, "' -- run `create_dir`")

  }

  invisible(config)

}


#' @rdname directory-configuration-file
#'
#' @export
#'
read_directory_settings <- function (main = ".") {
  
  read_directory_configuration(main = main)$settings
 
}


#' @title Create a List of Full Directory Paths
#' 
#' @description Upon creation (or updating) of the directory, all the standard file and subdirectory paths are set based on [`directory_settings`]. \cr
#'              `paths` produces the full path `list`, whose contents can then also be accessed with specialized functions, see `Details`.
#'
#' @details Wrapper functions for specific subdirectories and files include:   
#'   * Files 
#'     * `directory_configuration_path` 
#'   * Subdirectories
#'     * `app_path`  
#'
#' @param main `character` value of the name of the main component of the directory tree. 
#'
#' @return `list` of directory paths or specific `character` paths.
#'
#' @name directory paths
#'
#' @aliases paths
#'
#' @family orchestration
#'
#'
NULL

#' @rdname directory-paths
#'
#' @export
#'
paths <- function (main = ".") {

  settings <- read_directory_settings(main = main)

  subdirectories        <- as.list(file.path(main, settings$subdirectories))
  names(subdirectories) <- settings$subdirectories

  files <- list(directory_configuration   = file.path(main, "directory_configuration.yaml"))

  list(main           = main,
       subdirectories = subdirectories,
       files          = files)
 
}

#' @rdname directory-paths
#'
#' @export
#'
app_path <- function (main = ".") {

  paths(main = main)$subdirectories$app
  
}

#' @rdname directory-paths
#'
#' @export
#'
directory_configuration_path <- function (main = ".") {

  paths(main = main)$files$directory_configuration
  
}
