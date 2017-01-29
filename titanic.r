
library("e1071")  
library(caret)

# Read CSV containing Golf Data
setwd("~/datahackathon/projects/datahackathon2")
inputfile=read.csv("titanic.csv")

inputfile
#str(inputfile)

# Basic Data Wrangling to change to 0-No Wind, 1-Wind
#inputfile$Wind <- factor(as.numeric(inputfile$Wind))

 
# Chose appropriate features to apply to ML Model
#inputfile <- subset(inputfile, select=c("Outlook", "Temperature", "Humidity", "Wind", "Play"))   
#inputfile

 
# Explore the data
#plot(Play~.,data=inputfile)

# Split Data between Training & Test Data Set
#n = nrow(inputfile)

#trainIndex = sample(1:n, size = round(0.8*n), replace=FALSE)

#train = inputfile[trainIndex ,]
#test = inputfile[-trainIndex ,]

# Build a Classifier with Training data
#nb_model <- naiveBayes(Play~., data = train)

# Examine ML Classifier Model
#nb_model

# Apply Test Data to ML Classifier Model
#test
#nb_test_predict <- predict(nb_model, test[, 1:4])
#nb_test_predict

#Confusion Matrix
#table(Predicted=nb_test_predict, Actual=test$Play )

#Confusion Matrix using caret package
#confusionMatrix(data = nb_test_predict,reference=test$Play, positive='Yes')