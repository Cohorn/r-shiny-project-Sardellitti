library(shiny)
library(shinydashboard)


shinyUI(fluidPage(
  titlePanel("Première application"),
  selectInput("choix", "Abscisse", c("wt", "hp", "disp")),
  plotOutput("nuage")
))
