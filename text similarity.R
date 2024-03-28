# Text Similarity by different methods

library(keras)
library(tensorflow)
library(dplyr)
library(e1071)
movie = dataset_imdb()

xtrain = movie$train$x 
ytrain = movie$train$y 
str(xtrain)
str(ytrain)

#making all text length to equal length by using pad_sequence
xtrain = pad_sequences(xtrain, maxlen = 1000) 
xtrain_new = xtrain[10001:11000,]
str(xtrain_new)

library(philentropy)
euc = distance(xtrain_new, method = 'euclidean')
eucdf = data.frame(euc)
dim(eucdf)
eucdata = eucdf$v320 
eucdata
sorteucdata = sort(eucdata)
sorteucdata
result = sorteucdata[1:10] 
result
map_result = match(result, eucdata)
map_result
euccluster=kmeans(xtrain,centers = 10) 
euccluster
