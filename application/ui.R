library(shiny)
library(shinydashboard)


shinyUI(
  dashboardPage(
  #Mise en place du titre 
  dashboardHeader(title = "Pokestat"),
  dashboardSidebar(width = 8),
  #contenu du dashboard 
  dashboardBody(
  fluidRow(

 
  #___________________________________________________________
  #CHOIX POKEMON / RADAR
  #___________________________________________________________
  
    
  # CHOIX POKEMON ---- (par nom pokemon)
  box(selectInput("choix", "Abscisse", pokemon$nom_pok)),
  
  
  #AFFICHAGE RADAR ----(par nom pokemon )
  box(plotOutput("radar")),

  #___________________________________________________________
  #CHOIX type graphique / Histograme
  #___________________________________________________________
  
  #Choix de l'histograme par caracteristique (poids / Taille) pour le graphique 
  box(radioButtons("radio", label = h3("Radio buttons"),
               choices = list("Poids" = "1", "Taille" = "2"), 
               selected = 1)),

  #Histograme dynamique par rapport radio buttons
  box(plotOutput("hist")),
  
  #___________________________________________________________
  #1) Stat choisi par l'utilisateur par rapport au type de pokemon 
  #2) boxplot par rapport a la stat choisi
  #___________________________________________________________ 
  
  #affichage du choix de la stat 
  box(selectInput("choix2", "Abscisse", c("HP","Attack","Defense","Speed"))),
  #affichage du boxplot
  box(plotOutput("camel")),
  
  #___________________________________________________________
  #1) et 2) L'utilisateur choisis 2 combatants différents
  #3)ressort un text qui dit quelle combatant a l'avantage en terme de statistique
  #___________________________________________________________ 
  # affiche les boutons pour choisir les combatants
  box(selectInput("choix2", "combattant 1", pokemon$nom_pok)),
  box(selectInput("choix3", "combattant 2", pokemon$nom_pok)),
  # affichage du texte
  box(textOutput("resumePok")),
  #___________________________________________________________
  #1) L'utilisateur choisis 1 pokemon
  #2) ressort un tableau avec différentes infos du pokemon
  #___________________________________________________________   
  
  # affichage du bouton pour choisir le pokemon
  box(selectInput("choix4", "Pokemon", pokemon$nom_pok)),
  # affichage du tableau
  box(tableOutput("tableau"))
))))