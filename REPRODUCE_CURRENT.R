# Reproduce the analysis and all numerical evidence from the untouched raw CSV.
local({
  run_current <- function() {
    original_directory <- getwd()
    args <- grep('^--file=',commandArgs(FALSE),value=TRUE)
    start <- if(length(args)) dirname(sub('^--file=','',args[1])) else original_directory
    root <- normalizePath(start,mustWork=TRUE)
    while(!file.exists(file.path(root,'data/raw/Sheet1-Table 1.csv'))) {
      parent <- dirname(root)
      if(identical(parent,root)) stop('Cannot locate the project source CSV.')
      root <- parent
    }
    on.exit(setwd(original_directory),add=TRUE)
    setwd(root)
    for(script in c('01_fit_primary.R','02_fit_secondary.R',
                    '03a_dependence_support.R','03b_interpretation_checks.R',
                    '03_finalize_model.R','07_parsimonious_revision.R',
                    '09_project_story_figures.R')) {
      message('Running analysis step: ',script)
      source(file.path(root,'scripts',script),local=new.env(parent=globalenv()))
    }
  }
  run_current()
})
