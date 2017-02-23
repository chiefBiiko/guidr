# guidr - Chief R Style Guide
#
# Usage
#   source('https://github.com/chiefBiiko/guidr/raw/master/guidr.R')
#   guidr()  # view the Chief R Style Guide within RStudio

guidr <- function(pull=F) {
  # Opens the Chief R Style Guide in RStudio's viewer pane.
  # @param {bool} pull Should an up-2-date version of the guide be downloaded?
  stopifnot(rstudioapi::isAvailable('0.98.423'))
  GUIDR <- file.path(.libPaths()[1], 'guidr', 'guidr.html')
  if (!dir.exists(file.path(.libPaths()[1], 'guidr'))) {
    dir.create(file.path(.libPaths()[1], 'guidr'))
  }
  if (!file.exists(GUIDR) || pull) {
    dlcd <- download.file('https://github.com/chiefBiiko/guidr/raw/master/guidr.html', GUIDR)
    if (dlcd != 0) stop('Download error.')
  }
  dir.create(temp.dir <- tempfile())
  cpcd <- file.copy(GUIDR, temp.html <- file.path(temp.dir, "guidr.html"))
  if (!cpcd) stop('File system error: Could\'nt copy HTML file 2 temp dir.')
  rstudioapi::viewer(temp.html, height=-1)
  message('(-*c*):: If u prefer a big window click "Zoom" in the viewer pane!')
}