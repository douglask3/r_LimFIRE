library(benchmarkMetrics)
library(gitBasedProjects)
library(raster)
library(ncdf4)
library(rasterExtras)
library(rasterPlot)


setupProjectStructure()
sourceAllLibs()

years = 1997:2005

ml = c(31,28,31,30,31,30,31,31,30,31,30,31)
drive_fname = c(alpha   = 'alpha',
                emc     = 'emc',
                NPP     = 'NPP',
                crop    = 'cropland',
                pas     = 'pasture',
                urban   = 'urban_area',
                popdens = 'population_density',
                Lightn  = 'lightning_ignitions',
				fire    = 'fire'
                )


nms = names(drive_fname)
drive_fname = paste(outputs_dir, drive_fname, min(years), '-', max(years), '.nc', sep = '')
names(drive_fname) = nms


try(memSafeFile.remove(), silent = TRUE)
memSafeFile.initialise('temp/tempGenerated')