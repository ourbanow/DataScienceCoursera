# This is a shiny app

library(shiny)
library(ggplot2)
library(dplyr)

activities <- read.csv(url("https://raw.githubusercontent.com/ourbanow/DataScienceCoursera/master/Developing%20Data%20Products/Internetuse.csv"))
names(activities)[1] <- "ExpPeriod"
countrylist <- levels(activities$ExpCountry)
activitylist <- levels(activities$Internetuse)
agelist <- levels(activities$ExpBrkDwn)

shinyServer(function(input, output) {

    output$countryyear <- renderPlot({
        mydata <- activities %>% 
            filter(ExpCountry == input$selectcountry) %>% 
            filter(ExpBrkDwn == input$selectage) %>%
            filter(Internetuse == input$selectactivity)
        eudata <- activities %>% 
            filter(ExpCountry == "European Union") %>% 
            filter(ExpBrkDwn == input$selectage) %>%
            filter(Internetuse == input$selectactivity)
        mytitle <- paste("Internet use:", input$selectactivity, "in", input$selectcountry, "for", input$selectage)
        ggplot(eudata, aes(x= ExpPeriod, y = Value)) + geom_line(aes(colour=
        "euline"), size = 1) + geom_line(data=mydata, aes(colour=
        "myline"), size = 1) + scale_x_continuous(name="Year", breaks =
        seq(2002,2020,2), limits=c(2002, 2019)) + scale_y_continuous(name="Percentage", breaks =
        seq(0,100,10), limits=c(0, 100)) + scale_colour_manual(name="Country",
        values=c(euline="grey54", myline="blue"), labels=
        c("European Union",input$selectcountry)) + ggtitle(mytitle) + theme(plot.title = element_text(hjust = 0.5))
    })
    
    output$iuplot <- renderPlot({
        mydata2 <- activities %>% 
            filter(ExpCountry == input$selectcountry) %>% 
            filter(ExpBrkDwn == input$selectage)
        mytitle2 <- paste("Internet use in", input$selectcountry, "for", input$selectage)
        ggplot(mydata2, aes(x= ExpPeriod, y = Value, colour=Internetuse)) + geom_line(size =
        1) + scale_x_continuous(name="Year", breaks = seq(2002,2020,2), limits=c(2002, 2019)) + scale_y_continuous(name=
        "Percentage", breaks =seq(0,100,10), limits=c(0, 100)) + ggtitle(mytitle2) + theme(plot.title =
        element_text(hjust = 0.5)) + labs(colour="Internet use:")
    })
    
    output$ageplot <- renderPlot({
        agelist2 <- c("age 0 to 15", "age 16 to 24", "age 25 to 34", "age 35 to 44", "age 45 to 54",
                      "age 55 to 64", "age 65 to 74", "age 75 and over")
        mydata3 <- activities %>% 
            filter(ExpCountry == input$selectcountry) %>% 
            filter(ExpBrkDwn %in% agelist2) %>%
            filter(Internetuse == input$selectactivity)
        mytitle3 <- paste("Internet use:", input$selectactivity, "in", input$selectcountry)
        ggplot(mydata3, aes(x= ExpPeriod, y = Value, colour=ExpBrkDwn)) + geom_line(size =
        1) + scale_x_continuous(name="Year", breaks = seq(2002,2020,2), limits=c(2002, 2019)) + scale_y_continuous(name=
        "Percentage", breaks =seq(0,100,10), limits=c(0, 100)) + ggtitle(mytitle3) + theme(plot.title =
        element_text(hjust = 0.5)) + labs(colour="Age bracket")
    })
    
})
