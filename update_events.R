library(lubridate)
library(dplyr)

# event_database <- data.frame(date = c('12-11-2019', '18-11-2019', '25-11-2019',  '28-11-2019'),
#                              person = c('prof. Jan Mielniczuk', 'Tomasz Stanisławek', 'Barbara Rychalska', 'dr Ewa Strzałkowska-Kominiak'),
#                              title = c('Nowe problemy matematyczne w uczeniu maszynowym', 'prace z CoNLP', 'prace z ACL', 'Wybrane zagadnienia analizy przeżycia'),
#                              location = c('s.102 MiNI', 's.44 MiNI', 's.44 MiNI', 's.40 MiNI'))
# write.csv(event_database, './event_database.csv')

update_event_database <- function(event_database, date, person, title, location){
  row_to_update <- data.frame(date = date, person = person, title = title, location = location )
  updated_event_database <- rbind(event_database, row_to_update)
  
  event_database <- unique(event_database)
  return(event_database)
}


event_database <- read.csv('./event_database.csv')

## update

event_database <- event_database[,-1]


year_sel <- 2019
month_sel <- 11

event_database$date <- as.Date(event_database$date, format = '%d-%m-%Y')


  tmp1 <- event_database %>% 
    filter(year(date) == year_sel)
  

    tmp <- tmp1 %>% 
      filter( month(date) == month_sel)
    print(tmp)
    
    rmarkdown::render(input = './template_post.Rmd',
                      output_dir = './docs',
                      output_file = 'index.html',
                     params = list(data = tmp,
                                    set_title = paste0('Wydarzenia na MiNI ', year_sel, " ", month_sel),
                                    #set_slug = paste0('Post ', year_sel, " ", month_sel),
                                    set_date = Sys.Date()),
                      encoding = 'UTF-8')
    
    