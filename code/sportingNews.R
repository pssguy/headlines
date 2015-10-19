

# autoInvalidate <- reactiveTimer({
#   2000, session})

output$sportingNewsTable <- DT::renderDataTable({
  sporting_news <- read_html("http://www.sportingnews.com/")
  
  url <-sporting_news %>% 
    html_nodes(".fa-stack-1x , .media-heading a") %>% 
    html_attr("href") %>% 
    as.data.frame() # inc nas
  
  colnames(url) <- "link"
  
  url <- as.data.frame(url[!is.na(url$link),])  
  colnames(url) <- "link"
  
  title <-sporting_news %>% 
    html_nodes(".fa-stack-1x , .media-heading a") %>% 
    html_text() %>% 
    as.data.frame()
  
  colnames(title) <- "headline"
  
  title <- as.data.frame(title[title$headline!="",])  
  colnames(title) <- "headline"
  

df <- bind_cols(title,url)

## compare with previous version # one-off write_csv(df,"sportingOld.csv")
olddf <- read_csv("sportingOld.csv")


top <- df %>% 
  anti_join(olddf,by=c("link"))

print(glimpse(top))


if(input$new=="All") {
final <- rbind(top,df) %>% unique(.)
} else {
  final <- top
}

write_csv(df,"sportingOld.csv")

print(glimpse(final))

final %>% 
  mutate(title=paste0("<a href=\"",link,"\" target=\"_blank\">",headline,"</a>")) %>% 
  select(title) %>% 
  DT::datatable(class='compact stripe hover row-border order-column',
                rownames= FALSE,escape=FALSE,options=list(
                  searching=FALSE,info=FALSE))
})
