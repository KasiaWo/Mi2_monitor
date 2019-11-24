library(lubridate)
library(dplyr)

event_database <- data.frame(date = c('12-11-2019', '18-11-2019', '20-12-2019', '10-01-2020'),
                             person = c('prof. Jan Mielniczuk', 'Tomasz Stanisławek', 'Tomasz Stanisławek', 'Tomasz Stanisławek'),
                             title = c('Nowe problemy matematyczne w uczeniu maszynowym', 'prace z CoNLP', 'temat nowy', 'temat nowszy'),
                             location = c('s.102 MiNI', 's.44 MiNI', 's.44 MiNI', 's.44 MiNI'))


event_database$date <- as.Date(event_database$date, format = '%d-%m-%Y')

for(year_sel in unique(year(event_database$date))){
  tmp1 <- event_database %>% 
    filter(year(date) == year_sel)
  
  for(month_sel in sort(unique(month(tmp1$date)))){
    tmp <- tmp1 %>% 
      filter( month(date) == month_sel)
    print(tmp)
    
    rmarkdown::render(input = './template_post.Rmd',
                      output_dir = './docs',
                      output_file = paste0('events_', year_sel, '_', month_sel, '.html'),
                      #output_file = path.expand(paste0(getwd(),'/content/post/events_', year_sel, '_', month_sel, '.html')),
                      params = list(data = tmp,
                                    set_title = paste0('Wydarzenia na MiNI ', year_sel, " ", month_sel),
                                    #set_slug = paste0('Post ', year_sel, " ", month_sel),
                                    set_date = Sys.Date()),
                      encoding = 'UTF-8')
    
    # slug <- paste0('Post ', year_sel, " ", month_sel)
    # date <- Sys.Date()
    # data <- tmp
    # title <- paste0('Wydarzenia na MiNI ', year_sel, " ", month_sel)
    # 
    # #file.remove(paste0('./content/post/events_', year_sel, '_', month_sel, '.html'))
    # 
    # knitr::knit(input = './R/post_template_2.Rmd',
    #             output = paste0('./content/post/events_', year_sel, '_', month_sel, '_2.md'))
  }
}
