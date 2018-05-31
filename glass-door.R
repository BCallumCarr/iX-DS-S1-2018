library(rvest)
library(tidyr)
library(tibble)
library(dplyr)

salaries_1 <- read_html("https://www.glassdoor.com/Salaries/data-scientist-salary-SRCH_KO0,14.htm") %>% # read html file in 
  # SelectorGadget/Chrome inspect needed in the following step, as well as some trial and error
  html_nodes(xpath = '//*[@id="SalariesByCompany"]/div[1]/div[2]/div[2]') %>% 
  html_text() %>% 
  strsplit("Data Scientist")

salaries_1 <- salaries_1[[1]]

salaries_1 <- as.tibble(sub("/.*", "", salaries_1))[-1,]%>% 
  separate(value, into = c("company", "salary"), sep = "[$]")

salaries_1$salary <- as.numeric(gsub(",", "", salaries_1$salary));

salaries_1

# Now do it for the next page of results! Then you can append the two data frames :)

salaries_2 <- read_html("https://www.glassdoor.com/Salaries/data-scientist-salary-SRCH_KO0,14_IP2.htm") %>% 
  html_nodes(xpath = '//*[@id="SalariesByCompany"]/div[1]/div[2]/div[2]') %>% 
  html_text() %>% 
  strsplit("Data Scientist")

salaries_2 <- salaries_2[[1]]

salaries_2 <- as.tibble(sub("/.*", "", salaries_2))[-1,] %>% 
  separate(value, into = c("company", "salary"), sep = "[$]")

salaries_2$salary <- as.numeric(gsub(",", "", salaries_2$salary));

salaries_2

