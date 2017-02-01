
library("e1071")  
library(caret)
library(stringr)
#treeinstall.packages("party")
library(party)

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

inputfile$title = as.factor(str_extract(inputfile$name, "Mr|Miss|Mrs|Mme|Col|Dr|Capt|Master|Major|Ms|Rev|Mlle|Don|Dona|Countess"))

# Chose appropriate features to apply to ML Model
#inputfile <- subset(inputfile, select=c("Outlook", "Temperature", "Humidity", "Wind", "Play"))   
#inputfile

#inputfile_subset <- subset(inputfile, select=c("pclass", "sex", "age", "sibsp", "parch", "fare", "embarked", "boat", "survived"))
#inputfile_subset <- subset(inputfile, select=c("pclass", "survived"))
columns = c("pclass", "title","sex", "age", "sibsp", "parch", "fare", "embarked", "boat", "survived")


inputfile_subset <- subset(inputfile, select=columns)


# Explore the data
#plot(Play~.,data=inputfile)

# Split Data between Training & Test Data Set
n = nrow(inputfile_subset)

trainIndex = sample(1:n, size = round(0.8*n), replace=FALSE)

train = inputfile_subset[trainIndex ,]
test = inputfile_subset[-trainIndex ,]

# Build a tree with Training data

tree <- ctree(survived ~ pclass + age +sex +sibsp +parch +title +fare +embarked +boat, data=train)
nb_test_predict<-predict(tree,test[, 1:length(columns)-1])

#nb_test_predict

#Confusion Matrix
table(Predicted=nb_test_predict, Actual=test$survived )

#Confusion Matrix using caret package
confusionMatrix(data = nb_test_predict,reference=test$survived, positive='Yes')

plot(tree)

