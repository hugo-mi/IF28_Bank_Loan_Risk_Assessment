# ========================================
#       Règles d'association Apriori

#          Author : Hugo Michel
# ========================================

# ==== ETAPE 1 : Chargement des librairies ====

# On installe les laibraries
  
library("arules") # pour calculer les règles d'association
library("arulesViz") # pour afficher des graphiques en lien avec les règles d'association

# ==== ETAPE 2 : Chargement et préparation des données ====

  # On lit le fichier CSV "pret_bancaire"
  data <- read.table("C:/HUGO/UTT/COURS/IF28/Projet/Classification/pret_bancaire.csv", sep = ";", header = TRUE)
  head(data)
  
  # On visualise le fichier CSV
  View(data)
  
  # On affiche une description du dataset
  summary(data)
  
  # Il s'avère que le dataset contient un mélange d'attributs qualitatifs et d'attributs quantitatifs mesurables (ex: Duration_in_month)
  # Cela requiert un peu de préparation avant de pouvoir être mis la forme d'un ensemble de transactions susceptibles d'être fouillé à la recherche d'association
  # Pour ce faire on souhaite transformer 7 attributs numériques en attributs qualitatifs ordinaux en créant des catégories adéquates
  # Nous divisons les variables suivantes en catégories sur des valeurs seuils usuelles
  
      # Attribut 2 : Durée en mois (min : 4 max : 72) labels : (0,25,50,75) => (short_term, mid_term, long_term)
      data[["Duration_in_month"]] <- ordered(cut(data[["Duration_in_month"]],c(0, 25, 50, 75)), labels =c("short_term", "mid_term", "long_term"))
  
      # Attribut 5 : Montant du crédit (min 250 max : 18424) labels : (0,5000, 10000, 15000) => (low, mid, high)
      data[["Credit_amount"]] <- ordered(cut(data[["Credit_amount"]],c(0, 7000, 14000, 21000)), labels =c("low", "mid", "high"))
      
      # Attribut 8 : Taux de versement en pourcentage du revenu disponible (min : 1% max : 4%) 
      # labels : (0,1,2,4) => (low, mid, high)
      data[["Installment_rate_in_percentage_of_disposable_income"]] <- ordered(cut(data[["Installment_rate_in_percentage_of_disposable_income"]],c(0,1,2,4)), labels =c("low", "mid", "high"))

      # Attribut 11 : Résidence actuelle depuis (min : 1 max : 4) labels => (0,1,2,4) => (new, recent, old)
      data[["Present_residence_since"]] <- ordered(cut(data[["Present_residence_since"]],c(0, 1, 2, 4)), labels =c("new", "recent", "old"))
      
      # Attribut 13 : Age en année (min : 19 ans max : 75 ans) labels => (15,25,45,65,100) => (young, middle-aged, senior, old) 
      data[["Age_in_years"]] <- ordered(cut(data[["Age_in_years"]],c(15, 25, 45, 65, 100)), labels =c("young", "middle-aged", "senior", "old"))
      
      # Attribut 16 : Nombre de crédits existants dans une banque (min : 1 max : 4) labels => (0,1,2,4) => (low, mid, high) 
      data[["Number_of_existing_credits_at_this_bank"]] <- ordered(cut(data[["Number_of_existing_credits_at_this_bank"]],c(0, 1, 2, 4)), labels =c("low", "mid", "high"))
      
      # Attribut 18 : Nombre de personnes tenues de fournir une pension alimentaire pour (min : 1 max : 2) 
      # labels => (0,1,2) => (low, high) 
      data[["Number_of_people_being_liable_to_provide_maintenance_for"]] <- ordered(cut(data[["Number_of_people_being_liable_to_provide_maintenance_for"]],c(0, 1, 2)), labels =c("low", "high"))
      
      # Attribut 20 : Il s'agit de la variable target 
      # Si la valeur est 1 alors on remplace par "Good" sinon "Bad"
      for(i in 1:nrow(data)){
        if(data[i, 21] == 1){
          data[i, 21] <- "Good"
        }else{
          data[i, 21] <- "Bad"
        }
      }
      
      # On re-visualise le dataset. On s'assure qu'il ne reste plus aucune variable numérique
      head(data)
      
  # A ce stade les données peuvent maintenant être enregistrées sous la forme d'une matrice d'incidence 
  # en transformant le dataset en un ensemble de transactions
  
  data_transaction <- as(data, "transactions")
  data_transaction
  
  # On obtient le résultat suivant
  
  # >   data_transaction
  # transactions in sparse format with
  # 1000 transactions (rows) and
  # 77 items (columns)
  
  # On affiche l'apercu des transactions 
  summary(data_transaction)
  
  # Le réesumé du jeu de transactions donne un aperçcu rapide qui montre les items les
  # plus fréquents, la distribution de la longueur des transactions et des informations
  # supplémentaires qui indiquent quelles sont les variables et les modalités qui ont
  # été utilisées pour créer chacune des variables binaires.  
  
# ==== ETAPE 3 : Création des règles d'associations ====
  
  # Nous faisons appel à la fonction apriori pour trouver toutes les règles (le type d'association par défaut pour apriori) 
  # avec un support minimum de 1% et une confiance de 0.6.  
  
  rules <- apriori(data_transaction, parameter = list(sup = 0.01, conf = 0.6, target="rules"))
  
  # On visualise les 20 premières règles
  inspect(rules[1:20])
  
  # Pour déterminer quels sont les items importants dans le jeu de données, nous pouvons
  # utiliser le graphique itemFrequencyPlot. Pour reduire le nombre des items, nous
  # représentons seulement ceux pour lesquels le support est supérieur à 10%
  
  # On affiche la fréquence relatives des items présent dans le dataset avec un support supérieur à 10%
  itemFrequencyPlot(data_transaction, support = 0.1, cex.names = 0.8)
  
  summary(rules)
  # On obtient 36 199 298  rules. Toutes ces règles ne pourront être analyser finement au cas par cas
  
  # Comme souvent lorsque on cherche des règles d'association, le nombre de règles
  # extraites est considérablement élevé.
  
# ==== ETAPE 4 : Analyse de certaines règles ====
  
  # Pour analyser certaines règles rélévatrices, on utilise la fonction subet 
  # La fonction subset permet d'obtenir des sous-ensembles séparés pour chacune des modalités 
  # qui provenait de la variable "Good_Bad" lorsqu'elle apparait sur membre de droite
  
  rulesGood <- subset(rules, subset = rhs %in%"Good_Bad=Good" & lift > 1.2)
  rulesBad <- subset(rules, subset = rhs %in%"Good_Bad=Bad" & lift > 1.2)
  
  inspect(head(sort(rulesGood, by = "confidence"), n = 3))
  inspect(head(sort(rulesBad, by = "confidence"), n = 3))
  
# ==== ETAPE 5 : Visualisation des règles d'associations ====
  
  # On visualise le lift en fonction du support
  # Il s'agit d'un graphe interactif
  plot(rules[1:20],measure=c("support","lift"),shading="confidence",interactive=T)
  
  
  # On visualise une vue d'ensemble du résultat
  # On cherche à obtenir un aperçu des règles et les objets qui les composent sur un graphique
  plot(rules[1:20], method="graph", control=list(type="items"), cex=0.7)
  
  