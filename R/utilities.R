#' @title Find an Object's Host Package and Version Information
#'
#' @description Locate basic package information of an R object. If nothing is input, it operates on itself. \cr
#'              If the object is sourced through multiple packages, each package and its version are included.
#'
#' @param what An R object.
#'
#' @return `list` of the object, its class, the packages it is sourced from / through, and the versions of those packages.
#'
#' @name package_version_finder
#'
#' @family utilities
#'
#' @examples
#'    package_version_finder( )
#'
NULL

#' @rdname package_version_finder
#'
#' @export
#'
package_version_finder <- function (what) {

  if (missing(what)) {

    what <- "package_version_finder"

  }

  object_expr       <- parse(text         = what)
  object_eval       <- eval(expr          = object_expr)
  object_class      <- class(x            = object_eval)
  location_name     <- find(what          = what)
  packages_names    <- sapply(X           = location_name,
                              FUN         = gsub,
                              pattern     = "package\\:",
                              replacement = "")
  packages_versions <- sapply(X           = packages_names,
                              FUN         = packageDescription,
                              fields      = "Version")
  
  names(packages_versions) <- packages_names

  list(object   = what,
       class    = object_class,
       package  = packages_names,
       version  = packages_versions)

}


#' @title Create a Named Empty List
#'
#' @description Produces a list with `NULL` for each element named according to `element_names`.
#' 
#' @param element_names `character` vector of names for the elements in the list.
#'
#' @return `list` with names `element_names` and values `NULL`.
#'
#' @name named_null_list 
#'
#' @family utilities
#'
#' @examples
#'    named_null_list(c("a", "b", "c"))
#'
NULL

#' @rdname named_null_list 
#'
#' @export
#'
named_null_list <- function (element_names = NULL) {

  return_if_null(element_names)

  nelements  <- length(element_names)
  out        <- vector("list", nelements)
  names(out) <- element_names

  out

}

#' @title Update a List's Elements
#'
#' @description Update a list with new values for elements
#'
#' @param list `list` to be updated with `...`. 
#'
#' @param ... Named elements to update in `list`
#'
#' @return Updated `list`.
#'
#' @name update_list
#'
#' @family utilities
#'
#' @examples
#'    orig_list <- list(a = 1, b = 3, c = 4)
#'    update_list(orig_list)
#'    update_list(orig_list, a = "a")
#'    update_list(orig_list, a = 10, b = NULL)
#'
NULL

#' @rdname update_list
#'
#' @export
#'
update_list <- function (list = list(),
                                ...) {

  if (!is.list(list)) {

    stop("`list` must be a list")

  } 

  update_elems <- list(...)

  nupdate_elems <- length(update_elems)
  norig_elems   <- length(list)

  updated_list <- named_null_list(element_names = names(list))

  if (norig_elems > 0) {

    for (i in 1:norig_elems) {

      if (!is.null(list[[i]])) {

        updated_list[[i]] <- list[[i]]

      }

    }

  }

  if (nupdate_elems > 0) {

    names_update_elems <- names(update_elems)

    for (i in 1:nupdate_elems) {

      if (!is.null(update_elems[[i]])) {

        updated_list[[names_update_elems[i]]] <- update_elems[[i]]

      }

    }

  }

  updated_list

}


