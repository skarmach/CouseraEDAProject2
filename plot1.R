### This script reads the PM25 data and plots a time series of
### total-polution.

# load the data file
#CODE <- readRDS("Source_Classification_Code.rds")
DAT <- readRDS("summarySCC_PM25.rds")

# aggregate data into a separate data frame for convenience
plot_data <- aggregate(Emissions ~ year, DAT, sum)

# plot on screen to check
with (plot_data,
      plot(year,
           Emissions,
           type = "o",
           main = "US PM2.5 Emissions"))


# plot to png file
png(filename = "plot1.png")
with (plot_data,
      plot(year,
           Emissions,
           type = "o",
           main = "US PM2.5 Emissions"))

dev.off()