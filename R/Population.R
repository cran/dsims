#' @include Detectability.R

#' @title Class "Population"
#'
#' @description Contains an instance of a population including a description of their detectability
#' in the form of an object of class Detectability.
#'
#' @name Population-class
#' @title S4 Class "Population"
#' @slot region.name Object of class \code{"character"}; the name of the region
#'  object.
#' @slot strata.names Object of class \code{"character"}; the names of the
#'  strata.
#' @slot N Object of class \code{"numeric"}; the number of individuals/clusters.
#' @slot D Object of class \code{"numeric"}; the density of individuals/clusters.
#' @slot population  Object of class \code{"data.frame"}; the locations of
#'  individuals/clusters and any population covariates.
#' @slot detectability  Object of class \code{"Detectability"}; describes how
#'  easily the individuals/clusters can be detected.
#' @section Methods:
#' \describe{
#'  \item{\code{plot}}{\code{signature=(object = "Line.Transect")}: plots the locations
#'  of the individuals/clusters.}
#' }
#' @keywords classes
#' @seealso \code{\link{make.population.description}}, \code{\link{make.detectability}}
setClass("Population", representation(region.name  = "character",
                                      strata.names = "character",
                                      N            = "numeric",
                                      D            = "numeric",
                                      population   = "data.frame",
                                      detectability = "Detectability"))

#' @importFrom methods validObject is
setMethod(
  f="initialize",
  signature="Population",
  definition=function(.Object, region, strata.names, N, D, population, detectability){
    #Input pre-processing
    #Set slots
    .Object@region.name   <- region
    .Object@strata.names <- strata.names
    .Object@D            <- D
    .Object@N            <- N
    .Object@population   <- population
    .Object@detectability <- detectability
    #Check object is valid
    valid <- validObject(.Object, test = TRUE)
    if(is(valid, "character")){
      stop(paste(valid), call. = FALSE)
    }
    # return object
    return(.Object)
  }
)
setValidity("Population",
  function(object){
    return(TRUE)
  }
)

# GENERIC METHODS DEFINITIONS --------------------------------------------

#' Plot
#'
#' Unused, will give a warning that the region must also be supplied.
#'
#' @param x object of class Population
#' @param y not used
#' @param ... other general plot parameters
#' @rdname plot.Population-methods
#' @importFrom graphics points
#' @exportMethod plot
setMethod(
  f="plot",
  signature="Population",
  definition=function(x, y, ...){
    warning("To plot the population please provide the Region as well as the Population.", call. = FALSE, immediate. = TRUE)
    invisible(x)
  }
)


#' Plot
#'
#' Plots an S4 object of class 'Population'. Requires that the
#' associated region has already been plotted. This function adds
#' the locations of the individuals/clusters in the population.
#'
#' @param x object of class Population
#' @param y object of class Region
#' @param ... other general plot parameters
#' @return ggplot object
#' @rdname plot.Population-methods
#' @importFrom graphics points
#' @importFrom ggplot2 ggplot geom_sf theme_set theme_bw aes
#' @importFrom sf st_as_sf
#' @exportMethod plot
setMethod(
  f="plot",
  signature=c("Population","Region"),
  definition=function(x, y, ...){
    # Get region
    sf.region <- y@region
    # Turn population into sf object
    pop.df <- x@population
    pts.sf <- sf::st_as_sf(pop.df, coords = c("x", "y"))
    sf::st_crs(pts.sf) <- sf::st_crs(sf.region)

    ggplot.obj <- ggplot() + theme_bw() +
      geom_sf(data = sf.region, color = gray(.2), lwd = 0.1, fill = "lightgrey") +
      geom_sf(data = pts.sf, mapping = aes(), colour = "red", cex = 0.5) +
      ggtitle("Population")

    return(ggplot.obj)
  }
)




