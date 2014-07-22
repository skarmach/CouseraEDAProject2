### This script reads the PM25 data and plots a time series of
### emission for types point, nonpoint, onroad and nonroad
### for Baltimore City.

# library for ggplot2
require(ggplot2)
require(data.table)
# load the data file
DAT <- readRDS("summarySCC_PM25.rds")
DAT <- data.table(DAT)
setkey(DAT, year, type)

# aggregate data into a separate data frame for convenience
#plot_data <- aggregate(Emissions ~ year + type, DAT, sum)
plot_data <- DAT[, sum(Emissions), by = "year, type"]

# plot on screen to check
qplot(year,
      V1,
      data = plot_data,
      geom = "line",
      facets = . ~ type,
      main = "Baltimore City Emissions by Year and Type",
      xlab = "Year",
      ylab = expression("PM"[2.5]*" Emissions")
)


# plot to png file
png(filename = "plot3.png",
    width = 900,
    height = 300,
    units = "px"
)
qplot(year,
      V1,
      data = plot_data,
      geom = "line",
      facets = . ~ type,
      main = "Baltimore City Emissions by Year and Type",
      xlab = "Year",
      ylab = expression("PM"[2.5]*" Emissions")
)

dev.off()