################################################################################
## cfg                                                                        ##
################################################################################
## Libraries etc
source('cfg.r')
sourceAllLibs('src/weather/')

## paths and parameters
dir   = 'data/cru_ts3.23/'
varns = c(wetday = 'wet',
          vap    = 'vap',
          temp   = 'tmp')

clim_layers = 73:288

################################################################################
## load data                                                                  ##
################################################################################
c(dat, nyears) := loadClimDat

################################################################################
##                                                          ##
################################################################################

make_emc <- function(i) {
        Wet = dat[['wetday']][[i]]
	Vap = dat[['vap'   ]][[i]]
	Tas = dat[['temp'  ]][[i]]
	Hr = realtivi_humidity(Tas, Vap)
	emc = fuel_moisture_equilibrium(0, Hr, Tas)
        browser()
        emc = emc * (1-Wet) + 100 * Wet
        
        return(emc)
}


emc = layer.apply(1:(12*nyears), make_emc)

################################################################################
## run and output                                                             ##
################################################################################


writeRaster.gitInfo(emc, drive_fname['emc'], overwrite = TRUE)
