plot_raster <- function(x, lims = fire_lims, cols = fire_cols, add_legend = FALSE,...)
    plot_raster_from_raster(x, add_legend = add_legend,
                            limits = lims, cols = cols, 
                            #x_range = c(-160, 160),
                            y_range = c(-60, 90), #projection = "mollweide",
                            ...) #projection = "azequalarea",