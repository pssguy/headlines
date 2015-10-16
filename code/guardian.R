

# autoInvalidate <- reactiveTimer({
#   2000, session})

output$guardianTable <- DT::renderDataTable({
  
  
  
  
guardian_front <-read_html("http://www.theguardian.com/international")

milliseconds<-input$time*60000

invalidateLater(milliseconds,session)
print("new poll")

head_1 <-
  guardian_front %>% 
  html_nodes("#headlines .js-headline-text") %>% 
  html_text() %>% 
  as.data.frame()

head_2 <-
  guardian_front %>% 
  html_nodes("#highlights .js-headline-text") %>% 
  html_text()%>% 
  as.data.frame()
head_3 <-
  guardian_front %>% 
  html_nodes("#sport .js-headline-text") %>% 
  html_text()%>% 
  as.data.frame()
head_4 <-
  guardian_front %>% 
  html_nodes("#opinion .js-headline-text") %>% 
  html_text()%>% 
  as.data.frame()
head_5 <-
  guardian_front %>% 
  html_nodes("#around-the-world .js-headline-text") %>% 
  html_text()%>% 
  as.data.frame()
head_6 <-
  guardian_front %>% 
  html_nodes("#in-depth .js-headline-text") %>% 
  html_text()%>% 
  as.data.frame()

a <- bind_rows(head_1,head_2,head_3,head_4,head_5,head_6) %>% 
  unique()
nrow(a) #42
colnames(a) <- "headline"




link_1 <-
  guardian_front %>% 
  html_nodes("#headlines .js-headline-text") %>% 
  html_attr("href") %>% 
  as.data.frame()
link_2 <-
  guardian_front %>% 
  html_nodes("#highlights .js-headline-text") %>% 
  html_attr("href") %>% 
  as.data.frame()
link_3 <-
  guardian_front %>% 
  html_nodes("#sport .js-headline-text") %>% 
  html_attr("href") %>% 
  as.data.frame()
link_4 <-
  guardian_front %>% 
  html_nodes("#opinion .js-headline-text") %>% 
  html_attr("href") %>% 
  as.data.frame()
link_5 <-
  guardian_front %>% 
  html_nodes("#around-the-world .js-headline-text") %>% 
  html_attr("href") %>% 
  as.data.frame()
link_6 <-
  guardian_front %>% 
  html_nodes("#in-depth .js-headline-text") %>% 
  html_attr("href") %>% 
  as.data.frame()

b<- bind_rows(link_1,link_2,link_3,link_4,link_5,link_6)
colnames(b) <- "link"
b <- b %>% 
  filter(!is.na(link))

df <- bind_cols(a,b)

## compare with previous version
olddf <- read_csv("guardianOld.csv")
print(glimpse(olddf))

top <- df %>% 
  anti_join(olddf) 

final <- rbind(top,df) %>% unique(.)

write_csv(df,"guardianOld.csv")

final %>% 
  mutate(title=paste0("<a href=\"",link,"\" target=\"_blank\">",headline,"</a>")) %>% 
  select(title) %>% 
  DT::datatable(class='compact stripe hover row-border order-column',
                rownames= FALSE,escape=FALSE,options=list(
                  searching=FALSE,info=FALSE))
})
