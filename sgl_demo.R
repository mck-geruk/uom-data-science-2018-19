# p. 28

install.packages("sqldf")
library(sqldf)
sqldf("SELECT*FROM raw_data") # star means all of the columns
sqldf("SELECT Age,Sex FROM raw_data")
sqldf("SELECT * FROM raw_data WHERE Age>50")
sqldf("SELECT * FROM raw_data WHERE Age < 50 AND Pclass=1")

