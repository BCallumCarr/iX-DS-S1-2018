# ------------------------------------------------------
# lapply used correctly
# Brad Carruthers
# ------------------------------------------------------

library(kknn)
library(Metrics)
library(ISLR)

head(Auto)

train.index = sample(c("train", "test"), nrow(Auto), replace = TRUE, c(0.8, 0.2))
#
auto = split(Auto, train.index)lapply(1:20, function(k) {
  # knn formula
  fit <- kknn(mpg ~ cylinders + weight, auto$train, auto$test, k = k)
  #put it into a dataframe and rename columns
  data.frame(
    k,
    rmse = rmse(auto$test$mpg, fitted(auto.kknn)))
}
) %>% bind_rows() #use dplyr to remove list-y vibes