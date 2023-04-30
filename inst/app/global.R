stop(1234)
main_exists <- any(ls() == "main")

if (main_exists) {
  old_main <- dynGet("main", inherits = TRUE)
}

main   <- ".."

global <- global_list(main = main)

onStop(function( ) {
  rm(main, inherits = TRUE)
  if (main_exists) {
    main <<- old_main
  }
})