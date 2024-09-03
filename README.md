
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fec

<!-- badges: start -->
<!-- badges: end -->

# Goal of the project 

The goal of fec is to provide Free English classes an app for registering the students. 

# Framework and software

The framework I have worked with is golem. It is modularising the code. For more information see this link: https://engineering-shiny.org/golem.html

Moreover, I have added the whole code in one module only - https://github.com/gabrielburcea/fec/blob/master/R/mod_first_page.R. Later, after I launch the app, I may divide the code into modules, as of now, not a priority.

Software I work is R/RStudio IDE. 

# Running the app in dev mode 
The way to run the app, with golem framework is from dev folder - run_dev file. It is found here - https://github.com/gabrielburcea/fec/blob/master/dev/run_dev.R, which is within the fec package app. 

# Deployment

I have deployed the app on shinyapps.io since it is free. Here it is the link to the app deployed https://freeenglishclasses.shinyapps.io/freeenglishclasses/

# Database linkage

I am now in need of help to link the app to the database. It should be a free database if possible What this means: when students are registering themselves data needs to be saved into a database for analysis purposes. 

Check for more details the way the app is looking like since will give you an idea of how data is coming through: https://github.com/gabrielburcea/fec/blob/master/data/FEC%20Entry%20Web%20App.pdf

## Database 
As of now I am trying MongoDb

Here it is the link: https://cloud.mongodb.com/v2/66478018bb548c19f7dd587f#/overview

I may need to add people on this, but CAUTION !! Please do not share the data. GDPR is the rules we abide to. 

# Gitflow approach:

Please open a new branch and name it intuitively. 
I will then merge it into the master branch after run some tests. 

I may also open tickets in the future in case more people join to help, with issues in need of improvement. 



