source('cfg.r')
cntr = nls.control(warnOnly = TRUE, maxiter = 100)

inter_file_name = 'temp/driving_data.csv'

start_params = list(         f1 = 100 , f2 = 1/200,
                    M = 1  , m1 = 10  , m2 = 0.1  ,
                    L = 1  , H = 1    , A  = 1   ,
                             i1 = 100 , i2 = 1/200,
                    P = 1  , s1 = 1   , s2 = 0.01   )
                    
lower_params = list(         f1 = 0.0 , f2 = 0.0,
                    M = 0  , m1 = 0.0 , m2 = 0.0,
                    L = 0  , H  = 0   , A  = 0   ,
                             i1 = 0.0 , i2 = 0.0,
                    P = 0  , s1 = 0.0 , s2 = 0.0)
                    
upper_params = list(         f1 = 9E9 , f2 = 10,
                    M = 9E9, m1 = 9E9 , m2 = 10,
                    L = 9E9, H = 9E9, A  = 9E9   ,
                             i1 = 9E9 , i2 = 10,
                    P = 9E9, s1 = 9E9 , s2 = 10   )
  
Obs = ObsRasters2DataFrame()



nls_bootstrap <- function() {
    index = sample(1:ncells, 100000, replace = FALSE)
    dat = Obs[index, ]
    res = nls( fire ~ LimFIRE(npp, alpha, emc, 1, Lightn, pas, crop, popdens,
                        f1, f2, M, m1, m2, L, H, A, i1, i2, P, s1, s2, fireOnly = TRUE), 
                data = dat, algorithm = "port",
                start = start_params, lower = lower_params, upper = upper_params,
                trace = TRUE, control = cntr)

    return(coefficients(res))
}


ncells = dim(Obs)[1]
resStore = c()

for (i in 1:100) {
   cat('\n==================\n',
       ' Bootstrap ', i, 
       '\n==================\n')
    res = nls_bootstrap()
    resStore = rbind(resStore, res)
}

write.csv( resStore, file = coefficants_file)             
