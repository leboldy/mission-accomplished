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