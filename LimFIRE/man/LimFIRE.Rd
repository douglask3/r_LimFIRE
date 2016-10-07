\name{LimFIRE}
\alias{LimFIRE}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
LimFIRE(fuel, moisture_live, moisture_dead, background_igntions, lightning, human_ignitions, agriculture, popdens, f1, f2, M, m1, m2, L, H, A, i1, i2, P, s1, s2, fireOnly = FALSE, sensitivity = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fuel}{
%%     ~~Describe \code{fuel} here~~
}
  \item{moisture_live}{
%%     ~~Describe \code{moisture_live} here~~
}
  \item{moisture_dead}{
%%     ~~Describe \code{moisture_dead} here~~
}
  \item{background_igntions}{
%%     ~~Describe \code{background_igntions} here~~
}
  \item{lightning}{
%%     ~~Describe \code{lightning} here~~
}
  \item{human_ignitions}{
%%     ~~Describe \code{human_ignitions} here~~
}
  \item{agriculture}{
%%     ~~Describe \code{agriculture} here~~
}
  \item{popdens}{
%%     ~~Describe \code{popdens} here~~
}
  \item{f1}{
%%     ~~Describe \code{f1} here~~
}
  \item{f2}{
%%     ~~Describe \code{f2} here~~
}
  \item{M}{
%%     ~~Describe \code{M} here~~
}
  \item{m1}{
%%     ~~Describe \code{m1} here~~
}
  \item{m2}{
%%     ~~Describe \code{m2} here~~
}
  \item{L}{
%%     ~~Describe \code{L} here~~
}
  \item{H}{
%%     ~~Describe \code{H} here~~
}
  \item{A}{
%%     ~~Describe \code{A} here~~
}
  \item{i1}{
%%     ~~Describe \code{i1} here~~
}
  \item{i2}{
%%     ~~Describe \code{i2} here~~
}
  \item{P}{
%%     ~~Describe \code{P} here~~
}
  \item{s1}{
%%     ~~Describe \code{s1} here~~
}
  \item{s2}{
%%     ~~Describe \code{s2} here~~
}
  \item{fireOnly}{
%%     ~~Describe \code{fireOnly} here~~
}
  \item{sensitivity}{
%%     ~~Describe \code{sensitivity} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (fuel, moisture_live, moisture_dead, background_igntions, 
    lightning, human_ignitions, agriculture, popdens, f1, f2, 
    M, m1, m2, L, H, A, i1, i2, P, s1, s2, fireOnly = FALSE, 
    sensitivity = FALSE) 
{
    if (sensitivity) {
        FUN.fuel = dLimFIRE.fuel
        FUN.moisture = dLimFIRE.moisture
        FUN.ignitions = dLimFIRE.ignitions
        FUN.supression = dLimFIRE.supression
    }
    else {
        FUN.fuel = LimFIRE.fuel
        FUN.moisture = LimFIRE.moisture
        FUN.ignitions = LimFIRE.ignitions
        FUN.supression = LimFIRE.supression
    }
    moisture = (moisture_live + M * moisture_dead)/(1 + M)
    ignitions = (background_igntions + L * lightning + H * human_ignitions + 
        A * popdens)/(1 + L + H + A)
    supression = (agriculture + P * popdens)/(1 + P)
    Fuel = FUN.fuel(fuel, f1, f2)
    Moisture = FUN.moisture(moisture, m1, m2)
    Ignitions = FUN.ignitions(ignitions, i1, i2)
    Supression = FUN.supression(supression, s1, s2)
    Fire = (1 - Fuel) * (1 - Moisture) * (1 - Ignitions) * (1 - 
        Supression)
    if (fireOnly) 
        return(Fire)
    return(list(Fire, Fuel, Moisture, Ignitions, Supression))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
