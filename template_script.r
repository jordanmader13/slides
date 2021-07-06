#====================================================================================================================================================#
# R Data Exploration
# Maydm Summer 2021
#
# Use this script as a template to get started exploring and analyzing data in R
#   - Feel free to load whatever data you are interested in! As an example we are loading 
#     the National Park Visit Data (source: https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-09-17)
#     but there are so many datasets out there to explore!
#     Tidy Tuesday datasets: https://github.com/rfordatascience/tidytuesday/tree/master/data
#
#
#====================================================================================================================================================#

#========================#
# ==== load packages ====
#========================#
  # R is "open-source", meaning that people from all over the world can contribute to it.
  # Usually, the calculations, functions, and visualizations you're interested in using 
  # are also popular among other R users, so you can access the existing functions 
  # by installing and loading packages.
  
  install.packages('readr')
  library(readr) #this package is helpful for loading data from github

  install.packages('ggplot2')
  library(ggplot2) # this package has great functions to help with rearranging data

#====================#
# ==== load data ====
#====================#

  # Replace this link with a dataset of your choice, or go aheadexplore National Park Visits! 
  data <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-17/national_parks.csv")

#=======================#
# ==== explore data ====
#=======================#
  
  # View the first 100 rows of the data to get a sense of the column names and the values available
  View(head(data, 100))
  
  # How many years/locations/genres/categories are in your data? Use the '$' to specify the name of a column
  table(data$year)
  table(data$unit_type)
  table(data$region, data$unit_type) 
  
  # Based on what you've learned about the data's contents, do you want to focus in on one part of the data?
  # Here we are subsetting to year-specific data since 1980 in the National Parks
  sub_data <- subset(data, unit_type == "National Park" & year >= 1980 & year!= "Total")
  
  # Summarizing the data helps you see the range of values
  summary(sub_data$visitors)
  hist(sub_data$visitors)
  
#====================#
# ==== visualize ====
#====================#

  # Visualizing data can be a great first step when you asking a question about the relationship between multiple variables
  # You might wonder if visitation to three really popular parks -- Yellowstone, Yosemite, and the Grand Canyon -- follow the same trend over time
  
  # format the specific data for your plot -- we'll take the visitation data just for these three parks for now. 
  iconic_parks <- subset(sub_data, parkname %in% c("Yellowstone", "Yosemite", "Grand Canyon"))
  
  # Now we can create a scatterplot! Specify the name of your data, the values on the x and y axes, and the variable to color the points by
  # Looks like the Grand Canyon has been the most popular, but the parks mostly follow the same visitation trends!
  ggplot(data = iconic_parks, aes(x = year, y = visitors, color = parkname, group = parkname)) +
    geom_point() +
    geom_line()
  
