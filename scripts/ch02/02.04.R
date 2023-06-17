rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)

x <- c(467, 677, 113, 25)
xc <- c(x[1] + x[2], x[3] + x[4])
sprintf("%.2f", xc)
a <- xc[1] / sum(xc)
sprintf("%.2f", a)
