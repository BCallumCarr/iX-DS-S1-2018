# ------------------------------------------------------
# Make New Friends
# Brad Carruthers
# ------------------------------------------------------

# Just a quick function to make new friends

make_new_friends <- function() {
  # create randomly uniform-distributed variable between 0.5001 and 3.4999
  temp_x <- runif(1, min = 0.5001, max = 3.4999) 
  # print out some cool text because I'm cool like that 
  cat("My random number is", temp_x, "\nso I must move to table", round(temp_x, 0), "...\n\nPS: This is the best class ever.", "\nPPS: Can't wait to make new friends.")
}

make_new_friends()

library(ggplot2)

dat <- as.data.frame(round(runif(100000, 0.5001, 3.4999), 0)) 

ggplot(dat, mapping = aes(dat[,1])) +
  geom_bar()

