library(tidyverse)
library(caret)
library(mlbench)
library(glmnet)
library(glmnetUtils)

spam <- as.tibble(read_csv("C:/Users/taoya/Desktop/MSCS6520/Homework/homework7/spam_data.csv")) 
spam<- mutate(spam, label = as.factor(label))
              
              
              
set.seed(121)
trainIndex <-
  createDataPartition(spam$label,
                      p = 0.8,
                      list = FALSE,
                      times = 1)
spamTrain <- spam[trainIndex, ]
spamTest <- spam[-trainIndex, ]



lr_spam<-glmnet(label ~ .,
                  data = spamTrain,
                  family = "binomial",
                  na.action = na.omit)

Predictions <- predict(lr_spam,
                              spamTest,
                              type = "class",
                              na.action = na.pass,
                              s = 0.01)
confusionMatrix(Predictions,spamTest$label)