# Question 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

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
  filter(grepl("Coal",EI.Sector)) %>%
  mutate(year = as.character(year), tons1000 = Emissions/1000) %>%
  group_by(year, EI.Sector) %>%
  summarise(sumEmissions = sum(tons1000), count = n())

# Producing the graph
p <- ggplot(sum, aes(x=year, y=sumEmissions)) + 
  ylab('Amount of PM2.5 emitted (1000 tons)')  +
  geom_bar(stat="identity") + 
  facet_wrap(~ EI.Sector,ncol=2) +
  ggtitle("Emissions from Coal Combustion-Related Sources by EI.Sector")
p

#Copying Plots to png
dev.copy(png, file = "./plot4.png")
dev.off()