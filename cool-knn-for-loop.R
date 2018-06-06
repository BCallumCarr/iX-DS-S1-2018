# ------------------------------------------------------
# Knn Classification
# Brad Carruthers
# ------------------------------------------------------

library(kknn)
library(Metrics)

# glass ---------------------------------------------------------------------------------------------------------------

# Predict the type of glass based on various oxide contents.
#
data(glass)
head(glass)

train.index = sample(c("train", "test"), nrow(glass), replace = TRUE, c(0.8, 0.2))
#
glass = split(glass, train.index)

glass.kknn <- kknn(Type ~ ., glass$train, glass$test, k = 5, kernel = "rectangular", distance = 2)
#
# - Predictions are made for the "test" set using the data in the "train" set.
# - There is no actual "model" being built.
#
# PARAMETERS:
#
# * distance
#
# The distance parameter determines what sort of distance metric is used.
#
# It's the order of the Minkowski distance (https://en.wikipedia.org/wiki/Minkowski_distance).
#
# Typical values are:
#
#   distance = 1 -> Manhattan distance
#   distance = 2 -> Euclidean distance
#
# * kernel
#
# The kernel determines how the contribution from each of the neighbours is weighted. The 'rectangular' kernel gives
# an unweighted result, whereas others (like "triangular" and "gaussian") give a higher weight to closer neighbours.

# Retrieve the predicted probability for each class.
#
summary(glass.kknn)

# Just the predicted class.
#
predict(glass.kknn)

# Generate a confusion matrix.
#
(confusion <- table(predict(glass.kknn), glass$test$Type))
#
# Accuracy.
#
sum(diag(confusion)) / sum(confusion)

# Q. The value of k = 5 was chosen arbitrarily. Find the value which optimises accuracy.

for (k in c(1, 3, 5, 7, 9, 11, 13, 15, 17)) {
  # do stuff
  glass.knn.model <- kknn(Type ~ ., glass$train, glass$test, k = k, kernel = "rectangular", distance = 2)
  accuracy <- mean(predict(glass.knn.model) == glass$test$Type)
  print(sprintf("k = %d - accuracy = %.2f%%", k, accuracy))
}


### Double for loop?
# 
# for (i in c(1, 2, 3) k in c(1, 3, 5, 7, 9, 11, 13, 15, 17)) {
# # do stuff
# print(sprintf("i = %d, k = %d: accuracy = %.2f%%", k, 
#               mean(predict(kknn(Type ~ ., glass$train, glass$test, k = k, kernel = "rectangular", distance = i)) == glass$test$Type)))
#}


