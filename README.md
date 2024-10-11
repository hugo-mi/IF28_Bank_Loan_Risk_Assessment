https://acrobat.adobe.com/id/urn:aaid:sc:EU:132db531-2e6c-41f3-80b0-365d446d57da

# IF28_Bank_Loan_Risk_Assessment

## Présentation du projet

Avec l’aide de la méthode de TextMining nous souhaitons analyser différentes
sources en lien avec notre sujet pour en extraire les caractéristiques du profil type d’un bon emprunteur.

Ensuite en appliquant des méthodes de Machine Learning sur un jeu de données bancaires nous souhaitons prédire en fonction d’un profil donné la capacité de l'emprunteur à rembourser un prêt bancaire.

## Objectif du projet

L'objectif est de dresser les meilleurs profils d'emprunteur.

## Text Mining

### Wordcloud (_Voyant Tool_)

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/VoyantTool.png)

### Bag of Word (_Top Occurence_)

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/BoW.png)

### Analyse de termes avec les plus hautes occurences

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Term1_occurence.png)

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Term2_occurence.png)

### Graphe des termes (_Voyant Tool_)

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/BoW2.png)

### Graphe des termes Global

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Graphe_des_termes.png)

### Graphe de l'ontologie d'application

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Graphe_Ontologie_Application.png)

### Arbre de l'ontologie d'application

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Arbre_Ontologie.png)

### Arbre de l'ontologie d'application (_Protege_)

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Arbre_Ontologie_Protege.png)

**Hiérarchie des classe (_Protege_)**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Hierarchie_Ontologie.png)

**Relation entre les classes (_Protege_)**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Protege_objet.png)

**Hiérarchie des instances des classe (_Protege_)**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Individuals_Protege.png)

**Requête SPARQL**

_Informations contenu par l'ontologie concernant les Banques nationales._

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Requete_SPARQL.png)

_Informations contenu par l'ontologie concernant les Banques nationales et le type de banque dont il s'agit._

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Requete_SPARQL1.png)

## Data Mining

German Credit Data :
https://archive.ics.uci.edu/ml/datasets/statlog+(german+credit+data)

**Sources du Dataset :**
* Professor Dr. Hans Hofmann
* Institut für Statistik und Okonometrie
* Universität Hamburg

Ce jeu de données classe les personnes décrites par un ensemble d'attributs en fonction du profil de l'emprunteur.

Les caractéristiques du « Dataset » sont les suivantes :
* Caractéristiques du Dataset : Multivariable
* Domaine : Finance
* 1000 lignes
* 20 attributs (durée du prêt, âge de l'emprunteur, types de maison, montant du crédit,...)

### Extrait du dataset

https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/German_Credit_Dataset.png

**Analyse Descriptive du dataset**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/BoxPlot1.png)

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/BoxPlot2.png)

**Résumé des règles d'association**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Summary_Apriori.png)

### Application de l'algorithme Apriori (Règles d'association)

**Visualisation des 20 premières règles**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Output_Apriori.png)

**Analyse des règles d'association**

**Exemeples de règles obtenues pour Confidence = 3**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Rules_Confidence_3.png)

**Visualisation du lift des 20 premières règles**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Plotting_Lift.png)

**Visualisation du graphe orienté des règles**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Rules_Graph.png)

### Arbre de décision

**Arbre de décision sans contrainte sur la qualité du découpage**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Tree_No_Prune.png)

**Evaluation de la performance par validation croisée à 10 folds**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Decision_Tree_Eval.png)

**Arbre de décision à 7 feuilles**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Decision_Tree.png)

**Evaluation du modèlé : Confusion Matrix**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Confusion_Matrix.png)

**Calcul de l'erreur de classement et du taux de prédiction**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Error_Rate.png)

**Résultat de l'arbre de décision**

![](https://github.com/hugo-mi/IF28_Bank_Loan_Risk_Assessment/blob/main/Images/Output_Decision_Tree.png)
