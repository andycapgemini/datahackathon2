
library("e1071")  
library(caret)
library(stringr)

# Read CSV containing Golf Data
setwd("~/datahackathon/projects/datahackathon2")
#
#inputfile=read.csv("titanic.csv", stringsAsFactors = FALSE)
inputfile=read.csv("df_short.csv")

#a <- ggplot(data = inputfile, aes(x = DepDelay, y = Month))
#a <- a + geom_point()
#a <- a + xlab("delay") + ylab("month") + ggtitle("randoma")
#a

#data examinationinput

#columns = c("Year","Month","DayofMonth","DayOfWeek","DepTime","CRSDepTime","ArrTime","CRSArrTime","UniqueCarrier","FlightNum","TailNum","ActualElapsedTime","CRSElapsedTime","AirTime","ArrDelay","DepDelay","Origin","Dest","Distance","TaxiIn","TaxiOut","CancellationCode","Diverted","CarrierDelay","WeatherDelay","NASDelay","SecurityDelay","LateAircraftDelay","Cancelled")

inputfile$Cancelled <- as.factor(inputfile$Cancelled)
inputfile$Month <- as.factor(inputfile$Month)
inputfile$DayofMonth <- as.factor(inputfile$DayofMonth)
inputfile$DayOfWeek <- as.factor(inputfile$DayOfWeek)


columns = c("Month","DayofMonth","DayOfWeek","UniqueCarrier","Cancelled")


inputfile_subset <- subset(inputfile, select=columns)


# Explore the data
#plot(Play~.,data=inputfile)

# Split Data between Training & Test Data Set
n = nrow(inputfile_subset)

trainIndex = sample(1:n, size = round(0.8*n), replace=FALSE)

train = inputfile_subset[trainIndex ,]
test = inputfile_subset[-trainIndex ,]

# Build a Classifier with Training data

tree <- ctree(Cancelled ~ Month +DayofMonth +DayOfWeek +UniqueCarrier, data=train)
nb_test_predict <- predict(tree, test[, 1:length(columns)-1])
plot(tree)

#nb_model <- naiveBayes(Cancelled~., data = train)
#nb_test_predict <- predict(nb_model, test[, 1:length(columns)-1])

#nb_test_predict

#Confusion Matrix
table(Predicted=nb_test_predict, Actual=test$Cancelled )

#Confusion Matrix using caret package
confusionMatrix(data = nb_test_predict,reference=test$Cancelled, positive="1")



#agg <- aggregate(inputfile$DepDelay, list(inputfile$DayOfWeek, inputfile$UniqueCarrier),mean)

#agg[order(agg$x),]


#a <- ggplot(data = agg, aes(x = DepDelay, y = Month))
#a <- a + geom_point()
#a <- a + xlab("delay") + ylab("month") + ggtitle("randoma")
#a <- 
#a



