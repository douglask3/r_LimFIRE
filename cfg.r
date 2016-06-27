library(benchmarkMetrics)
library(gitBasedProjects)
library(raster)
library(ncdf4)
library(rasterExtras)
library(rasterPlot)


setupProjectStructure()
sourceAllLibs()

years = 1997:2005
drive_fname = c(alpha = 'alpha',
                NPP   = 'NPP',
                crop = 'cropland',
                pas = 'pasture',
                urban = 'urban_area',
                popdens = 'population_density'
                )


nms = names(drive_fname)
drive_fname = paste(outputs_dir, drive_fname, min(years), '-', max(years), '.nc', sep = '')
names(drive_fname) = nms
