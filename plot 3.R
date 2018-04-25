# Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

# setting working directory
setwd("C:/Users/Polina/Google Drive/data-science-coursera/exploratory data analysis/course project")

# loading packages
library(dplyr)
library(ggplot2)

# reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#grouping the data by year
sum <- NEI %>%
  mutate(year = as.character(year)) %>%
  group_by(year, type) %>%
  summarise(sumEmissions = sum(Emissions[fips == "24510"]), count = sum(fips == "24510"))

# Producing the graph
p <- ggplot(sum, aes(x=year, y=sumEmissions)) + 
  ylab('Amount of PM2.5 emitted (tons)')  +
  geom_bar(stat="identity") + 
  facet_wrap(~ type,ncol=2)+
  ggtitle("Amount of PM2.5 emitted by Type in Baltimore")
p
#Copying Plots to png
dev.copy(png, file = "./plot3.png")
dev.off()