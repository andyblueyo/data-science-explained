## Install and load needed libraries
#install.packages("dplyr")
library(dplyr)
#install.packages("tidyr")
library(tidyr)

## Create the messy fake data set about ice cream
flavors <- c("chocolate", "vanilla", "phish food", "ube", "strawberry", "guava sorbet")
seattle.cost <- c(3, 4, 7, 7, 3, 8)
portland.cost <- c(6, 3, 3, 9, 5, 7)
sanfran.cost <- c(10, 12, 15, 17, 11, 21)

ice.cream <- data.frame(flavors, seattle.cost, portland.cost, sanfran.cost)

## Gather the data into a more tidy form
gather.data <- ice.cream %>% gather(location, price, seattle.cost, portland.cost, sanfran.cost)

## Spread the data
spread.data <- gather.data %>% spread(flavors, price)
