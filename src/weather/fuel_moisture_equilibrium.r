fuel_moisture_equilibrium <- function(Pr, Hr, T) {
    
    m_eq_test = m_eq(Hr - 0.01, T)
    m_eq      = m_eq(Hr       , T)
       
    m_eq[m_eq_test > m_eq] = 0
    m_eq[Hr == 0] = 0

    m_eq[Pr > 3] = 100

    m_eq[m_eq > 100] = 100
    m_eq[m_eq < 0] = 0

    
    m_eq = 10 - 0.25 *(T - Hr)
    return(m_eq)
}

m_eq <- function(Hr, T)  m_eq1(Hr) + m_eq2(Hr) + m_eq3(Hr, T )



m_eq1 <- function(Hr) 0.942 * Hr ^ (-.679)

m_eq2 <- function(Hr) 0.000499 * exp (0.1 * Hr)

m_eq3 <- function(Hr, T) 0.18 * (21.1 - T) * (1 - exp(-0.115 * Hr))
