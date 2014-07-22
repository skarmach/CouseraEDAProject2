### This script reads the PM25 data and plots a time series of
### emission for motor vehicle source for Baltimore City.

# library for ggplot2
require(ggplot2)

# load the SCC code data file
CODE <- readRDS("Source_Classification_Code.rds")

# limit codes to Moror-Vehicles
VEHI <- CODE[grep(".*Vehicle.*", CODE$EI.Sector), c("SCC","EI.Sector")]

# load emission data
DAT <- readRDS("summarySCC_PM25.rds")
# limit to Baltimore City
DAT <- DAT[DAT$fips == 24510, ]

# merge emission data with SCC code to
# keep only motor vehicle data
VEHI_DATA <- merge(DAT, VEHI, by = "SCC")

# aggregate data into a separate data frame for convenience
plot_data <- aggregate(Emissions ~ year, VEHI_DATA, sum)

# plot on screen to check
qplot(year,
      Emissions,
      data = plot_data,
      geom = "line",
      main = "Baltimore City Motor Vehicle Emissions by Year",
      xlab = "Year",
      ylab = expression("PM"[2.5]*" Emissions")
)


# plot to png file
png(filename = "plot5.png",
    width = 400,
    height = 400,
    units = "px"
)
qplot(year,
      Emissions,
      data = plot_data,
      geom = "line",
      main = "Baltimore City Motor Vehicle Emissions by Year",
      xlab = "Year",
      ylab = expression("PM"[2.5]*" Emissions")
)


dev.off()