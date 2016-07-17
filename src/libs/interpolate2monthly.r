interpolate2monthly <- function(dat) {
    interpolateMonths <- function(i) {
        print(i)
        monthly <- function(m) {
            print(m)
            w2 = (1/12) * (m-1)
            w1 = 1 - w2
            int = dat[[i]] *  w1 + dat[[i+1]] * w2
            int = writeRaster(int,  memSafeFile(), overwrite = TRUE)
            return(int)
        }
        layer.apply(1:12, monthly)
    }

    dat = layer.apply(1:(nlayers(dat)-1), interpolateMonths)
    return(dat)
}