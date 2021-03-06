# ========================================
#           Arbre de d�cision

#          Author : Hugo Michel
# ========================================

# ==== ETAPE 1 : Chargement des librairies ====

  # On installe les laibraries qui permettent de cr�er l'arbre de d�cision et de le repr�senter
  
  library(rpart)# Pour construire l'arbre de d�cision
  library(rpart.plot) # Pour la repr�sentation de l'arbre de d�cision
  library("tree")
  

# ==== ETAPE 2 : Chargement et pr�paration des donn�es ====

  # On lit le fichier CSV "pret_bancaire"
  data <- read.table("C:/HUGO/UTT/COURS/IF28/Projet/Classification/pret_bancaire.csv", sep = ";", header = TRUE)
  
  # On v�rifie que les donn�es sont bien lues
  View(data)
  
  # Description des donn�es
  summary(data)
  
  # Afin d'am�liorer la repr�sentation des labels au sein de l'arbre de d�cision, on renomme les valeurs de la variable cible
  # Si la valeur est 1 alors on remplace par "Good" sinon "Bad"
  for(i in 1:nrow(data)){
      if(data[i, 21] == 1){
      data[i, 21] <- "Good"
    }else{
      data[i, 21] <- "Bad"
    }
  }
  
  # On v�rifie que les valeurs sont bien mises � jour
  head(data["Good_Bad"])
  
  # Gestion des donn�es manquantes NA 
  
    # Selon la description r�alis�e par la fonction summary on observe que l'on par de donn�es manquantes NA
  
  # Comme pour tout mod�le, il est n�c�ssaire de construire l'arbre de d�cision sur un dataset de test
  
    # Pr�paration du dataset d'apprentissage et de test
    nb_lignes <- floor((nrow(data)*0.75)) # Nombre de lignes de l'�chantillon d'apprentissage : 75% du dataset (750 lignes)
    data <- data[sample(nrow(data)), ] # Ajout de num�ros de lignes
    
    # Cr�ation du dataset d'apprentissage
    data.train <- data[1:nb_lignes, ] # Echantillon d'apprentissage
    
    # Cr�ation du dataset
    data.test <- data[(nb_lignes+1):nrow(data), ] # Echantillon de test
  
# ==== ETAPE 3 : Apprentissage ====  
    
    # L'objectif de cette phase est de construire l'arbre et l'�laguer
    
    data.Tree <- rpart(Good_Bad~., data = data.train, method = "class", control = rpart.control(minsplit = 5, cp = 0))
    
    # Affichage du r�sultat
    plot(data.Tree, uniform=TRUE, branch=0.5, margin=0.1)
    text(data.Tree, all=FALSE, use.n=TRUE)
    
    # L'arbre obtenu est tr�s d�velopp�. 
    # A ce stade, l'arbre de d�cision n'est pas exploitable. 
    # Il est n�c�ssaire d'�laguer l'arbre pour le simplifier et �viter le surapprentissage
    
    # L'id�e est de minimiser l'erreur pour d�finir le niveau bon d'�lagage
    
    plotcp(data.Tree) # Affiche le taux de mauvais classement en fonction de la taille de l'arbre. 
    
    # On cherche � minimiser l'erreur
    # Pour ce faire il convient de chercher le cp optimal
    print(data.Tree$cptable[which.min(data.Tree$cptable[,4]),1]) # Affichage du cp optimal
    
    # Elagage de l'arbre avec le cp optimal
    data.Tree_opt <- prune(data.Tree, cp = data.Tree$cptable[which.min(data.Tree$cptable[,4]),1])
    
    # Repr�sentation graphique de l'arbre optimal
    prp(data.Tree_opt, extra = 1)
    
    # Autre forme de repr�sensation du graphique en utilisant la biblioth�que rpart.plot
    rpart.plot(data.Tree_opt)
    
# ==== ETAPE 4 : Validation ====  
    
    # L'objectif est maintenant de valider les r�sultats avec l'�chantillon de test
    
    # Pr�diction du mod�le sur les donn�es de test
    data.Tree_predict <- predict(data.Tree_opt, newdata = data.test, type = "class")
    
    # Matrice de confusion 
    mc <- table(data.test$Good_Bad, data.Tree_predict)
    print(mc)
    
    # Calcul de l'erreur de classement
    erreur_classement <- 1.0 -(mc[1,1]+mc[2,2])/sum(mc)
    print(erreur_classement)
    
    # Calcul du taux de pr�diction
    prediction <- mc[2,2]/sum(mc[2,])
    print(prediction)
    
# ========================================
#              RESULTAT
# ========================================
    
print(data.Tree_opt)