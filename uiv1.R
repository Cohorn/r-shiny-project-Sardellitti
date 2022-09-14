library(shiny)

shinyUI(fluidPage(
  titlePanel("Première application"),
  selectInput("choix", "Abscisse", stat$id_pok),
  plotOutput("nuage")
))