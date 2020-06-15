#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

activities <- read.csv(url("https://raw.githubusercontent.com/ourbanow/DataScienceCoursera/master/Developing%20Data%20Products/Internetuse.csv"))
countrylist <- levels(activities$ExpCountry)
activitylist <- levels(activities$Internetuse)
agelist <- levels(activities$ExpBrkDwn)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Evolution of internet use since 2002"),

    # Sidebar 
    sidebarLayout(
        sidebarPanel(
            tabsetPanel(
                type = "tabs",
                tabPanel(
                    br(),
                    title="Country & Activity",
                    selectInput("selectcountry",
                                "Which country would you like to display?", 
                                choices = countrylist,
                                selected = "Germany"
                    ),
                    radioButtons("selectactivity",
                                "Which type of internet use are you interested in?", 
                                choices = activitylist,
                                selected = "sending/receiving e-mails"
                    ),
                ),
                tabPanel(
                    br(),
                    title="Age bracket",
                    radioButtons("selectage",
                                "Which age bracket would you like to display?", 
                                choices = agelist,
                                selected = "all ages"
                    )
                )
            )
        ),

        # Mainpanel
        mainPanel(
            h5("Welcome to this shiny app, created by Olivia Urbanowski in June 2020 in the scope of the course \"Developing Data Products\" on Coursera."),
            helpText("This app allows you to visualize data about internet use in the Europe since 2002. In the side panel, you can select for which country you would like to visualize data,
               for which type of activity, and for which age bracket (for tabs \"Internet use\" & \"Detailed data\")."), 
            helpText("The data used to built these graphs comes from the website of the European Union. The obtained datasets have been 
                     cleaned and consolidated; however, due to a question of available time and prioritzation, errors may persist (such as sudden drops in percentage). Please disregard these - thank you for your understanding!"),
            tabsetPanel(
                type = "tabs",
                tabPanel(
                    br(),
                    title = "Per age bracket",
                    plotOutput("ageplot")
                ),
                tabPanel(
                    br(),
                    title ="Per type of activity",
                    plotOutput("iuplot")
                ),
                tabPanel(
                    br(),
                    title ="Per Country",
                    plotOutput("countryyear")
                )
            ),
            helpText("Reference:"),
            helpText(a(href="https://github.com/ShinyEd/ShinyEd/tree/master/CLT_mean", target="_blank", "Europa website - databases")),
            helpText(a(href="https://github.com/ourbanow/DataScienceCoursera/tree/master/Developing%20Data%20Products", target="_blank", "GitHub Repository"))
        )
    )
))
