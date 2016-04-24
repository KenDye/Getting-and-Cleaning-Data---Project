---
title: "Getting and cleaning Data - Week 4 Project"
output: html_document
---

## Details of the  data data used in this project can be found:

Date set full description: "Human Activity Recognition Using Smartphones Data Set" URL to description of data:<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

URL to data:<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

## Getting and Cleaning Data Coursera course Week 4 Project README.  R-Code - run_analysis.R

     - Downloads the data.
     - Loads the activity and feature information.
     - Loads only the training and test standard deviation and mean data.
     - Loads and merges the activity and subject data.
     - Creates subject and activity factorals.
     - Creates an independent tidy datase with the average of each variable for each
       activity and each subject, then saves it to tidydata.txt.