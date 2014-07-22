### This script reads the PM25 data and plots a time series of
### emission for motor vehicle source for Baltimore City
### and Los Angeles, California.

# library for ggplot2
require(ggplot2)

# load the SCC code data file
CODE <- readRDS("Source_Classification_Code.rds")
# limit codes to coal combustion
VEHI <- CODE[grep(".*Vehicle.*", CODE$EI.Sector), c("SCC","EI.Sector")]

# load emission data
DAT <- readRDS("summarySCC_PM25.rds")
# limit to Baltimore City
DAT <- DAT[DAT$fips %in% c("24510", "06037"), ]
#label counties
levels(DAT$fips) <- list("Los Angeles" = "06037", "Baltimore" = "24510")

# merge emission data with SCC code to
# keep only coal-combustion data
VEHI_DATA <- merge(DAT, VEHI, by = "SCC")

# aggregate data into a separate data frame for convenience
plot_data <- aggregate(Emissions ~ year + fips, VEHI_DATA, sum)

# plot on screen to check (facets)
qplot(year,
      Emissions,
      data = plot_data,
      facets = . ~ fips,
      geom = "line",
      main = "Motor Vehicle Emissions by Year",
      xlab = "Year",
      ylab = expression("PM"[2.5]*" Emissions")
)

# plot on screen to check (lines in one plot)
ggplot(data = plot_data,
       aes(x = year,
           y = Emissions,
           colour = fips)) +
    ggtitle("Motor Vehicle Emissions by Year") +
    geom_line()

# plot to png file
png(filename = "plot6.png",
    width = 500,
    height = 400,
    units = "px"
)
ggplot(data = plot_data,
       aes(x = year,
           y = Emissions,
           colour = fips)) +
    ggtitle("Motor Vehicle Emissions by Year") +
    geom_line()

dev.off()