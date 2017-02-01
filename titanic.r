
library("e1071")  
library(caret)
library(stringr)

# Read CSV containing Golf Data
setwd("~/datahackathon/projects/datahackathon2")
#
#inputfile=read.csv("titanic.csv", stringsAsFactors = FALSE)
inputfile=read.csv("titanic.csv")

inputfile
#str(inputfile)

# Basic Data Wrangling to change to 0-No Wind, 1-Wind
#inputfile$Wind <- factor(as.numeric(inpustr(inputfiletfile$Wind))
inputfile$sex <- factor(as.numeric(inputfile$sex))
inputfile$embarked <- factor(as.numeric(inputfile$embarked))
inputfile$boat <- as.factor(inputfile$boat) 


inputfile$title = as.factor(str_extract(inputfile$name, "Mr|Miss|Mr|Mrs|Mme|Col|Dr|Capt|Master|Major|Ms|Rev|Mlle|Don|Dona|Countess"))

# Chose appropriate features to apply to ML Model
#inputfile <- subset(inputfile, select=c("Outlook", "Temperature", "Humidity", "Wind", "Play"))   
#inputfile

#inputfile_subset <- subset(inputfile, select=c("pclass", "sex", "age", "sibsp", "parch", "fare", "embarked", "boat", "survived"))
#inputfile_subset <- subset(inputfile, select=c("pclass", "survived"))
columns = c("age","sex", "boat", "survived")


inputfile_subset <- subset(inputfile, select=columns)


# Explore the data
#plot(Play~.,data=inputfile)

# Split Data between Training & Test Data Set
n = nrow(inputfile_subset)

trainIndex = sample(1:n, size = round(0.95*n), replace=FALSE)

train = inputfile_subset[trainIndex ,]

testfile=read.csv("TestDataTitanic.csv")
testfile$sex <- factor(as.numeric(testfile$sex))
testfile$embarked <- factor(as.numeric(testfile$embarked))
testfile$boat <- as.factor(testfile$boat)
test <- subset(testfile, select=columns)
#test = inputfile_subset[-trainIndex ,]

# Build a Classifier with Training data

nb_model <- naiveBayes(survived~., data = train)

# Examine ML Classifier Model
#nb_model

# Apply Test Data to ML Classifier Model
#test
nb_test_predict <- predict(nb_model, test[, 1:length(columns)-1])

#nb_test_predict

#Confusion Matrix
table(Predicted=nb_test_predict, Actual=test$survived )

#Confusion Matrix using caret package
confusionMatrix(data = nb_test_predict,reference=test$survived, positive='Yes')


#a <- ggplot(data = inputfile_subset, aes(x = boat, y = survived))
#a <- a + geom_point()
#a <- a + xlab("Boat") + ylab("survived") + ggtitle("randoma")
#a

#bob <- grepl("Mr|Miss|Mr|Mrs|Mme|Col|Dr|Capt|Master|Major|Ms|Rev|Mlle|Don|Dona|Countess|Jonkheer",inputfile$name)
#left <- inputfile[!bob,]



