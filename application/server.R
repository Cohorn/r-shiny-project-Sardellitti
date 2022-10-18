#compilation des packages avec R
library(shiny)
library(shinydashboard)
library(dplyr)
library(fmsb)
library(DataCombine)
#library(BDI)
#library(RSQLite)

# importation des bdd avec les csv
stat <- read.csv("C:/Users/vicol/OneDrive/Bureau/stat.csv", sep=";")
detientPokemon <- read.csv("C:/Users/vicol/OneDrive/Bureau/detientPokemon.csv", sep=";")
dresseur <- read.csv("C:/Users/vicol/OneDrive/Bureau/dresseur.csv", sep=";")
pokemon <- read.csv("C:/Users/vicol/OneDrive/Bureau/pokemon.csv", sep=";")
caracteristique <- read.csv("C:/Users/vicol/OneDrive/Bureau/Caracteristique.csv", sep=";")
evolueEN <- read.csv("C:/Users/vicol/OneDrive/Bureau/evolueEn.csv", sep=";")

# importation des bdd sous sql
#
#


# jointure entre la table pokemon et stat
jointure1 <- left_join(pokemon, stat)


shinyServer(function(input, output) {
  #definition du header
  set.seed(100)
  histdata <- rnorm(500)
  
  #création du radar avec les stats du pokemon choisis
  output$radar <- renderPlot({
    #on créer une bdd avec une ligne avec les stats du pomemon, une ligne min pour le radar(0 partout) ligne max pour le radar (180 partout sauf 250 pour les HP)
    data <- jointure1[pokemon[pokemon$nom_pok == input$choix,"id_pok"],5:10]
    data <- InsertRow(data, 1, NewRow = c(250,180,180,180,180,180))
    data <- InsertRow(data, 2, NewRow = c(0,0,0,0,0,0))
    data <- data[-4,] 
    radarchart(data)
  })
  
  # création de l'histogramme de la répartition des pokemons selon soit la taille soit le poids(c'est l'utilisateur qui choisis le poid ou la taille)
  output$hist <- renderPlot({
    # si l'utilisateur choisis poid ou taille on lui ressort le graphique adapté
    if (input$radio == "1"){
      #on transforme les données en numéric
        caracteristique$weight_kg <- as.numeric(caracteristique$weight_kg)
        class(caracteristique$weight_kg)
        hist(x = caracteristique$weight_kg, breaks = 10, probability = FALSE,col = "yellow", xlab = "Tranche de poids",main = "Nombre de pokemon par trache de poids",col.main = "blue")
      }
    if (input$radio == "2"){
      #on transforme les données en numéric
        caracteristique$height_m <- as.numeric(caracteristique$height_m)
        class(caracteristique$height_m)
        hist(x = caracteristique$height_m, breaks = 10, probability = FALSE,col = "yellow", xlab = "Tranche de Taille",main = "Nombre de pokemon par trache de taille",col.main = "blue")
      }})
  
  # création du boxplot de la stat choisis(attack, def...) selon le type des pokemons
  output$camel <- renderPlot({
    # si l'utilisateur choisis l'attack, la def, la vitesse ou les pv on lui ressort le graphique adapté
    if (input$choix2 == "Attack"){
    boxplot(formula = Attack ~ Type1,
            data = stat, 
            main = "Boxplot Attack vs Type", 
            las = 2, col = colors())}
    if (input$choix2 == "HP"){
      boxplot(formula = HP ~ Type1,
              data = stat, 
              main = "Boxplot HP vs Type", 
              las = 2, col = colors())}
    if (input$choix2 == "Defense"){
      boxplot(formula = Defense ~ Type1,
              data = stat, 
              main = "Boxplot Defense vs Type", 
              las = 2, col = colors())}
    if (input$choix2 == "Speed"){
      boxplot(formula = Speed ~ Type1,
              data = stat, 
              main = "Boxplot Speed vs Type", 
              las = 2, col = colors())}
  })


  #création du texte
  output$resumePok <- renderText({
    # Selon si c'est le combattant 1 ou 2 qui gagne selon le total des stats on aficche le texte adapté
    if (jointure1[input$choix2,11] > jointure1[input$choix3,11])
    {print("Le combattant 1 a l'avantage en terme de statistique")}
    else{print("Le combattant 2 a l'avantage en terme de statistique")}
  })
  
  #création du tableau avec les infos du pokémon choisis
  output$tableau <- renderTable({
    tableau <- caracteristique[pokemon[pokemon$nom_pok == input$choix4,"id_pok"],1:4]
  })
  
})



