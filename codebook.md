# Design
* Only core R packages are used.
* Assumes the ZIP file is downloaded and extracted with files in `UCI HAR Dataset` subfolder
* No helper functions were needed.
* Tidy output gets written to `tidy.txt`
* Aggregated output gets written to `aggregated.txt`

# Variables
`colnames` - column names from the features.txt file

`training` - training "X" vector table
`testing` - testing "X" vector table

`activities` - activity labels

`trainingy` - objective values for training
`testingy` - objective values for testing

`trainings` - subject values for training
`testings` - subject values for testing

`both` - union data set of training and testing

`agg` - average of selected measures, grouped by subject and activity
