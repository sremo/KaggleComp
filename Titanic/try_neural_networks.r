# install.packages('neuralnet')
library("neuralnet")


traininginput <-  as.data.frame(runif(2000, min=0, max=200))
trainingoutput <- sqrt(traininginput)


trainingdata <- cbind(traininginput,trainingoutput)
colnames(trainingdata) <- c("Input","Output")

net.sqrt <- neuralnet(Output~Input,trainingdata, hidden=60, threshold=0.005)
print(net.sqrt)


#Plot the neural network
# plot(net.sqrt)
 
#Test the neural network on some training data
testdata <- as.data.frame((1:20)^2) #Generate some squared numbers
net.results <- compute(net.sqrt, testdata) #Run them through the neural network
 
#Lets see what properties net.sqrt has
ls(net.results)
 
#Lets see the results
print(net.results$net.result)
 
#Lets display a better version of the results
cleanoutput <- cbind(testdata,sqrt(testdata),
                         as.data.frame(net.results$net.result))
colnames(cleanoutput) <- c("Input","Expected Output","Neural Net Output")
print(cleanoutput)
