library('rvest')
library('stringr')
library('purrr')
library('xml2')
library('ngram')
library('tidyverse')
library('tidytext')
library('dplyr')
library("NLP")
library("tm")
library("RColorBrewer") 
library("SnowballC")
library("wordcloud")
library('bitops')
library('RCurl')
library('XML')
     
##URL
url <- 'https://www.computerworld.com/article/2498543/it-management/steve-jobs-interview--one-on-one-in-1995.html'
website <- read_html(url)

#interviewer
interviewer_data_html <- html_nodes(website,'b')
interviewer_data <- html_text(interviewer_data_html)

#interviewee
interviewee_data_html <- html_nodes(website, xpath="//p")  

#removing not relevant data "manually"
interviewee_data_html[1:7] = NULL 
interviewee_data_html[14] = NULL 

#compiling interviewee answers paragraph vet5 in a stupid/manual way
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

#compiling interviewee answers paragraph vet10 in a stupid/manual way
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

#print(interviewee_data)
#print(interviewee_data_html)
#print(interviewee_data_html[5])

#Generating csv file
interview_df<-data.frame(Interviewer= interviewer_data, Interviewee= interviewee_data)
str(interview_df)
write.csv(interview_df, file = "interview3.csv")

###########################################
#i.	Using this text data set, find online free libraries and code to:
#ii.	Create some n-grams of the data
###########################################

print(interviewee_data)
summary(interviewee_data)
ng <- ngram(interviewee_data, n=1)
ng <- ngram(interviewee_data)
print (ng, output="full") #output="truncate" or "full"

print(interviewer_data)
summary(interviewer_data)
ng <- ngram(interviewer_data, n=1)
ng <- ngram(interviewer_data)
print (ng, output="full")

###########################################
#iii.	Run a simple off the shelf sentiment analysis
# sentiment from interviewee
###########################################

interviewee_data_df <- data_frame(text =interviewee_data) %>% unnest_tokens(word, text)

#list of words w/ score
interviewee_data_df %>% 
  inner_join(get_sentiments("afinn")) #afinn: assigns words with a score (between -5 and 5) with negative scores indicating negative sentiment

#list of words w/ sentiment
interviewee_data_df %>% 
  inner_join(get_sentiments("bing")) #bing: categorizes words into positive and negative categories

#list of words w/ sentiment and type of sentiment
interviewee_data_df %>%
  inner_join(get_sentiments("nrc")) #nrc: categorizes words into positive and negative categories, as well as by type of sentiment like anger, fear, joy, etc

#total of words group by sentiment
interviewee_data_df %>% 
  inner_join(get_sentiments("bing")) %>%
  count(sentiment) #count sentiment - positive & negative words

#total of words group by sentiment and type of sentiment
interviewee_data_df %>%
  inner_join(get_sentiments("nrc")) %>%
  count(sentiment) 

###########################################
#iii.	Run a simple off the shelf sentiment analysis
# sentiment from interviewer
###########################################

interviewer_data_df <- data_frame(text =interviewer_data) %>% unnest_tokens(word, text)

#list of words w/ score
interviewer_data_df %>% 
  inner_join(get_sentiments("afinn")) 

#list of words w/ sentiment
interviewer_data_df %>% 
  inner_join(get_sentiments("bing")) 

#list of words w/ sentiment and type of sentiment
interviewer_data_df %>%
  inner_join(get_sentiments("nrc")) 

#total of words group by sentiment
interviewer_data_df %>% 
  inner_join(get_sentiments("bing")) %>%
  count(sentiment) 

#total of words group by sentiment and type of sentiment
interviewer_data_df %>%
  inner_join(get_sentiments("nrc")) %>%
  count(sentiment) 

###########################################
#iv.	Create some word clouds
###########################################

#word cloud from interviewer
wordcloud(interviewer_data, min.freq= 1,  max.words= 80, rot.per=0.35, colors=brewer.pal(8, "Dark2"))

#word cloud from interviewee
wordcloud(interviewee_data, min.freq= 2,  max.words= 120, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
