### This script reads the PM25 data and plots a time series of
### total-polution for Baltimore city [zip 24510].

# load the data file
DAT <- readRDS("summarySCC_PM25.rds")

# aggregate data into a separate data frame for convenience
plot_data <- aggregate(Emissions ~ year, DAT[DAT$fips == 24510, ], sum)

# plot on screen to check
with (plot_data,
      plot(year,
           Emissions,
           type = "o",
           main = "Baltimore City PM2.5 Emissions"))

# plot to png file
png(filename = "plot2.png")
with (plot_data,
      plot(year,
           Emissions,
           type = "o",
           main = "Baltimore City PM2.5 Emissions"))
dev.off()