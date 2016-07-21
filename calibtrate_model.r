
cntr = nls.control(warnOnly = TRUE)

sf1 = 100
sf2 = 1/200
sM  = 1
sm1 = 100
sm2 = 10
sH  = 1
si1 = 0.05
sP  = 1
ss1 = 10
ss2 = 10

findTotalMask <- function(r) {
    mask = is.na(r[[1]])
    for (i in 2:nlayers(r)) mask = mask + is.na(r[[i]])
    mask = mask > 0 
    mask = writeRaster(mask, file = memSafeFile(), overwrite = TRUE)
    return(mask)
}

valuesLayerByLayer <- function(r, mask) {
    lmask = sum.raster(mask)
    v = rep(NaN, lmask * nlayers(r))
    for (i in 1:nlayers(r)) {
        index = seq((i-1) * lmask + 1, i * lmask)
        v[index] = r[[i]][mask]
    }
    return(v)
}

rasters2DataFrame <- function(x, names) {
    nl = sapply(x, nlayers)
    mn = min(nl)
    if (any(nl!=mn)) {
        warning("layers different in inputs. Selecting first ", mn, " layers for each")
        x = lapply(x, function(i) i[[1:mn]])
    }
    
    mask = layer.apply(x, findTotalMask)
    mask = sum(mask) == 0
    x = lapply(x,  valuesLayerByLayer, mask)
    x = data.frame(x, names = names)
    return(x)
}

Obs = lapply(drive_fname, stack)
names = names(drive_fname)

Obs = rasters2DataFrame(Obs, names)

browser()
res <- nls( fire ~ LimFIRE(fuel, moisture_live, moisture_dead,
                    lightning, human_ignitions,
                    agriculture, urban,
                    f1, f2, M, m1, m2, H, i1, P, s1, s2), data = Obs,
              start = list(f1 = sf1, f2 = sf2, M = sM, m1 = sm1, m2 = sm2, H = sH, i1 = si1, P = sP, s1 = ss1, s2 = ss2), 
              trace = TRUE, control = cntr)
              
write.csv( summary(res), file = 'outputs/coefficants')             