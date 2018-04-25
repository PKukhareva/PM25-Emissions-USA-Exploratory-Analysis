# Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

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

#grouping the data by year, filtering by EI.Sectors and fips
sum <- NEI %>%
  filter(grepl("Mobile",EI.Sector) & grepl("Vehicles",EI.Sector) & fips %in% c("24510", "06037")) %>%
  mutate(year = as.character(year), county=ifelse(fips == "24510", "Baltimore City", ifelse(fips == "06037", "Los Angeles County", NA))) %>%
  group_by(year, county) %>%
  summarise(sumEmissions = sum(Emissions), count = n())

# Producing the graph
p <- ggplot(sum, aes(x=year, y=sumEmissions)) + 
  ylab('Amount of PM2.5 emitted (tons)')  +
  geom_bar(stat="identity") + 
  facet_wrap(~ county,ncol=2) +
  ggtitle("Emissions from Motor Vehicle Sources in Baltimore City and LA County")
p

#Copying Plots to png
dev.copy(png, file = "./plot6.png")
dev.off()