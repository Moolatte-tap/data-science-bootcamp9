library(tidyverse)
library(caret)

## HOMEWORK
## Build churn prediction model
## method ="glm"
## 3-5 independent variables(feature)

df <- read_csv("churn.csv")
head(df)

## 1. split data
train_test_split <- function(data,size=0.8){
  set.seed(42)
  n <- nrow(data)
  train_id <-sample(1:n,size*n)
  train_df <- data[train_id,]
  test_df <- data[-train_id,]
  return(list(train_df,test_df))
}
prep_df <- train_test_split(df,size=0.8)
prep_df[[1]]

## 2. train model
ctrl <- trainControl(method="cv",
                     number =25)

model <- train(churn ~ totaldayminutes + totaldaycalls
               + totaldaycharge + totaleveminutes
               + totalevecalls,
               data=prep_df[[1]],
               method="glm",
               trControl=ctrl)

## 3. score model
pred_churn <- predict(model, newdata=prep_df[[2]])

## 4. evaluate model
actual_churn <- prep_df[[2]]$churn

acc <- mean(abs(pred_churn == actual_churn))
print(acc)
