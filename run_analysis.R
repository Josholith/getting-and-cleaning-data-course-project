
# Bring in the column names from the features file.
colnames <- read.table("UCI HAR Dataset/features.txt"
                       , stringsAsFactors=FALSE)[,2]

# Load in the raw training & testing "X" vector tables
training <- read.table("UCI HAR Dataset/train/X_train.txt"
                       , col.names = colnames)
testing <- read.table("UCI HAR Dataset/test/X_test.txt"
                      , col.names = colnames)

# Subset the columns by their names,
# keeping only those containing mean() or std()
training <- training[,grep("mean()|std()",colnames)]
testing  <- testing[,grep("mean()|std()",colnames)]

# Bring in the activities labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt"
                         , stringsAsFactors=FALSE)[,2]
# Then bring in the activies (i.e. the objective)
trainingy <- read.table("UCI HAR Dataset/train/y_train.txt")
testingy <- read.table("UCI HAR Dataset/test/y_test.txt")

# Convert to factors, give the levels their descriptive labels,
# and set the column name to "activity"
trainingy$V1 <- factor(trainingy$V1)
names(trainingy) <- c("activity")
levels(trainingy$activity) <- activities

testingy$V1 <- factor(testingy$V1)
names(testingy) <- c("activity")
levels(testingy$activity) <- activities

# Bring in the subject data
trainings <- read.table("UCI HAR Dataset/train/subject_train.txt")
testings <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Make it a factor and fix up the column name
trainings$V1 <- factor(trainings$V1)
names(trainings) <- c("subject")

testings$V1 <- factor(testings$V1)
names(testings) <- c("subject")

# Column bind the subject, X, and y together.
training <- cbind(trainings, training, trainingy)
testing <- cbind(testings, testing, testingy)

# Union the training and testing data sets
both <- rbind(training, testing)

# Remove dots from names from column names
names(both) <- gsub("\\.", "", names(both))

# Column names to lower
names(both) <- tolower(names(both))

write.table(both, "tidy.txt")

# From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
agg <- aggregate(  both[, 2:80]
                 , list(subject = both$subject
                 , activity = both$activity), mean)

# Output the processed file.
write.table(agg, "aggregated.txt")
