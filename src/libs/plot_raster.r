plot_raster <- function(x, lims, cols, ...)
    plot_raster_from_raster(x, add_legend = FALSE,
                            limits = lims, cols = cols, 
                            x_range = c(-160, 160),
                            y_range = c(-60, 90), projection = "mollweide",
                            ...) #projection = "azequalarea",