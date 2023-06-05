rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)


# Diabetes example
load(
    file.path(dataDir, "ch01", "diabetes.RData")
)

## setup data
### yf
yf <- diabetes$y
yf <- (yf - mean(yf)) / sd(yf)
# head(yf)

### Xf
Xf <- diabetes$X
Xf <- t((t(Xf) - apply(Xf, 2, mean)) / apply(Xf, 2, sd))
# head(Xf)

## Set up training and test data
n <- length(yf)
set.seed(1)

i.test  <- sample(1:n, 100)
i.train <- (1:n)[-i.test]

y <- yf[i.train]
y.test <- yf[i.test]

X <- Xf[i.train,]
X.test <- Xf[i.test,]

save(
    y,
    y.test,
    X,
    X.test,
    file = file.path(dataDir, "ch01", "diabetes-Xytest.RData")
)


## MCMC for BMA
p <- dim(X)[2]
S <- 10000

source(
    file.path("ch01", "regression_gprior.R")
)

runmcmc <-
    any( # Given a set of logical vectors, is at least one of the values true?
        # system() invokes the OS command specified by `command`
        # intern: a logical (not `NA`) which indicates whether to capture the output of the comand as an R character vector.
        system("ls ../data/ch01", intern = TRUE) == "diabetesBMA.RData"
    )
cat(runmcmc)

if (runmcmc == TRUE) {
    load(
        file.path(dataDir, "ch01", "diabetesBMA.RData")
    )
} else {
    BETA <- Z <- matrix(NA, S, p)
    z <- rep(1, dim(X)[2])
    lpy.c <- lpy.X(y, X[, z == 1, drop = FALSE])
    for (s in 1:S)
    {
        for (j in sample(1:p))
        {
            zp <- z
            zp[j] <- 1 - zp[j]
            lpy.p <- lpy.X(y, X[, zp == 1, drop = FALSE])
            r <- (lpy.p - lpy.c) * (-1)^(zp[j] == 0)
            z[j] <- rbinom(1, 1, 1 / (1 + exp(-r)))
            if (z[j] == zp[j]) {
                lpy.c <- lpy.p
            }

            beta <- z
            if (sum(z) > 0) {
                beta[z == 1] <- lm.gprior(y, X[, z == 1, drop = FALSE], S = 1)$beta
            }
            Z[s, ] <- z
            BETA[s, ] <- beta
            if (s %% 10 == 0) {
                cat(s, "\n")
            }
        }
    }
    save(
        BETA,
        Z,
        y.test,
        X.test,
        file = file.path(dataDir, "ch01", "diabetesBMA-edited.RData")
    )
}
