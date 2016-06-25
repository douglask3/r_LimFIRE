realtive_humidity <- function(vap_pres, T) {
	vap_pres_sat = 6.11 * 10 ^ ((7.5 * T)/ 237.5 + T)
	return(vap_pres / vap_pres_sat)
}