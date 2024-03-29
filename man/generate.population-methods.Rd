% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generic.functions.R,
%   R/Population.Description.R, R/Simulation.R
\name{generate.population}
\alias{generate.population}
\alias{generate.population,Population.Description-method}
\alias{generate.population,Simulation-method}
\title{S4 generic method to generate an instance of a population}
\usage{
generate.population(object, ...)

\S4method{generate.population}{Population.Description}(object, detectability = NULL, region = NULL)

\S4method{generate.population}{Simulation}(object, ...)
}
\arguments{
\item{object}{an object of class Simulation or Population.Description}

\item{...}{when this is called on an object of class Population.Description
the additional arguments detectability and region.obj should also be supplied}

\item{detectability}{object of class Detectability (optional - only
required if object is of class Population.Description)}

\item{region}{the region object for the population (optional - only
required if object is of class Population.Description)}
}
\value{
\code{\link{Population-class}} object
}
\description{
Uses the population description and detectability details to generate an
instance of the population. Note that if the first argument supplied is
of class Population.Description rather than class Simulation then
detectability and region must also be supplied.
}
