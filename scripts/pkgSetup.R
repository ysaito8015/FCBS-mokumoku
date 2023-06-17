source("environments.R", echo = TRUE)

.libPaths(libDir)

pkgs <- c(
    ## missing in R v4.3.0
    "stringi",
    "backports", # broom
    "generics",
    "gtable", # ggplot
    "timechange", # lubiridate
    "modelr",
    "rvest",
    "readr", # tidyverse
    "selectr",
    "scales", # ggplot
    "tzdb", # tidyverse
    ## missing in R v4.3.0
    "vctrs",
    "tidyselect",
    "tidyverse",
    "gcookbook",
    "pacman",
    "here",
    "readxl"
)

Sys.setenv(PKG_CXXFLAGS="-std=gnu++20 -DBOOST_PHOENIX_NO_VARIADIC_EXPRESSION")


install.packages(
    c("devtools", "remotes"),
    lib = libDir,
    contriburl = c(
        contrib.url("http://r-forge.r-project.org", "source"),
        contrib.url("https://cran.rstudio.com/", "source")
    ),
    destdir = pkgDir,
    type = "source",
    #dependencies = c("Depends", "Imports", "LinkingTo"),
    dependencies = TRUE,
    INSTALL_opts = "--no-multiarch"
)

install.packages(
    pkgs,
    lib = libDir,
    contriburl = c(
        contrib.url("http://r-forge.r-project.org", "source"),
        contrib.url("https://cran.rstudio.com/", "source")
    ),
    destdir = pkgDir,
    type = "source",
    #dependencies = c("Depends", "Imports", "LinkingTo"),
    dependencies = TRUE,
    INSTALL_opts = "--no-multiarch"
)
