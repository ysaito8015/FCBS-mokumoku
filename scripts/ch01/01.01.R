rm(list = ls())
gc()

source(here::here("scripts", "environments.R"))
.libPaths(libDir)
pacman::p_load(tidyverse)

# infected rate, range 0.05 - 0.20, mean 0.10
a <- 2  # a patameter of beta distribution
b <- 20 # a patameter of beta distribution
print("theta: infected rate")
print("Parameter space: Theta = [0,1], theta in Theta")
print("y: count of infected people in sample")
print("Sample space: mathcal{Y} = {0,1,...,20}, y in mathcal{Y}")
print("Y|theta ~ binomial(20, theta)")
print("the true infection rate is 0.05, then the probability that there will be zero infected infividuals in the sample is 36%")
sprintf("p({Y=0}|{theta = 0.05}) ~ binom(20, 0.05):         %.5f", dbinom(x = 0, size = 20, prob = 0.05))
print("the prior distribution: theta ~ beta(2, 20)")
# mean of theta ~ beta(a, b), expectation of the prior distribution
sprintf("Mean of theta ~ beta(2, 20):                       %.5f", a / (a + b)) # [1] 0.09090909
# mode of theta ~ beta(a, b), mode of the prior distribution
sprintf("Mode of theta ~ beta(2, 20):                       %.5f", (a - 1) / ((a - 1) + (b - 1))) # [1] 0.05
# p(theta < 0.10), the prior distribution
sprintf("p(theta < 0.10), theta  ~ beta(2, 20):             %.5f", pbeta(q = 0.10, shape1 = a, shape2 = b)) # [1] 0.63527 64%
# range of p(0.05 < theta < 0.20), the prior distribution
sprintf("p(0.05 < theta < 0.20), theta  ~ beta(2, 20):      %.5f", pbeta(0.20, a, b) - pbeta(0.05, a, b)) # [1] 0.6593258 66%

n <- 20  # number of samples
x <- 0:n # individuals
y <- 0   # nubmer of infected

# If Y|theta ~ binomial(n, theta) and theta ~ beta(a, b)
print("If Y|theta ~ binomial(n, theta) and theta ~ beta(a, b)")
print("theta|{Y=y} ~ beta(a + y, b + n - y)")
print("If y = 0 then theta|{Y=0} ~ beta(2, 40)")
# mean of theta|{Y=0} ~ beta(a + y, b + n - y), the posterior distribution
sprintf("Mean of theta|{Y=0} ~ beta(2+0, 20+20-0):          %.5f", a / (a + b + n)) # [1] 0.04761905
# mode of theta|{Y=0} ~ beta(a + y, b + n - y), the posterior distribution
sprintf("Mode of theta|{Y=0} ~ beta(2+0, 20+20-0):          %.5f", (a + y - 1) / ((a - 1) + (b + n - 1))) # [1] 0.025
# p(theta < 0.10|Y=0), the posterior distribution
sprintf("p(theta < 0.10|{Y=0}) ~ beta(2+0, 20+20-0):        %.5f", pbeta(0.10, a + y, b + n - y)) # [1] 0.9260956 93%
# p(0.05 < theta < 0.20|Y=0), the posterior distribution
sprintf("p(0.05 < theta < 0.20|{Y=0}) ~ beta(2+0, 20+20-0): %.5f", pbeta(0.20, a + y, b + n - y) - pbeta(0.05, a + y, b + n - y)) # [1] 0.3843402 38%

#jpeg(
pdf(
    file = file.path(figDir, "ch01", "fig01-01.pdf"),
    family = "Times",
    height = 3.5,
    width = 7
)
# Left
    par(
        mar = c(3, 3, 1, 1),
        mgp = c(1.75, 0.75, 0)
    )
    par(
        mfrow = c(1, 2)
    )
    del <- 0.25
    plot(
         range(x - del),
         c(0, 0.4),
         xlab = "number infected in the sample",
         ylab = "probability",
         type = "n"
    )

    points(
           x-del,
           dbinom(x, n, 0.05),
           type = "h",
           col = gray(0.75),
           lwd = 3
    )
    points(
           x,
           dbinom(x, n, 0.10),
           type = "h",
           col = gray(0.5),
           lwd = 3
    )
    points(
           x+del,
           dbinom(x, n, 0.20),
           type = "h",
           col = gray(0),
           lwd = 3
    )
    legend(
           10,
           0.35,
           legend = c(
                      expression(paste(theta, "= 0.05", sep = "")),
                      expression(paste(theta, "= 0.10", sep = "")),
                      expression(paste(theta, "= 0.20", sep = ""))
           ),
           lwd = c(3, 3, 3),
           col = gray(c(0.75, 0.5, 0)),
           bty = "n"
    )

# Right
    theta <- seq(0, 1, length = 500)
    plot(
         theta,
         dbeta(theta, a + y, b + n - y),
         xlab = "percentage infected in the population",
         ylab = "",
         type = "l",
         lwd = 2,
         ylim = c(0, 16)
    )
    lines(
          theta,
          dbeta(theta, a, b),
          col = "gray",
          lwd = 2
    )
    legend(
           0.5,
           14,
           legend = c(
                      expression(paste(italic("p"), "(", theta, ")", sep = "")),
                      expression(paste(italic("p"), "(", theta, "|", italic("y"), ")", sep = ""))
           ),
           lwd = c(2, 2),
           col = c("gray", "black"),
           bty = "n"
    )

dev.off()


#p <-
#    pressure %>%
#    ggplot() +
#    aes(x = temperature, y = pressure) +
#    geom_line()
#ggsave(
#    filename = file.path(figDir, "ch02", "fig02-04-left.jpeg"),
#    plot = p
#)
#
#p <-
#    pressure %>%
#    ggplot() +
#    aes(x = temperature, y = pressure) +
#    geom_line() +
#    geom_point()
#ggsave(
#    filename = file.path(figDir, "ch02", "fig02-04-right.jpeg"),
#    plot = p
#)
