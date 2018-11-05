library('rvest')

url <- 'http://www.u.arizona.edu/~kimmehea/purdue/421/exampleinterview.htm'
website <- read_html(url)

#interviewer
interviewer_data_html <- html_nodes(website,'p')
interviewer_data <- html_text(interviewer_data_html)
head(interviewer_data)

#interviewee AQUI
interviewee_data_html <- html_nodes(website, 'div#drr-container > p :not(i)')
head(interviewee_data_html)

interviewee_data_html[1] = NULL

head(interviewer_data_html)



interviewee_data <- html_text(interviewee_data_html)