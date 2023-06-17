rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)

pdf(
    file = file.path(figDir, "ch02", "fig02-03.pdf"),
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
    x <- seq(7.75, 13.75, length = 100)

    plot(
        x = x,
        y = dnorm(x = x, mean = mu, sd = sig) * 1e5,
        type = "l",
        lwd = 1,
        xlab = expression(italic(y)),
        ylab =
            expression(
                10^5 * paste(
                    italic("p"),
                    "(",
                    italic("y"),
                    ")"
                )
            )
    )
    abline(v = mu, lty = 1, col = gray(0))
    abline(v = mu, lty = 2, col = gray(0.33))
    abline(v = mu, lty = 4, col = gray(0.66))


    mu <- 10.75
    sig <- 0.8
    x <- seq(0, 300000, length = 200)

    plot(
        x = x,
        y = dlnorm(x = x, mean = mu, sd = sig) * 1e5, # Log Normal Distribution
        type = "l",
        lwd = 1,
        xlab = expression(italic(y)),
        ylab =
            expression(
                10^5 * paste(
                    italic("p"),
                    "(",
                    italic("y"),
                    ")"
                )
            )
    )
    abline(v = 24600, col = gray(0))
    abline(v = qlnorm(p = 0.5, mean = mu, sd = sig), col = gray(0.3), lty = 2)
    abline(v = exp(mu + 0.5 * sig^2), col = gray(0.7), lty = 4)
    legend(
        x = 150000,
        y = 1.0,
        legend = c("mode", "median", "mean"),
        col = gray(c(0, 0.33, 0.66)),
        lty = c(1, 2, 4),
        bty = "n",
        cex = 0.85
    )

dev.off()
