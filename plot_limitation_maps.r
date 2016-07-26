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
## Fire Season                                                         ##
#########################################################################

which.maxMonth <- function(x) {
    
    nyears = nlayers(x) / 12
    
    forYear <- function(yr) {
        index = ((yr - 1) * 12 + 1):(yr * 12)
        y = x[[index]]
        y = which.max(y)
        return(y)
    }
    
    return(layer.apply(1:nyears, forYear))
}

maxMonth = runIfNoFile('temp/maxMonth.nc', which.maxMonth, mod[[1]])

maxFireLimiation <- function(x) {
    nyears = nlayers(x) / 12
    out = x[[1]]
    out[] = NaN
    z = values(out)
    forYear <- function(yr) {
        index = ((yr - 1) * 12 + 1):(yr * 12)
        y = values(x[[index]])
        
        mnths = values(maxMonth[[yr]])
        
        for (i in 1:length(mnths))
            if (is.na(mnths[i])) z[i] = mean(y[i,])
                else z[i] = y[i, mnths[i]]
        
        out[] = z
        return(out)
    }
    out = layer.apply(1:nyears, forYear)
    out = mean(out)
    return(out)
}

fs_mod = runIfNoFile(fs_mod_files, function(x) lapply(x, maxFireLimiation), mod)
fs_mod[[2]][is.na(fs_mod[[2]])] = 1
#########################################################################
## Annual Average                                                      ##
#########################################################################

aa_mod = runIfNoFile(aa_mod_files, function(x) lapply(x, mean), mod)
aa_mod[[2]][is.na(aa_mod[[2]])] = 1




layout(matrix(1:2), height = c(1, 0.3))
par(mar = c(0,0,0,0))


plot_limtations_and_sensativity_plots <- function(pmod) {
    xy = xyFromCell(pmod[[1]], 1:length(pmod[[1]]))
    pmod = lapply(pmod[-1], values)
    if (FALSE) {
    plot_4way(xy[,1], xy[,2], pmod[[3]] / 1.5, pmod[[1]], pmod[[2]], pmod[[4]],
              x_range=c(-180,180),y_range=c(-60,90),
              cols=rev(c("FF","CC","99","55","11")),
              coast.lwd=par("lwd"),
             add_legend=FALSE, smooth_image=FALSE,smooth_factor=5)
    }  

    convert2sensativity <- function(x) 1 - 2*abs(x - 0.5)
    pmod = lapply(pmod, convert2sensativity)

    plot_4way(xy[,1], xy[,2], pmod[[3]], pmod[[1]], pmod[[2]], pmod[[4]],
              x_range=c(-180,180),y_range=c(-60,90),
              cols=rev(c("FF","CC","99","55","11")),
              coast.lwd=par("lwd"),
             add_legend=FALSE, smooth_image=FALSE,smooth_factor=5)
}

plot_limtations_and_sensativity_plots(fs_mod)

par(mar = c(3, 2, 0, 0))
add_raster_4way_legend(cols = rev(c("FF","CC","99","55","11")),
                       labs = c('<- Moisture', 'Fuel ->', 'Igntions ->', 'Supression'))


browser()


