# Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# setting working directory
setwd("C:/Users/Polina/Google Drive/data-science-coursera/exploratory data analysis/course project")

# loading packages
library(dplyr)

# reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#grouping the data by year
sum <- NEI %>%
  mutate(tons1000 = Emissions/1000) %>%
  group_by(year) %>%
  summarise(sumEmissions = sum(tons1000), count = n())

# Producing the graph
barplot(sum$sumEmissions, names.arg = sum$year, main="Total PM25 Emissions by Year", xlab="Year", ylab="Amount of PM2.5 emitted (1000 tons)")

#Copying Plots to png
dev.copy(png, file = "./plot1.png")
dev.off()