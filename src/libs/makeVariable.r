makeVariable <- function(FUN, vname, nyears) {
    VAR = layer.apply(1:(12*nyears), FUN)
    writeRaster.gitInfo(VAR, drive_fname[vname], overwrite = TRUE)
    return(VAR)
}