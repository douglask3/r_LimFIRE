LimFIRE <- function(fuel, moisture, lightning, human_ignitions, agriculture, popdens,
                    f1, f2, m1, m2, H, i1, P, s1, s2) {

    ignitions  = lightning + H * human_ignitions
    supression = agriculture + P * popdens   

    Fuel       = LimFIRE.fuel      (fuel      , f1, f2)
    Moisture   = LimFIRE.moisture  (moisture  , m1, m2)
    Ignitions  = LimFIRE.ignitions (ignitions , i1    )
    Supression = LimFIRE.supression(supression, s1, s2)
    
    fire = (1 - Fuel) * (1 - Moisture) * (1 - Ignitions) * (1 - Supression)

    return(fire)
}

LimFIRE.fuel       <- function(...) 1-f1(...)
LimFIRE.moisture   <- function(...) 1-f2(...)
LimFIRE.ignitions  <- function(...) 1-f3(...)
LimFIRE.supression <- function(...) 1-f2(...)
