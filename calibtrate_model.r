source('cfg.r')
cntr = nls.control(warnOnly = TRUE)

inter_file_name = 'temp/driving_data.csv'

start_params = list(         f1 = 100 , f2 = 1/200,
                    M = 1  , m1 = 10  , m2 = 0.1  ,
                    H = 1  , i1 = 0.05,
                    P = 1  , s1 = 1   , s2 = 0.01   )
                    
lower_params = list(         f1 = 0.0 , f2 = 0.0,
                    M = 0  , m1 = 0.0 , m2 = 0.0,
                    H = 0  , i1 = 0.0 ,
                    P = 0  , s1 = 0.0 , s2 = 0.0)
                    
upper_params = list(         f1 = 9E9 , f2 = 10,
                    M = 9E9, m1 = 9E9 , m2 = 10  ,
                    H = 9E9, i1 = 100 ,
                    P = 9E9, s1 = 9E9 , s2 = 10   )


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

rasters2DataFrame <- function(x) {
    nl = sapply(x, nlayers)
    mn = min(nl)
    if (any(nl!=mn)) {
        warning("layers different in inputs. Selecting first ", mn, " layers for each")
        x = lapply(x, function(i) i[[1:mn]])
    }
    
    mask = layer.apply(x, findTotalMask)
    mask = sum(mask) == 0
    x = lapply(x,  valuesLayerByLayer, mask)
    x = data.frame(x)
    return(x)
}


#if (!file.exists(inter_file_name)) {
    Obs = lapply(drive_fname, stack)
    Obs = rasters2DataFrame(Obs)
#} else Obs = read.csv(inter_file_name, header = TRUE, nrows = 400000)[, -1]


browser()
nls_bootstrap <- function() {
    index = sample(1:ncells, 100000, replace = FALSE)
    dat = Obs[index, ]
    res = nls( fire ~ LimFIRE(npp, alpha, emc, Lightn, pas, crop, popdens,
                        f1, f2, M, m1, m2, H, i1, P, s1, s2, fireOnly = TRUE), 
                data = dat, algorithm = "port",
                start = start_params, lower = lower_params, upper = upper_params,
                trace = TRUE, control = cntr)

    return(coefficients(res))
}

nboots = 1
ncells = dim(Obs)[1]
resStore = c()

#while (nboots < 10 || (testBoot && nboots < 100)) {

for (i in 1:100) {
    nboots = nboots + 1
    res = nls_bootstrap()
    #res1 = res0 * (1-1/nboots) + res / nboots
    #if (all(signif(res, 4) == signif(res0, 4))) testBoot = FALSE else testBoot = TRUE
    resStore = rbind(resStore, res)
}


write.csv( resStore, file = coefficants_file)             