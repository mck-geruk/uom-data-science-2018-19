# Introduction to data science with applications in R and git
# University of Manchester 
# Tutorial led by Tom Franklin, 06/02/2019

####
# Tutorial 1 Code ----
# 1. Install and load libraries
# 2. Load data 
# 3. Data manipulation with dplyr
# 4. Data summarisation 
# 5. Graphics with ggplot2 

####
# 1. Install and load libraries ----

# Installing R packages
install.packages("tidyverse")

# Loading R packages
library("tidyverse")

# Tasks: 
# How would I install the skimr package? 
install.packages("skimr")
# How would I load the skimr package? 
library("skimr")
# Do the same for following packages:
# `skimr`, `RColorBrewer` and `ggthemes` 
install.packages("`skimr`")
library("`skimr`")


####
# 2. Load data ----
raw_data <- readr::read_csv("data/passenger_data.csv")

# This is equivilant but we don't use this! 
readr::read_csv("data/passenger_data.csv") -> raw_data 

# Quick glance at the data

skimr::skim(raw_data)

####
# 3. Data manipulation with dplyr ----
library(tidyverse)

# In words, can you explain what %>% stands for? 

# Selecting columns 

raw_data %>%
  dplyr::select()

# Task:

# i. Select Age and Sex columns only 
selected.data.1 <- raw_data %>%
  dplyr::select(Age,Sex)

# ii. Select all data apart from the Survived column
selected.data.2 <- raw_data %>%
  dplyr::select(-Survived)

# iii. Select the first three variables using numeric 
selected.data.3 <- raw_data %>%
  dplyr::select(1:3)

# Filtering data
filtered.data0<-raw_data %>%
  dplyr::filter(Pclass == 3)

# i. Filter data to keep only those where Pclass (passenger class) is equal to 1
filtered.data1<-raw_data %>%
  dplyr::filter(Pclass == 1)

# 11. Filter the data to keep only data where there's first 
#     class passengers and passengers are aged over 50
filtered.data2<-raw_data %>%
  dplyr::filter(Pclass == 1, Age > 50)

filtered.data2 %>%
  dplyr::distinct(Pclass)

filtered.data2 %>%
  dplyr::distinct(Age)

# Survived == 0
filtered.data4<-raw_data %>%
  dplyr::filter(Survived==0)

filtered.data4 %>%
  dplyr::distinct(Survived)

# iii. Filter data to keep only 2nd and 3rd Class passengers 
filtered.data3<-raw_data %>%
  dplyr::filter(Pclass == 2|Pclass==3)

filtered.data3 %>%
  dplyr::distinct(Pclass)

# iv. Filter data for only those who Embarked n the journey from Cherbourg

# Task p. 23 filtering data and then selecting the variables we want
filtered_and_selected_data<-raw_data %>%
  filter(Age>50) %>%
  select(Age, Sex, Pclass)

# Renaming data

# i. Rename the Sex column to be Gender, 

# tip: rename(new_column_name = old_column_name)

renamed_data<-raw_data %>%
  rename(Gender=Sex)

# Arranging data

# Arrange young to old
young_to_old_data<- raw_data %>%
  arrange(Age)

# i. Arrange the dataframe from low to high 
low_to_old_data<- raw_data %>%
  arrange()

# ii. Arrange Fare data from high to low
high_to_low<- raw_data %>%
  arrange(desc(Fare))

# Make new variablea (mutate)

# i. Create a new variable called fare_in_dollars, multiplying the fare by a conversion rate of 1.37
data_with_dollar_information<- raw_data %>%
  mutate(Fare_Dollars= Fare*1.37)

View(data_with_dollar_information)

# ii. Create an estimate of a passengers birth year by using their Age information!
data_birth_estimate<- raw_data %>%
  mutate(Birth_year_estimate = round(1912-Age))

# Practice stuff
mean(raw_data$Age,na.rm = TRUE)
# average age is 29.7
raw_data %>%
  summarise(average_age= mean(Age,na.rm = TRUE))

raw_data %>%
  group_by(Sex,Pclass) %>%
  summarise(average_age= mean(Fare,na.rm = TRUE))

# iii. Create a flag to indicate those who have an above average age (29.70)

average_age_data<-raw_data %>%
  mutate(above_average_age = ifelse(Age>29.7,1,0))

# Summary statistics - refer to the booklet for tasks! 

# Practice p.25

# 4.
raw_data %>%
  group_by(Pclass) %>%
  summarise(median(Fare))

fare_data<- raw_data %>%
  mutate(Fare_all = ifelse(Fare==0 & Pclass==1, 60,
                  ifelse(Fare==0 & Pclass==2, 14,
                  ifelse(Fare==0 & Pclass==3, 8, Fare))))
# Recoding data 

# i. Recode the integer values of passenger classes to be "1st Class", "2nd Class" etc...

# Distinct data

# i. Get a distinct list of the Cabin names on the titanic 

# Advanced exercises 


####
# 4. Data summarisation (using base R syntax)

# Summary stats of passenger Sex
table(raw_data$Sex)

# Cross tabulation of passenger Sex and whether they Survived or not

# Proportion tables...

# Column sum table 

# Row sum table 

# 3 way cross tab breakdown by Passenger class, Sex and Survival status 

####
# 5. Graphics with ggplot2 ----
install.packages("ggplot2")
library(ggplot2)

# Make your first ggplot2 bar chart! 
ggplot(data= raw_data, aes(x=Pclass))+
  geom_bar()

# Make a filled bar chart 
ggplot(data= raw_data, aes(x=Pclass, fill=Sex))+
  geom_bar()

ggplot(data= raw_data, aes(x=Pclass))+
  geom_bar(aes(fill= Sex), position = "fill")+
  theme_classic()+
  labs(title = "Mean outnumbered women across all passenger classes", subtitle= "On the titanic disaster",
       x="Passenger Class", y= "Proportion Male/Female",
       caption= "Source: National Archives")

# Make a ggplot2 with a theme

# Make a scatterplot
ggplot(data=raw_data,
       aes(x= Age, y = Fare, colour = as.factor(Pclass)))+
  geom_point()+
  geom_smooth(method = lm)
  theme_minimal()+
  scale_color_manual(values= c("red",
                               "blue",
                               "orange"))


# Make an interactive scatterplot 
# - Note that you'll need the `ploty` package to do this!
