library(e1071)
library(randomForest)
raw_trainset <- read.csv("train.csv")


raw_trainset <- read.csv("train.csv")

attach(raw_trainset)


minimal <- data.frame(as.factor(survived), pclass, sex, age, sibsp, parch, fare, embarked)

levels(minimal$embarked)[levels(minimal$embarked) == ""] <- NA
colnames(minimal)[1] <- "survived"

detach(raw_trainset)
set.seed(111)
minimal.imputed <- rfImpute(survived ~ ., minimal)


svm.radial <- svm(survived ~ ., data=minimal.imputed,type= 'C-classification',kernel="radial", na.action = na.omit, gamma = 10000)

svm.polynomial <- svm(survived ~ ., data=minimal.imputed,type= 'C-classification',kernel="polynomial", na.action = na.omit, degree = 10)

raw_test_set <- read.csv("test.csv")
attach(raw_test_set)

test_set <- data.frame(pclass, sex, age, sibsp, parch, fare, embarked)
test_set.roughfix <- na.roughfix(test_set)


predict.svmradial <- predict(svm.radial,test_set.roughfix)
predict.svmpolynomial <- predict(svm.polynomial,test_set.roughfix)


table(pred = predict(svm.radial,minimal), true = test_set.roughfix$survived)

 table(pred = predict(svm.polynomial,minimal.imputed), true = minimal.imputed$survived)

#raw_test_set$survived <- as.integer(svmprediction) - 1
#raw_test_set$survived <- as.integer(predict.svmpolynomial) - 1
