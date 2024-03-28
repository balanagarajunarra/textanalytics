# Data Cleaning
library(tm)
library(wordcloud)
library(SnowballC)
library(RColorBrewer)

mydata=readLines("C:/Users/balun/OneDrive/Desktop/class notes/TIDA/apple.txt")
mydata
#Data Cleaning
finaldata=Corpus(VectorSource(mydata))
finaldata=tm_map(finaldata,content_transformer(tolower))
finaldata
finaldata=tm_map(finaldata,removeWords,stopwords("english"))
finaldata=tm_map(finaldata,removePunctuation)
finaldata=tm_map(finaldata,removeNumbers)
finaldata=tm_map(finaldata,stripWhitespace)
#Defining stopwords
userstopwords=c("Apple", "MacBook","apple","macbook")
finaldata=tm_map(finaldata,removeWords,userstopwords)
myfunc1=function(data, pattern) gsub(pattern, "", data)
finaldata=tm_map(finaldata,content_transformer(myfunc1), "@")
finaldata=tm_map(finaldata,content_transformer(myfunc1), "/")
finaldata=tm_map(finaldata,content_transformer(myfunc1), "&")

finaldata=tm_map(finaldata, stemDocument)
summary(finaldata)
#Documentterm matrix
dfinaldata=DocumentTermMatrix(finaldata)
nDocs(dfinaldata)
nTerms(dfinaldata)
Terms(dfinaldata)
inspect(dfinaldata)

#TermDocument matrix
dfinaldata=TermDocumentMatrix(finaldata)
inspect(dfinaldata)

original=Corpus(VectorSource(finaldata))
new=TermDocumentMatrix(original)
matrix=as.matrix(new)
tdmdata=TermDocumentMatrix(finaldata)
matrixnew=as.matrix(tdmdata)
ans=rowSums(matrixnew)
sorted=sort(ans,decreasing = TRUE)
tmnames=names(sorted)
mydf=data.frame(word=tmnames,freq=sorted)
mydf
#WordCloud
wordcloud(mydf$word,mydf$freq,min.freq = 2,max.words = 10,colors = brewer.pal(8,"RdGy"))
inspect(removeSparseTerms(dfinaldata,0.7))

# To display all those terms whose frequency is minimum 2
findFreqTerms(dfinaldata,2)
# The minimum correlation of 0.1 with the "paragraph" word
findAssocs(dfinaldata,"paragraph",0.1)
