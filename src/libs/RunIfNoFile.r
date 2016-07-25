runIfNoFile <- function(file, FUN, test = TRUE, ...) {
    if (test && file.exists(file)) return(stack(file))
    
    r = FUN(...)
    r = writeRaster(r, file, overwrite = TRUE)
    
    return(r)
}
    