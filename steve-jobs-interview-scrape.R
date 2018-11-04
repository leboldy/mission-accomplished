library('rvest')
library('stringr')
library('purrr')
library('xml2')

url <- 'https://www.computerworld.com/article/2498543/it-management/steve-jobs-interview--one-on-one-in-1995.html'
website <- read_html(url)

#interviewer
interviewer_data_html <- html_nodes(website,'b')
interviewer_data <- html_text(interviewer_data_html)

#interviewee
interviewee_data_html <- html_nodes(website, xpath="//p")  

#removing not relevant data
interviewee_data_html[1:7] = NULL 
interviewee_data_html[14] = NULL 

#compiling interviewee answers paragraph vet5 in a stupid way
vet5<-str_replace_all(interviewee_data_html[[5]],"</p>","")
vet6<-str_replace_all(interviewee_data_html[[6]],"<p>","")
vet6<-str_replace_all(vet6,"</p>","")
vet7<-str_replace_all(interviewee_data_html[[7]],"<p>","")
vet7<-str_replace_all(vet7,"</p>","")
vet5<-paste(vet5, vet6, vet7, str_replace_all(interviewee_data_html[[8]],"<p>",""))
vet5<-str_replace(vet5,"\n ", "")
#print(vet5)
interviewee_data_html[[5]]<-read_xml(vet5)
#print(interviewee_data_html[5])
#print(interviewee_data_html[6])

#compiling interviewee answers paragraph vet10 in a stupid way
vet10<-str_replace_all(interviewee_data_html[[10]],"</p>","")
vet11<-str_replace_all(interviewee_data_html[[11]],"<p>","")
vet11<-str_replace_all(vet11,"</p>","")
vet12<-str_replace_all(interviewee_data_html[[12]],"<p>","")
vet12<-str_replace_all(vet12,"</p>","")
vet10<-paste(vet10, vet11, vet12, str_replace_all(interviewee_data_html[[13]],"<p>",""))
vet10<-str_replace(vet10,"\n ", "")
#print(vet10)
interviewee_data_html[[10]]<-read_xml(vet10)

#removing compiled answers
interviewee_data_html[6:8] = NULL 
interviewee_data_html[8:10] = NULL 

#removing extra tags and converting to text
interviewee_data<-interviewee_data_html %>%
 map_chr(~paste0(html_text(html_nodes(., xpath="./text()"), trim=TRUE), collapse=" "))

print(interviewee_data)
#print(interviewee_data_html)
#print(interviewee_data_html[5])

#Generating csv file
interview_df<-data.frame(Interviewer= interviewer_data, Interviewee= interviewee_data)
str(interview_df)
write.csv(interview_df, file = "interview3.csv")


# ##########################################
# #interviewee 
# interviewee_data_html <- html_nodes(website, 'div#drr-container p')
# interviewee_data_html <- html_nodes(website, xpath="//p")
# 
# div#drr-container
# interviewee_data_html[1] = NULL  
# interviewee_data_html[1] = NULL  
# print(interviewee_data_html)
# interviewee_data_html<- html_children(interviewee_data_html)
# 
# 
# interviewee_data_html<-str_replace_all(interviewee_data_html,"<b>","")
# 
# 
# aux<- substr(interviewee_data_html[1], start= 95, stop= 2210)
# aux<- paste("<p>",aux)
# interviewee_data_html[1]<- aux
# print(aux)
# print(lengths(interviewee_data_html))
# 
# print(str_count(test))
# print(test)
# 
# #OK - works interviewee_data_html<-str_split(interviewee_data_html, "</b>")
# 
# 
##compiling interviwee answers
#interviewee_data[5]<- paste(interviewee_data[5], interviewee_data[6], interviewee_data[7], interviewee_data[8])
#interviewee_data[10]<- paste(interviewee_data[10], interviewee_data[11], interviewee_data[12], interviewee_data[13])

# 
# test<-html_structure(interviewee_data_html)
# 
# 
# paste(interviewee_data_html[1],"test")
# print(interviewee_data_html[1])
# 
# print(interviewee_data[1])
# 
# pos = grep('<b>', interviewee_data_html)
# print(pos)
# 
# i <-1;
# while (i < length(interviewee_data_html)){
#   print(interviewee_data_html[i])
#   #if (interviewee_data_html[i])
#   i = i+1
# }
# 
# head(interviewee_data_html)
# 
# 
# for (i in c(15,52,65,70)){
#   a<-metascore_data[1:(i-1)]
#   b<-metascore_data[i:length(metascore_data)]
#   metascore_data<-append(a,list("NA"))
#   metascore_data<-append(metascore_data,b)
# }
# 
# interviewee_data <- html_text(interviewee_data_html)
# 
# 
# #Generating file
# interview_df<-data.frame(Interviewee = interviewee_data)
# str(interview_df)
# write.csv(interview_df, file = "interview2.csv")
# 
# interviewee_data_html[8] = NULL
# head(interviewee_data_html)
# length(interviewee_data_html)
# 
# interviewee_data <- html_text(interviewee_data_html)
# 
# length(interviewee_data)
# length(interviewer_data)
# 
# #Generating file
# interview_df<-data.frame(Interviewee = interviewee_data, Interviewer = interviewer_data)
# str(interview_df)
# write.csv(interview_df, file = "interview.csv")
