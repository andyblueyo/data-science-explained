## Install and load needed libraries
#install.packages("dplyr")
library(dplyr)
#install.packages("tidyr")
library(tidyr)
#install.packages("ggplot2")
library(ggplot2)

## Create the messy fake data set about ice cream
flavors <- c("chocolate", "vanilla", "phish food", "ube", "strawberry", "guava sorbet")
seattle.cost <- c(3, 4, 7, 7, 3, 8)
portland.cost <- c(6, 3, 3, 9, 5, 7)
sanfran.cost <- c(10, 12, 15, 17, 11, 21)

ice.cream <- data.frame(flavors, seattle.cost, portland.cost, sanfran.cost)

## Bar chart of ice cream prices in Seattle
ggplot(ice.cream, aes(flavors, seattle.cost)) + geom_bar(stat = "identity")

## Gather the data into a more tidy form
gather.data <- ice.cream %>% gather(location, price, seattle.cost, portland.cost, sanfran.cost)

## Stacked bar chart of ice cream price and flavors
ggplot(gather.data, aes(flavors, price)) + geom_bar(stat = "identity", aes(fill = location))

## Spread the data
spread.data <- gather.data %>% spread(flavors, price)

## Bar chart of prices of chocolate in diffrent locations
ggplot(spread.data, aes(location, chocolate)) + geom_bar(stat = "identity")
