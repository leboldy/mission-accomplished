library('rvest')
library(xlsx)

url <- 'https://www.computerworld.com/article/2498543/it-management/steve-jobs-interview--one-on-one-in-1995.html'
website <- read_html(url)

#interviewer
interviewer_data_html <- html_nodes(website,'b')
interviewer_data <- html_text(interviewer_data_html)

#interviewee AQUI
interviewee_data_html <- html_nodes(website,'b+, p')

head(interviewee_data_html)


interviewee_data <- html_text(interviewee_data_html)