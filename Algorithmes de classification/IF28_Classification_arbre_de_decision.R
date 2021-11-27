# ========================================
#           Arbre de décision

#          Author : Hugo Michel
# ========================================

# ==== ETAPE 1 : Chargement des librairies ====

  # On installe les laibraries qui permettent de créer l'arbre de décision et de le représenter
  
  library(rpart)# Pour construire l'arbre de décision
  library(rpart.plot) # Pour la représentation de l'arbre de décision
  library("tree")
  

# ==== ETAPE 2 : Chargement et préparation des données ====

  # On lit le fichier CSV "pret_bancaire"
  data <- read.table("C:/HUGO/UTT/COURS/IF28/Projet/Classification/pret_bancaire.csv", sep = ";", header = TRUE)
  
  # On vérifie que les données sont bien lues
  View(data)
  
  # Description des données
  summary(data)
  
  # Afin d'améliorer la représentation des labels au sein de l'arbre de décision, on renomme les valeurs de la variable cible
  # Si la valeur est 1 alors on remplace par "Good" sinon "Bad"
  for(i in 1:nrow(data)){
      if(data[i, 21] == 1){
      data[i, 21] <- "Good"
    }else{
      data[i, 21] <- "Bad"
    }
  }
  
  # On vérifie que les valeurs sont bien mises à jour
  head(data["Good_Bad"])
  
  # Gestion des données manquantes NA 
  
    # Selon la description réalisée par la fonction summary on observe que l'on par de données manquantes NA
  
  # Comme pour tout modèle, il est nécéssaire de construire l'arbre de décision sur un dataset de test
  
    # Préparation du dataset d'apprentissage et de test
    nb_lignes <- floor((nrow(data)*0.75)) # Nombre de lignes de l'échantillon d'apprentissage : 75% du dataset (750 lignes)
    data <- data[sample(nrow(data)), ] # Ajout de numéros de lignes
    
    # Création du dataset d'apprentissage
    data.train <- data[1:nb_lignes, ] # Echantillon d'apprentissage
    
    # Création du dataset
    data.test <- data[(nb_lignes+1):nrow(data), ] # Echantillon de test
  
# ==== ETAPE 3 : Apprentissage ====  
    
    # L'objectif de cette phase est de construire l'arbre et l'élaguer
    
    data.Tree <- rpart(Good_Bad~., data = data.train, method = "class", control = rpart.control(minsplit = 5, cp = 0))
    
    # Affichage du résultat
    plot(data.Tree, uniform=TRUE, branch=0.5, margin=0.1)
    text(data.Tree, all=FALSE, use.n=TRUE)
    
    # L'arbre obtenu est très développé. 
    # A ce stade, l'arbre de décision n'est pas exploitable. 
    # Il est nécéssaire d'élaguer l'arbre pour le simplifier et éviter le surapprentissage
    
    # L'idée est de minimiser l'erreur pour définir le niveau bon d'élagage
    
    plotcp(data.Tree) # Affiche le taux de mauvais classement en fonction de la taille de l'arbre. 
    
    # On cherche à minimiser l'erreur
    # Pour ce faire il convient de chercher le cp optimal
    print(data.Tree$cptable[which.min(data.Tree$cptable[,4]),1]) # Affichage du cp optimal
    
    # Elagage de l'arbre avec le cp optimal
    data.Tree_opt <- prune(data.Tree, cp = data.Tree$cptable[which.min(data.Tree$cptable[,4]),1])
    
    # Représentation graphique de l'arbre optimal
    prp(data.Tree_opt, extra = 1)
    
    # Autre forme de représensation du graphique en utilisant la bibliothèque rpart.plot
    rpart.plot(data.Tree_opt)
    
# ==== ETAPE 4 : Validation ====  
    
    # L'objectif est maintenant de valider les résultats avec l'échantillon de test
    
    # Prédiction du modèle sur les données de test
    data.Tree_predict <- predict(data.Tree_opt, newdata = data.test, type = "class")
    
    # Matrice de confusion 
    mc <- table(data.test$Good_Bad, data.Tree_predict)
    print(mc)
    
    # Calcul de l'erreur de classement
    erreur_classement <- 1.0 -(mc[1,1]+mc[2,2])/sum(mc)
    print(erreur_classement)
    
    # Calcul du taux de prédiction
    prediction <- mc[2,2]/sum(mc[2,])
    print(prediction)
    
# ========================================
#              RESULTAT
# ========================================
    
print(data.Tree_opt)