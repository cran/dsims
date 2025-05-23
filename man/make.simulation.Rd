% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ClassConstructors.R
\name{make.simulation}
\alias{make.simulation}
\title{Creates a Simulation object}
\usage{
make.simulation(
  reps = 10,
  design = make.design(),
  population.description = make.population.description(),
  detectability = make.detectability(),
  ds.analysis = make.ds.analysis()
)
}
\arguments{
\item{reps}{number of times the simulation should be repeated}

\item{design}{an object of class Survey.Design created by a call to
\link[dssd]{make.design}}

\item{population.description}{an object of class Population.Description
created by a call to \link{make.population.description}}

\item{detectability}{and object of class Detectability created by a call to
\link{make.detectability}}

\item{ds.analysis}{an objects of class DS.Analysis created by
a call to \link{make.ds.analysis}}
}
\value{
\code{\link{Simulation-class}} object
}
\description{
This creates a simulation with all the information necessary for dsims
to generate a population, create transects, simulate the survey process
and fit detection functions and estimate density / abundance. This function can be
used by itself based on default values to create a simple line transect example, see
Examples below. To create more complex simulations it is advisable to define the
different parts of the simulation individually before grouping them together. See
the Arguments for links to the functions which make the definitions for the
individual simulation components. For a more in depth example please refer to the
'GettingStarted' vignette.
}
\details{
The \code{make.simulation} function is now set up so that by
 default (with the exception of specifying point transects rather than
  line) it can run a simple simulation example. See examples.
}
\examples{
# Create a basic rectangular study area
region <- make.region()

# Make a density grid (large spacing for speed)
density <- make.density(region = region,
                        x.space = 300,
                        y.space = 100,
                        constant = 1)
density <- add.hotspot(density, centre = c(1000, 100), sigma = 250, amplitude = 10)

# Define the population description
popdsc <- make.population.description(region = region,
                                      density = density,
                                      N = 200)

# Define the detecability
detect <- make.detectability(key.function = "hn",
                             scale.param = 25,
                             truncation = 50)

# Define the design
design <- make.design(region = region,
                      transect.type = "line",
                      design = "systematic",
                      samplers = 20,
                      design.angle = 0,
                      truncation = 50)

# Define the analyses
ds.analyses <- make.ds.analysis(dfmodel = ~1,
                                key = "hn",
                                truncation = 50,
                                criteria = "AIC")

# Put all the components together in the simulation (note no. of replicates
# reps = 1 is only for a single test run and should be 999 or more to be able
# to draw inference.)
simulation <- make.simulation(reps = 1,
                              design = design,
                              population.description = popdsc,
                              detectability = detect,
                              ds.analysis = ds.analyses)

# run an example survey to check the setup
survey <- run.survey(simulation)
plot(survey, region)

# Run the simulation
# Warning: if you have increased the number of replications then it can take a
# long time to run!
simulation <- run.simulation(simulation)
summary(simulation)

# For a more in depth example please look at
vignette("GettingStarted", 'dsims')

}
\seealso{
\code{\link[dssd]{make.region}} \code{\link{make.density}} \code{\link{make.population.description}} \code{\link{make.detectability}} \code{\link{make.ds.analysis}} \code{\link[dssd]{make.design}}
}
\author{
Laura Marshall
}
