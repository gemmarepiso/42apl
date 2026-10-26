library(plumber)

# Load plumber.R and run on port 8000
pr <- plumb("plumber.R")
pr$run(port = 8000)