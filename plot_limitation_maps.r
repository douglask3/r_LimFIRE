source('cfg.r')
graphics.off()

mod_files = paste(outputs_dir, '/LimFIRE_',
                 c('fire', 'fuel','moisture','ignitions','supression'),
                  sep = '')
                 
aa_mod_files = paste(mod_files, '-aa.nc', sep = '')
fs_mod_files = paste(mod_files, '-fs.nc', sep = '')
   mod_files = paste(mod_files,    '.nc', sep = '')

mod = runIfNoFile(mod_files, runLimFIREfromstandardIns)

#########################################################################
## Annual Average                                                      ##
#########################################################################

aa_mod = runIfNoFile(aa_mod_files, function(x) lapply(x, mean), mod)
aa_mod[[2]][is.na(aa_mod[[2]])] = 1

xy = xyFromCell(aa_mod[[1]], 1:length(aa_mod[[1]]))
aa_mod = lapply(aa_mod[-1], values)

layout(matrix(1:2), height = c(1, 0.3))
par(mar = c(0,0,0,0))

plot_4way(xy[,1], xy[,2], aa_mod[[3]] / 1.5, aa_mod[[1]], aa_mod[[2]], aa_mod[[4]],
          x_range=c(-180,180),y_range=c(-60,90),
    	  cols=rev(c("FF","CC","99","55","11")),
    	  coast.lwd=par("lwd"),
    	 add_legend=FALSE, smooth_image=FALSE,smooth_factor=5)

par(mar = c(3, 2, 0, 0))
add_raster_4way_legend(cols = rev(c("FF","CC","99","55","11")),
                       labs = c('<- Moisture', '<- Fuel', '<- Igntions', 'Supression'))



         
add_raster_4way_legend(cols = rev(c("FF","CC","99","55","11")))
browser()


#########################################################################
## Fire Season                                                         ##
#########################################################################

which.maxMonth <- function(x) {
    browser()
}

maxMonth = which.maxMonth(mod[[1]])
