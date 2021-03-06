% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nicheOverlap.r
\name{nicheOverlap}
\alias{nicheOverlap}
\title{Calculate niche overlap as per Broennimann et al. (2012)}
\usage{
nicheOverlap(x1, x2, env, vars, bins = 100, cor = TRUE, densities = FALSE)
}
\arguments{
\item{x1}{Data frame, matrix, or any object that can be coerced to a data frame containing environmental data at occurrence sites of a species.}

\item{x2}{Data frame, matrix, or any object that can be coerced to a data frame containing environmental data at occurrence sites of another species.}

\item{env}{Either a data frame, matrix, or any object that can be coerced to a data frame containing environmental data at available background sites, \emph{or} an object of class \code{princomp} representing a principal components analysis generated using the \code{\link[stats]{princomp}} function with argument \code{scores = TRUE}.}

\item{vars}{Either a character list naming columns in \code{x1}, \code{x2}, and \code{x3} to be used as environmental data, \emph{or} positive integers indexing the columns to be used as environmental data.}

\item{bins}{Number of bins into which to divide the environmental space (default is 100 on each side).}

\item{cor}{Logical, if \code{TRUE} (default), then the PCA used to construct the environmental space will use the correlation matrix (this is highly recommended if the variables are on different scales). This is ignored if \code{env} is an object of class \code{princomp}.}

\item{densities}{Logical. If \code{TRUE}, then return not only metrics of niche similarity but also the density matrices (environment, species #1, and species #2).}
}
\value{
If \code{densities} is \code{FALSE} (default), return a vector these named elements:
\itemize{
\item \code{meanDiff}: Mean difference between binned, standardized densities of \code{x1} and \code{x2} in environmental space.
\item \code{meanAbsDiff}: Mean absolute difference between binned, standardized densities of \code{x1} and \code{x2} (ie, \code{sum(abs(x1 - x2))}) in environmental space.
\item \code{rmsd}: Root mean squared difference.
\item \code{d}: Schoener's \emph{D}.
\item \code{i}: Warren's \emph{I}.
\item \code{esp}: Godsoe's \emph{ESP}.
\item \code{rho}: Correlation between binned, standardized densities of \code{x1} and \code{x2} in environmental space.
\item \code{rankCor}: Pearson rank correlation between binned, standardized densities of \code{x1} and \code{x2}.
}
If \code{densities} is \code{TRUE}, then return a list with a vector of metrics of niche overlap as above, plus three matrices:
\itemize{
\item \code{environDens}: Density of available environment.
\item \code{x1density}: Density of species #1 in environmental space, normalized to sum to 1 but not normalized by available environment.
\item \code{x2density}: Density of species #2 in environmental space, normalized to sum to 1 but not normalized by available environment.
}
}
\description{
This function calculates niche overlap between two species.
}
\examples{
# comparing niches between the common brown leumr (Eulemur fulvus)
# and the red-bellied lemur (Eulemur rubriventer)

data(mad0)
data(lemurs)

# climate data
bios <- c(1, 5, 12, 15)
clim <- raster::getData('worldclim', var='bio', res=10)
clim <- raster::subset(clim, bios)
clim <- raster::crop(clim, mad0)

# occurrence data
occs1 <- lemurs[lemurs$species == 'Eulemur fulvus', ]
occs2 <- lemurs[lemurs$species == 'Eulemur rubriventer', ]

ll <- c('longitude', 'latitude')
plot(mad0)
points(occs1[ , ll])
points(occs2[ , ll], col='red', pch=3)

occsEnv1 <- raster::extract(clim, occs1[ , ll])
occsEnv2 <- raster::extract(clim, occs2[ , ll])

# background sites
bg <- 2000 # too few cells to locate 10000 background points
bgSites <- dismo::randomPoints(clim, 2000)
bgEnv <- extract(clim, bgSites)

vars <- paste0('bio', bios)
nicheOverlap(occsEnv1, occsEnv2, env=bgEnv, vars=vars)

}
\references{
This function replicates the procedure presented in Broennimann, O., Fitzpatrick, M.C., Pearman, P.B., Petitpierre, B., Pellissier, L., Yoccoz, N.G., Thuiller, W., Fortin, M-J., Randin, C., Zimmermann, N.E., Graham, C.H., and Guisan, A.  2012.  Measuring ecological niche overlap from occurrence and spatial environmental data.  Global Ecology and Biogeography 21:481-497.
}
\seealso{
\code{\link{compareNiches}}
}
