# Question 5
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# setting working directory
setwd("C:/Users/Polina/Google Drive/data-science-coursera/exploratory data analysis/course project")

# loading packages
library(dplyr)
library(ggplot2)

# reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Adding EI.Sector info
NEI <- merge(NEI, SCC[,c(1,4)], by = "SCC")

#grouping the data by year, filtering Coal related EI.Sectors
sum <- NEI %>%
  filter(grepl("Mobile",EI.Sector) & grepl("Vehicles",EI.Sector)) %>%
  mutate(year = as.character(year)) %>%
  group_by(year, EI.Sector) %>%
  summarise(sumEmissions = sum(Emissions[fips == "24510"]), count = sum(fips == "24510"))

# Producing the graph
p <- ggplot(sum, aes(x=year, y=sumEmissions)) + 
  ylab('Amount of PM2.5 emitted (tons)')  +
  geom_bar(stat="identity") + 
  facet_wrap(~ EI.Sector,ncol=2) +
  ggtitle("Emissions from Motor Vehicle Sources by EI.Sector in Baltimore")
p

#Copying Plots to png
dev.copy(png, file = "./plot5.png")
dev.off()