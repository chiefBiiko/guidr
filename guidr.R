# guidr - Chief R Style Guide
#
# Usage
#   source('https://github.com/chiefBiiko/guidr/raw/master/guidr.R')
#   guidr()  # view the Chief R Style Guide within RStudio

#' Opens the Chief R Style Guide in RStudio's viewer pane.
#' 
#' @param pull Should an up-2-date version of the guide be downloaded?
#' @return void; 
#' 
#' @details This function is called for its side effects: downloading 
#' the html file to a persistent local file, copying it to
#' a temporary file, and rendering it in RStudio's viewer pane.
#' 
guidr <- function(pull=FALSE) {
  stopifnot(rstudioapi::isAvailable('0.98.423'))
  # delete temporary directory once html been loaded
  on.exit({Sys.sleep(2L); unlink(temp.dir, recursive=TRUE)})
  # location of persistent local storage for html guide
  GUIDR <- file.path(.libPaths()[1L], 'guidr', 'guidr.html')
  # persistent local storage
  if (!dir.exists(file.path(.libPaths()[1L], 'guidr'))) {
    dir.create(file.path(.libPaths()[1L], 'guidr'))
  }
  # make sure guide is available
  if (!file.exists(GUIDR) || pull) {
    dlcd <- download.file('https://github.com/chiefBiiko/guidr/raw/master/guidr.html', GUIDR)
    if (dlcd != 0L) stop('Download error.')
  }
  # setup temporary directory
  dir.create(temp.dir <- tempfile())
  # copy html from persistent local storage to temporary file
  cpcd <- file.copy(GUIDR, temp.html <- file.path(temp.dir, "guidr.html"))
  if (!cpcd) stop('File system error: Could\'nt copy HTML file 2 temp dir.')
  # render html in RStudio's viewer pane
  rstudioapi::viewer(temp.html, height=-1L)
  message('(-*c*):: If u prefer a big window click "Zoom" in the viewer pane!')
}