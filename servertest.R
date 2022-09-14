library(shiny)
library(shinydashboard)

stat <- read.csv("C:/Users/alanendarsa//Downloads/stat.csv", sep=";")
detientPokemon <- read.csv("C:/Users/alanendarsa/Downloads/detientPokemon.csv", sep=";")
dresseur <- read.csv("C:/Users/alanendarsa/Downloads/dresseur.csv", sep=";")
pokemon <- read.csv("C:/Users/alanendarsa/Downloads/pokemon.csv", sep=";")
estType <- read.csv("C:/Users/alanendarsa/Downloads/Caractéristique.csv", sep=";")
evolueEN <- read.csv("C:/Users/alanendarsa/Downloads/evolueEn.csv", sep=";")

shinyServer(function(input, output) {
  output$nuage <- renderPlot({
    plot(mtcars$mpg ~ mtcars[,input$choix], main = "Consommation")
  })
})

