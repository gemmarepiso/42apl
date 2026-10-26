library(plumber)

current_slide <- 0

# Enable CORS so browser requests aren't blocked
#* @filter cors
function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  res$setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
  res$setHeader("Access-Control-Allow-Headers", "Content-Type")
  plumber::forward()
}

#* @options /slide
function() {}

#* @get /slide
#* @serializer json
function() {
  list(slide = current_slide)
}

#* @post /slide
#* @serializer json
function(req) {
  body <- jsonlite::fromJSON(req$postBody)
  current_slide <<- as.numeric(body$slide)
  list(status = "success", slide = current_slide)
}

# Run server on port 8000
pr <- plumb("server.R")
pr$run(port = 8000)