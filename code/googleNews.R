

# autoInvalidate <- reactiveTimer({
#   2000, session})

output$googleNewsTable <- DT::renderDataTable({
   google_news <- read_html("https://news.google.ca/?edchanged=1&ned=ca&authuser=0")
   
milliseconds<-input$time*60000

invalidateLater(milliseconds,session)
print("new poll")

url <-google_news %>% 
  html_nodes(".esc-lead-article-title a") %>% 
  html_attr("href") %>% 
  as.data.frame() # fewer

title <-google_news %>% 
  html_nodes(".esc-lead-article-title a span") %>% 
  html_text() %>% 
  as.data.frame()

colnames(url) <- "link"
colnames(title) <- "headline"


df <- bind_cols(title,url)

## compare with previous version # one-off write_csv(df,"googleOld.csv")
olddf <- read_csv("googleOld.csv")


top <- df %>% 
  anti_join(olddf,by=c("link"))

print(glimpse(top))


if(input$new=="All") {
final <- rbind(top,df) %>% unique(.)
} else {
  final <- top
}

write_csv(df,"googleOld.csv")

# write_csv(df,"googleLatest.csv")
# write_csv(olddf,"googlePrior.csv")
# write_csv(top,"googleDiff.csv")

final %>% 
  mutate(title=paste0("<a href=\"",link,"\" target=\"_blank\">",headline,"</a>")) %>% 
  select(title) %>% 
  DT::datatable(class='compact stripe hover row-border order-column',
                rownames= FALSE,escape=FALSE,options=list(
                  searching=FALSE,info=FALSE))
})
