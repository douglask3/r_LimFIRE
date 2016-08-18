#########################################################################
## cfg                                                                 ##
#########################################################################
source('cfg.r')
graphics.off()
fig_file = 'figs/cropland_noCrop_impact.png'

mod_file = 'outputs/LimFIRE_fire'
mod_file = paste(mod_file, c('', 'noCrops'), '.nc', sep ='')

grab_cache = TRUE

#########################################################################
## Run Model                                                           ##
#########################################################################
control = runIfNoFile(mod_file[1], runLimFIREfromstandardIns, fireOnly = TRUE, 
                                       test = grab_cache)
noCrop  = runIfNoFile(mod_file[2], runLimFIREfromstandardIns, fireOnly = TRUE, 
                      remove = "crop", test = grab_cache)

#########################################################################
## Calculate Impact                                                    ##
#########################################################################
control = mean(control); noCrop = mean(noCrop)
impact = (control - noCrop) / noCrop
crop = mean(stack(drive_fname['crop']))

mask = !(is.na(impact) | is.na(crop))
impact = impact[mask]
crop   = crop  [mask] / 100

sp = smooth.spline(crop, impact)
f1 = predict(sp, 1)$y

fImpact  = (impact - f1 * crop) / (1 - crop)

#########################################################################
## plot                                                                ##
#########################################################################
png(fig_fname, width = 9, height = 6, unit = 'in', res = 300)

## calculate trend line
x = seq(0, 1, 0.001)
y =  predict(loess(fImpact ~ crop), x)

## plot window
yrange = quantile(fImpact, probs = c(0.001, 0.999))
yrange = range(c(yrange, y), na.rm = TRUE)

plot(c(0, 100), 100 * yrange, type = 'n', xlab = 'Cropland (%)', ylab = 'Impact (% of burnt area)')

## plot
points(crop * 100, fImpact * 100, col =  make.transparent('black', 0.97), pch = 16)
lines(x * 100, y * 100, lwd = 2, col = 'red')

## footer
dev.off.gitWatermark()