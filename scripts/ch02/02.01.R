rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)

pdf(
    file = file.path(figDir, "ch02", "fig02-01.pdf"),
    family = "Times",
    height = 3.5,
    width = 7
)
    par(
        mar = c(3, 3, 1, 1),
        mgp = c(1.75, 0.75, 0)
    )
    par(
        mfrow = c(1, 2)
    )


    x <- 0:10
    plot(
        x = x,
        y = dpois(x, 2.1),
        type = "h",
        lwd = 1,
        xlab = expression(italic(y)),
        ylab =
            expression(
                paste(
                    italic("p"),
                    "(",
                    italic("y"),
                    "|",
                    theta == 2.1,
                    ")"
                )
            )
    )

    x <- 0:100
    plot(
        x = x,
        y = dpois(x, 21),
        type = "h",
        lwd = 1,
        xlab = expression(italic(y)),
        ylab =
            expression(
                paste(
                    italic("p"),
                    "(",
                    italic("y"),
                    "|",
                    theta == 21,
                    ")"
                )
            )
    )

dev.off()
