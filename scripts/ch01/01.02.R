rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)

a <- 2
b <- 20
y <- 0
n <- 20


pdf(
    file = file.path(figDir, "ch01", "fig01-02.pdf"),
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


    g <- 50
    theta0 <- seq(0.01, 0.5, length = g) # prior means
    w0 <- seq(1, 25, length = g) # represents our confidence in the guess

    # 50 x 50 matrices
    # PM: posterior means
    # PP10: Posterior Cumulative Distribution function of beta on prob <= 0.10
    # PLQ: Posterilor Probability of beta at prob = 0.05
    # PHQ: Posterilor Probability of beta at prob = 0.95
    PP10 <- PM <- PLQ <- PUQ <- matrix(0, g, g)
    for(i in 1:g) {
        for(j in 1:g) {
            a <- w0[i] * theta0[j]       # confidence * prior means
            b <- w0[i] * (1 - theta0[j]) # confidence * (1 - prior means)

            # y = 0, n = 20
            # Posterior Means
            PM[i,j]   <- (a + y) / (a + y + b + n - y)
            # Posterior Cumulative Distribution function of beta(prob = 0.10, shape1 = a+y, shape2 = b+n-y)
            PP10[i,j] <- pbeta(0.10, a + y, b + n - y)
            # Posterior Probability of beta(prob = 0.05, shape1 = a+y, shape2 = b+n-y)
            PLQ[i,j]  <- qbeta(0.05, a + y, b + n - y)
            # Posterior Probability of beta(prob = 0.95, shape1 = a+y, shape2 = b+n-y)
            PUQ[i,j]  <- qbeta(0.95, a + y, b + n - y)
        }
    }

    # Left
    contour( # Create a contour plot, or add contour lines to an existing plot.
        x = w0,
        y = theta0,
        z = PM, # a matrix
        xlab = expression(italic(w)),
        ylab = expression(theta[0])
    )
    # Right
    contour(
        x = w0,
        y = theta0,
        z = PP10, # a matrix
        xlab = expression(italic(w)),
        levels = c(0.1, 0.3, 0.5, 0.70, 0.90, 0.975)
    )

dev.off()

a <- 1
b <- 1
#sprintf("Posterior Mean of theta, E[theta|Y = 0]:    %.5f", (a + y) / (b + n - y))
sprintf("Posterior Mean of theta, E[theta|Y = 0]:    %.5f", (a + y) / ((a + y) + (b + n - y)))
sprintf("Posterior Mode of theta,                    %.5f", (a + y - 1) / (a + y - 1 + b + n - y - 1))
sprintf("p(theta < 0.10|Y = 0):                      %.5f", pbeta(0.10, a + y, b + n - y))
