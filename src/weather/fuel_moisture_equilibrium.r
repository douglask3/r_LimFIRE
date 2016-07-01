fuel_moisture_equilibrium <- function(Pr, Hr, T) {
    m_eq = 10 - 0.25 *(T - Hr)
    m_eq[Pr > 3] = 100

    return(m_eq)
}


