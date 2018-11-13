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
library('officer')
library('uuid')
library('magrittr')

## Read to a CSV file
interview <- read.csv("Assets/Book1-S4T2.csv", colClasses = "character")
#print(interview)

interview.translation <- (interview['TRANSLATION'])
interview.translation.txt <- unlist(interview.translation)
interview.time <- (interview['TIME.CODE'])
interview.time.txt <- unlist(interview.time)

#define criteria for searching
key.word <- "I recommend Sensodyne"

#search by key word and return the time where that was cited 
interview.time.txt[unlist(lapply(interview.translation,function(x) grep(key.word,x)))]

#typeof(interview)
#typeof(interview.time2)

#summary(interview.translation)


#Generating df
real.interview.df<-data.frame(TimeCode= interview.time, Translation= interview.translation)
str(real.interview.df)
print(real.interview.df)

###########################################
#ii.	Create some n-grams of the data
###########################################

ng <- ngram(interview.translation.txt, n=1)
print (ng, output="full") #output="truncate" or "full"


###########################################
#iii.	Run a simple off the shelf sentiment analysis
###########################################
real.interview.trans.df <- data_frame(text =interview.translation.txt) %>% unnest_tokens(word, text)

#list of words w/ score
real.interview.trans.df %>% 
  inner_join(get_sentiments("afinn")) #afinn: assigns words with a score (between -5 and 5) with negative scores indicating negative sentiment

#list of words w/ sentiment
real.interview.trans.df %>% 
  inner_join(get_sentiments("bing")) #bing: categorizes words into positive and negative categories

#list of words w/ sentiment and type of sentiment
real.interview.trans.df %>%
  inner_join(get_sentiments("nrc")) #nrc: categorizes words into positive and negative categories, as well as by type of sentiment like anger, fear, joy, etc

#total of words group by sentiment
real.interview.trans.df %>% 
  inner_join(get_sentiments("bing")) %>%
  count(sentiment) #count sentiment - positive & negative words

#total of words group by sentiment and type of sentiment
real.interview.trans.df %>%
  inner_join(get_sentiments("nrc")) %>%
  count(sentiment) 

###########################################
#iv.	Create some word clouds
###########################################

wordcloud(interview.translation.txt, min.freq= 1,  max.words= 80, rot.per=0.35, colors=brewer.pal(8, "Dark2"))


## Test
# interview.time <- c("00:00-00:10", "00:11-00:17", "00:30-00:36", "02:18-02:21")
# interview.scrape <- c(
#   "I recommend Sensodyne onarőm ve koruma with the improved formula, because it creates a much harder and more thick protective layer on the teeth.",
#   "How could you say it?  It repairs more strongly since it creates a more thick layer.  ThatŐs why..",
#   "Uh, It repairs strongly.",
#   "Okay.  (É) Sensodyne onarőm ve koruma toothpaste with its improved formula provides a more strong repair by insulating the pores causing the sensitivity with a much harder and more thick layer."
# )
# str(interview.time)
# print(interview.time)
# print(interview.scrape)
# 
# grep("Sensodyne", interview.scrape)
# 
# interview.time [(grep("Sensodyne onarőm ve koruma toothpaste", interview.scrape))]