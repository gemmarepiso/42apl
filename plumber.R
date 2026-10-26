library(plumber)

current_slide <- 0
server_version <- 0

# Enable CORS
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
  list(slide = current_slide, version = server_version)
}

#* @post /slide
#* @serializer json
function(req) {
  body <- jsonlite::fromJSON(req$postBody)
  current_slide <<- as.numeric(body$slide)
  server_version <<- server_version + 1
  list(status = "success", slide = current_slide, version = server_version)
}