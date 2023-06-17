rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)

pdf(
    file = file.path(figDir, "ch02", "fig02-02.pdf"),
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


    mu <- 10.75
    sig <- 0.8
    x <- seq(7.9, 13.9, length = 500)

    plot(
        x = x,
        y = pnorm(q = x, mean = mu, sd = sig),
        type = "l",
        lwd = 1,
        xlab = expression(italic(y)),
        ylab =
            expression(
                paste(
                    italic("F"),
                    "(",
                    italic("y"),
                    ")"
                )
            )
    )
    abline(h = c(0, 0.5, 1), col = "gray")

    plot(
        x = x,
        y = dnorm(x = x, mean = mu, sd = sig),
        type = "l",
        lwd = 1,
        xlab = expression(italic(y)),
        ylab =
            expression(
                paste(
                    italic("p"),
                    "(",
                    italic("y"),
                    ")"
                )
            )
    )
    abline(v = mu, col = "gray")

dev.off()
