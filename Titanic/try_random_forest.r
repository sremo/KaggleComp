library(randomForest)
raw_trainset <- read.csv("train.csv")

attach(raw_trainset)


minimal <- data.frame(as.factor(survived), pclass, sex, age, sibsp, parch, fare, embarked)

levels(minimal$embarked)[levels(minimal$embarked) == ""] <- NA
colnames(minimal)[1] <- "survived"

detach(raw_trainset)
set.seed(111)
minimal.imputed <- rfImpute(survived ~ ., minimal)

set.seed(222)

minimal.rf <- randomForest(survived ~ ., minimal.imputed)

print(minimal.rf)

raw_test_set <- read.csv("test.csv")
attach(raw_test_set)

test_set <- data.frame(pclass, sex, age, sibsp, parch, fare, embarked)
test_set.roughfix <- na.roughfix(test_set)

mypredict <- predict(minimal.rf, test_set.roughfix)

raw_test_set$survived <- as.integer(mypredict) - 1
