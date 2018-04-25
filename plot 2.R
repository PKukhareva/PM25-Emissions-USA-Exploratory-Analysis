# Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

# setting working directory
setwd("C:/Users/Polina/Google Drive/data-science-coursera/exploratory data analysis/course project")

# loading packages
library(dplyr)

# reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#grouping the data by year
sum <- NEI %>%
  group_by(year) %>%
  summarise(sumEmissions = sum(Emissions[fips == "24510"]), count = sum(fips == "24510"))

# Producing the graph
barplot(sum$sumEmissions, names.arg = sum$year, main="Total PM25 Emissions by Year in Baltimore City", xlab="Year", ylab="Amount of PM2.5 emitted (tons)")

#Copying Plots to png
dev.copy(png, file = "./plot2.png")
dev.off()