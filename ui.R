



dashboardPage(title = "Headlines",
  skin = "blue",
  dashboardHeader(title = "Headlines"),
  
  dashboardSidebar(
  
    
    
    
    
    
    sidebarMenu(
      id = "sbMenu",
      
      menuItem(
        "Guardian",tabName= "guardian"
     
      ),
      
      
      menuItem(
        "Other Dashboards",
        
        
        menuSubItem("Climate",href = "https://mytinyshinys.shinyapps.io/climate"),
        menuSubItem("Cricket",href = "https://mytinyshinys.shinyapps.io/cricket"),
        menuSubItem("Mainly Maps",href = "https://mytinyshinys.shinyapps.io/mainlyMaps"),
        menuSubItem("MLB",href = "https://mytinyshinys.shinyapps.io/mlbCharts"),
        
        menuSubItem("World Soccer",href = "https://mytinyshinys.shinyapps.io/worldSoccer")
        
      ),
      menuItem("", icon = icon("twitter-square"),
               href = "https://twitter.com/pssGuy"),
      menuItem("", icon = icon("envelope"),
               href = "mailto:agcur@rogers.com")
      
    
  )),
  dashboardBody(tabItems(
    tabItem("guardian",
           
                box(
                  width = 4, collapsible = TRUE,collapsed=TRUE,
                  status = "success", solidHeader = TRUE,
                  title = "Guardian",
                  DT::dataTableOutput("guardianTable")
                )
    )
    
    
    
  ) # tabItems
  ) # body
  ) # page
  