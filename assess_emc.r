source('cfg.r')
sourceAllLibs('src/weather/')

Hr  = seq(0, 100, 0.01)
Tas = seq(-10, 60, 0.01)

testHr <- function(T) {
    print(T)
    emc = fuel_moisture_equilibrium(0, Hr, T)
    i = which.min(emc)
    return(c(Hr[i], emc[i]))
}

out = sapply(Tas, testHr)


