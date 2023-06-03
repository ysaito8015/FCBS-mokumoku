rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)


# Adjusted Wald interval

a <- 2
b <- 2
y <- 0
n <- 20
theta_hat <- (a + y) / ((a + y) + (b + n - y))

sprintf(
    "Posterior mean of theta|{Y=0} ~ beta(2+0, 2+20-0):       %.5f",
    (a + y) / ((a + y) + (b + n - y))
)

sprintf(
    "theta hat = frac{n}{n+4} * y_bar + frac{4}{n+4} * 1/2:   %.5f",
    theta_hat
)

sprintf(
    "theta hat -1.96 sqrt{theta_hat * (1 - theta_hat) / n}:  %.5f",
    theta_hat + -1 * 1.96 * sqrt(theta_hat * (1 - theta_hat) / n)
)
sprintf(
    "theta hat 1.96 sqrt{theta_hat * (1 - theta_hat) / n}:    %.5f",
    theta_hat + 1.96 * sqrt(theta_hat * (1 - theta_hat) / n)
)
sprintf(
    "Adjusted Wald interval at 0.025:                         %.5f",
    qbeta(0.025, a + y, b + n - y)
)
sprintf(
    "Adjusted Wald interval at 0.975:                         %.5f",
    qbeta(0.975, a + y, b + n - y)
)
