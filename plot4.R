### This script reads the PM25 data and plots a time series of
### emission for types point, nonpoint, onroad and nonroad
### for Baltimore City.

# library for ggplot2
require(ggplot2)

# load the SCC code data file
CODE <- readRDS("Source_Classification_Code.rds")
# limit codes to coal combustion
COAL <- CODE[grep("^Fuel Comb.*Coal.*", CODE$EI.Sector), ]

# load emission data
DAT <- readRDS("summarySCC_PM25.rds")

# merge emission data with SCC code to
# keep only coal-combustion data
COAL_DATA <- merge(DAT, COAL, by = "SCC")

# aggregate data into a separate data frame for convenience
plot_data <- aggregate(Emissions ~ year, COAL_DATA, sum)

# plot on screen to check
qplot(year,
      Emissions,
      data = plot_data,
      geom = "line",
      main = "US Coal Combustion Emissions by Year",
      xlab = "Year",
      ylab = expression("PM"[2.5]*" Emissions")
)


# plot to png file
png(filename = "plot4.png",
    width = 400,
    height = 400,
    units = "px"
)
qplot(year,
      Emissions,
      data = plot_data,
      geom = "line",
      main = "US Coal Combustion Emissions by Year",
      xlab = "Year",
      ylab = expression("PM"[2.5]*" Emissions")
)

dev.off()