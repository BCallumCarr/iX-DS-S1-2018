# ------------------------------------------------------
# Logistic Regression
# Brad Carruthers
# ------------------------------------------------------

library(ISLR)
library(ROCR)
library(Epi)
library(vcdExtra)
library(MASS)
library(ggplot2)
library(dplyr)
library(mlbench)

# devtools::install_github("DataWookie/exegetic")
#
library(exegetic)

head(exam)

(exam.plot <- ggplot(exam, aes(x = hours, y = pass)) +
    geom_point(alpha = 0.5, size = 3) +
    scale_x_continuous(limits = c(0, 12), breaks = seq(0, 12, 3)) +
    labs(x = "Hours of study", y = "Pass"))

fit <- glm(pass ~ hours, exam, family = binomial)
summary(fit)

exam.predict <- data.frame(hours = seq(0, 12, 0.1))
#
exam.predict$pass <- predict(fit, exam.predict, type = "response")

exam.plot + geom_line(data = exam.predict, aes(x = hours, y = pass))

exp(0.215) / (1+exp(0.215))

6.5*1.71-10.9 # logan: 6.5 hours studying and alexander: 10 hours of studying