library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
  navbarPage("Visualizing LEGO Sets Over Time", 
             
             tabPanel("Explore",
                      sidebarPanel(
                        sliderInput("timeline", 
                                    label = "Timeline", 
                                    min = 1950,
                                    max = 2016,
                                    value = c(1973, 1991)),
                        sliderInput("pieces", 
                                    label = "Pieces",
                                    min = 1,
                                    max = 5922,
                                    value = c(500, 5834) 
                        ),
                        #format = "####"),
                        uiOutput("themesControl"), # the id
                        actionButton(inputId = "clearAll", 
                                     label = "Clear selection", 
                                     icon = icon("square-o")),
                        actionButton(inputId = "selectAll", 
                                     label = "Select all", 
                                     icon = icon("check-square-o"))
                        
                      ),
                      mainPanel(
                        tabsetPanel(
                          # Data 
                          tabPanel(p(icon("table"), "Dataset"),
                                   dataTableOutput(outputId="dTable")
                          ), # end of "Dataset" tab panel
                          tabPanel(p(icon("line-chart"), "Visualize the Data"),
                                   h4('Sets per Year', align = "center"),
                                   h5('Hover over each point to see the number of sets in a given year.', 
                                      align ="center"),
                                   showOutput("setsByYear", "nvd3"),
                                   
                                   h4('Pieces per Year', align = "center"),
                                   h5('Hover over each point to see the set name, ID and theme.', 
                                      align ="center"),
                                   showOutput("piecesByYear", "nvd3"),
                                   
                                   h4('Average Pieces per Year', align = "center"),
                                   showOutput("piecesByYearAvg", "nvd3"),
                                   
                                   h4('Average Pieces per Theme', align = "center"),
                                   showOutput("piecesByThemeAvg", "nvd3")
                          ) # end of "Visualize the Data" tab panel
                          
                        )
                        
                      )     
             ), # end of "Explore Dataset" tab panel
             
            
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("about.md")
                      )
             ) # end of "About" tab panel
             )  
  )