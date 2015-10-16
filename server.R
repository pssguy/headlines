


shinyServer(function(input, output,session) {

  autoInvalidate <- reactiveTimer(2000, session)
  
  
  
  source("code/guardian.R", local = TRUE)
  
 
  
})