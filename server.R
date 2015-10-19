


shinyServer(function(input, output,session) {
  
  
#   timeData <- reactive({
#   milliseconds <- input$time*6000
# 
#   autoInvalidate <- reactiveTimer(milliseconds, session)
#   
#   })
#   
  
  source("code/guardian.R", local = TRUE)
  source("code/mailSport.R", local = TRUE)
  source("code/googleNews.R", local = TRUE)
  
  
 
  
})