library(shiny)

stat <- read.csv("C:/Users/alanendarsa//Downloads/stat.csv", sep=";")
detientPokemon <- read.csv("C:/Users/alanendarsa/Downloads/detientPokemon.csv", sep=";")
dresseur <- read.csv("C:/Users/alanendarsa/Downloads/dresseur.csv", sep=";")
pokemon <- read.csv("C:/Users/alanendarsa/Downloads/pokemon.csv", sep=";")
estType <- read.csv("C:/Users/alanendarsa/Downloads/Caractéristique.csv", sep=";")
evolueEN <- read.csv("C:/Users/alanendarsa/Downloads/evolueEn.csv", sep=";")


shinyServer(function(input, output) { output$nuage <- renderPlot({
  plot(mtcars$mpg ~ mtcars[,input$choix], main = "Consommation")
})})


shinyServer(function(input, output) {
  output$nuage <- renderPlot({
    data <- as.data.frame(matrix( sample( 2:20 , 5 , replace=T) , ncol=5))
    colnames(data) <- c("attack" , "defense" , "Sp. Atk" , "Sp. Def" , "Speed")
    data <- rbind(rep(20,10) , rep(0,5) , data)
    radarchart(data)
  })
})