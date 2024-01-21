library(tidyverse)
library(caret)
library(mlbench)
library(MLmetrics)

df <- read_csv("churn.csv")
head(df)

## review train
churn_df <- df %>%
  select(5,6,7,churn)

## 1. split data
train_test_split <- function(data,size=0.8){
  set.seed(42)
  n <- nrow(data)
  train_id <-sample(1:n,size*n)
  train_df <- data[train_id,]
  test_df <- data[-train_id,]
  return(list(train_df,test_df))
}
prep_df <- train_test_split(churn_df,size=0.8)
prep_df[[1]]

## 2. train model
# knn
k_grid <- data.frame(k=c(3,5,9,11,13))
ctrl <- trainControl(method="cv",
                     number =25)

knn_model <- train(churn ~ . ,
                   data=prep_df[[1]],
                   method="knn",
                   trControl=ctrl,
                   tuneGrid = k_grid)

##user for Recall, Precision, F1, AUC
ctrl1 <- trainControl(method="cv",
                     number=5,
                     ## pr= precision + recall
                     summaryFunction = prSummary,
                     classProbs=TRUE)

logis_model <- train(churn ~ . ,
                     data=prep_df[[1]],
                     method="knn",
                     metric = "Recall",
                     trControl = ctrl1)

## 3. score model
p <- predict(knn_model,newdata=prep_df[[2]])

## 4. evaluate model
actual_churn <- prep_df[[2]]$churn

acc <- mean(pred_churn == actual_churn)

confusionMatrix(p, 
                as.factor(prep_df[[2]]$churn),
                positive = "Yes",
                mode="prec_recall")

