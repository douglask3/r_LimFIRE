citation.text <- function(...) {
    cit = citation('rstash')
    class(cit) = 'list'
    return(attr(cit[[1]], 'textVersion'))
}
