rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)


# Load data
load(
    file.path(dataDir, "ch01", "diabetes.RData")
)
load(
    file.path(dataDir, "ch01", "diabetesBMA.RData")
)
load(
    file.path(dataDir, "ch01", "diabetes-Xytest.RData")
)
source(
    file.path("ch01", "regression_gprior.R")
)

## Posterior summaries and comarisons to OLS

ZPM <- apply(Z, 2, mean, na.rm = TRUE)
beta.bma <- apply(BETA, 2, mean, na.rm = TRUE)

pdf(
    file = file.path(figDir, "ch01", "fig01-03.pdf"),
    family = "Times",
    height = 3.5,
    width = 7
)
    par(
        mar = c(3, 3, 1, 1),
        mgp = c(1.75, 0.75, 0)
    )
    plot(
        ZPM,
        xlab = "regressor index",
        ylab = expression(
            paste("Pr(", italic(beta[j] != 0), "|", italic(y), ",X)",
                  sep = ""
            )
        ),
        type = "h",
        lwd = 2
    )

dev.off()


y.test.mna <- X.test %*% beta.bma

pdf(
    file = file.path(figDir, "ch01", "fig01-04.pdf"),
    family = "Times",
    height = 3.5,
    width = 7
)
    par(
        mar = c(3, 3, 1, 1),
        mgp = c(1.75, 0.75, 0),
        mfrow = c(1, 2)
    )

    y.test.bma <- X.test %*% beta.bma
    beta.ols <- lm(y ~ -1 + X)$coef
    y.test.ols <- X.test %*% beta.ols
    plot(
        x = y.test,
        y = y.test.bma,
        xlab = expression(
            italic(y)[test]
        ),
        ylim = range(c(y.test.bma, y.test.ols, y.test)),
        xlim = range(c(y.test.bma, y.test.ols, y.test)),
        ylab = expression(
            hat(italic(y))[test]
        )
    )
    abline(0, 1)

    plot(
        x = y.test,
        y = y.test.ols,
        xlab = expression(
            italic(y)[test]
        ),
        ylim = range(c(y.test.bma, y.test.ols, y.test)),
        xlim = range(c(y.test.bma, y.test.ols, y.test)),
        ylab = expression(
            hat(italic(y))[test]
        )
    )
    abline(0, 1)

dev.off()

sprintf("Prediction error for OLS:                %.5f", mean((y.test - y.test.ols)^2))
sprintf("Presiction error for Bayesioan estimate: %.5f", mean((y.test - y.test.bma)^2))
