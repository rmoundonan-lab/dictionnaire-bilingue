RAPPORT DE TP DÉTAILLÉ
Gestion d’un dictionnaire bilingue en langage PASCAL
Ce programme réalise un dictionnaire bilingue (français–anglais) permettant de stocker, rechercher, modifier et supprimer des mots. Les données sont stockées dans un tableau d’enregistrements maintenu trié par ordre alphabétique sur les mots français.
Le programme fonctionne de manière interactive grâce à un menu principal et plusieurs sous-programmes spécialisés.
________________________________________
1. Objectif du programme
L’objectif est de concevoir un dictionnaire bilingue capable de :
•	stocker des mots français et leurs traductions anglaises 
•	insérer des mots en maintenant un ordre alphabétique 
•	rechercher un mot rapidement 
•	supprimer et modifier des entrées 
•	afficher le contenu du dictionnaire 
•	fournir des statistiques simples 
Le programme repose sur une structure statique (tableau de taille fixe) et une gestion dynamique via un compteur.
________________________________________
2. Structure de données utilisée
2.1 Type de base (enregistrement)
Chaque mot est représenté par une structure contenant deux champs :
TMot = RECORD
  mot_fr : STRING[30];
  mot_en : STRING[30];
END;
Explication :
•	mot_fr : contient le mot en français 
•	mot_en : contient la traduction anglaise 
Chaque élément du dictionnaire est donc une paire de mots.
________________________________________
2.2 Tableau du dictionnaire
CONST
  MAX_MOTS = 15;

TYPE
  TDictionnaire = ARRAY[1..MAX_MOTS] OF TMot;
Explication :
•	Le dictionnaire est un tableau de taille fixe (15 éléments) 
•	Chaque case contient un TMot 
•	Le tableau est maintenu trié par ordre alphabétique des mots français 
________________________________________
3. Variables globales (programme principal)
VAR
  Dictionnaire : TDictionnaire;
  NbMots : INTEGER;
  choix : INTEGER;
  motFR, motEN : STRING;
  continuer : CHAR;
Rôle détaillé des variables :
•	Dictionnaire : stocke tous les mots et leurs traductions 
•	NbMots : indique le nombre actuel de mots présents dans le dictionnaire (élément très important pour gérer le tableau) 
•	choix : stocke le choix de l’utilisateur dans le menu 
•	motFR : variable temporaire pour saisir ou manipuler un mot français 
•	motEN : variable temporaire pour la traduction anglaise 
•	continuer : permet de contrôler la boucle principale du programme 
________________________________________
4. Explication des sous-programmes
________________________________________
4.1 EnMinuscule
Rôle
Convertir une chaîne en minuscules pour rendre les comparaisons insensibles à la casse.
Utilité dans le programme
Permet de comparer correctement :
•	"Maison" = "maison" 
Fonctionnement
•	Parcourt chaque caractère 
•	Convertit les majuscules en minuscules 
________________________________________
4.2 InitialiserDictionnaire
Rôle
Initialiser le dictionnaire au démarrage du programme.
Action
•	NbMots ← 0 
Effet
Le dictionnaire est vide au lancement.
________________________________________
4.3 RechercherPosition
Rôle
Trouver :
•	soit la position d’un mot existant 
•	soit la position où insérer un nouveau mot 
Méthode utilisée
Recherche dichotomique (car le tableau est trié)
Fonctionnement concret
•	Compare le mot recherché avec le mot du milieu 
•	Réduit la zone de recherche à gauche ou à droite 
•	Retourne : 
o	la position si trouvé 
o	sinon la position d’insertion 
Importance
Ce sous-programme garantit que le dictionnaire reste trié.
________________________________________
4.4 InsererMot
Rôle
Ajouter un nouveau mot dans le dictionnaire.
Variables utilisées
•	motFR : mot à insérer 
•	motEN : traduction 
•	pos : position d’insertion 
Étapes :
1.	Vérifier si le dictionnaire est plein (NbMots = MAX_MOTS) 
2.	Trouver la position correcte avec RechercherPosition 
3.	Vérifier si le mot existe déjà 
4.	Décaler les éléments vers la droite 
5.	Insérer le nouveau mot 
6.	Incrémenter NbMots 
________________________________________
4.5 SupprimerMot
Rôle
Supprimer un mot du dictionnaire (français ou anglais).
Variables utilisées
•	mot : mot recherché 
•	typeRecherche : 1 = français, 2 = anglais 
•	trouve : position du mot 
•	rep : confirmation utilisateur 
Étapes :
1.	Parcourir le tableau pour trouver le mot 
2.	Demander confirmation 
3.	Décaler les éléments vers la gauche 
4.	Décrémenter NbMots 
________________________________________
4.6 ModifierMot
Rôle
Modifier une entrée existante.
Variables utilisées
•	ancienMot : mot à modifier 
•	nouveauMot : nouveau mot 
•	pos : position dans le tableau 
•	choixModif : type de modification 
Fonctionnement :
1.	Rechercher le mot français 
2.	Proposer deux choix : 
o	modifier le mot français 
o	modifier la traduction anglaise 
Cas important :
•	Si le mot français est modifié : 
o	suppression de l’ancien mot 
o	réinsertion pour garder l’ordre 
________________________________________
4.7 AfficherDictionnaire
Rôle
Afficher tous les mots stockés.
Variables utilisées
•	i : compteur de boucle 
Fonctionnement :
•	Parcours de 1 à NbMots 
•	Affichage des paires mot/traduction 
________________________________________
4.8 RechercherMot
Rôle
Rechercher un mot exact.
Fonctionnement :
•	Si recherche française → recherche dichotomique 
•	Si recherche anglaise → parcours séquentiel 
•	Affichage si trouvé 
________________________________________
4.9 RecherchePartielle
Rôle
Rechercher des mots commençant par une chaîne donnée.
Variables utilisées
•	s : chaîne recherchée 
•	i : boucle 
•	trouve : indicateur de résultat 
Fonctionnement :
•	comparer le début des mots avec la chaîne saisie 
•	afficher tous les résultats correspondants 
________________________________________
4.10 AfficherStatistiques
Rôle
Afficher des informations sur le contenu du dictionnaire.
Variables utilisées
•	plusFR : mot français le plus long 
•	plusEN : mot anglais le plus long 
•	i : boucle 
Fonctionnement :
•	parcourir le tableau 
•	comparer les longueurs des mots 
•	afficher les plus longs mots 
•	afficher le nombre total de mots 
________________________________________
4.11 AfficherMenu
Rôle
Afficher les options disponibles à l’utilisateur.
Fonctionnement
•	affichage des choix de 1 à 8 
•	lecture du choix utilisateur dans le programme principal 
________________________________________
5. Programme principal
Rôle général
Le programme principal orchestre toutes les fonctionnalités.
________________________________________
Variables utilisées :
•	choix : choix du menu 
•	motFR, motEN : saisies utilisateur 
•	continuer : contrôle de la boucle 
________________________________________
Fonctionnement global :
1.	Initialisation du dictionnaire 
2.	Affichage du menu 
3.	Lecture du choix utilisateur 
4.	Exécution du sous-programme correspondant 
5.	Demande de continuation 
6.	Répétition jusqu’à sortie 
________________________________________
Logique générale :
•	Le programme tourne en boucle 
•	Chaque choix appelle un sous-programme précis 
•	Toutes les opérations modifient ou consultent le tableau Dictionnaire 
________________________________________
6. Conclusion
Ce programme permet de gérer un dictionnaire bilingue structuré sous forme de tableau d’enregistrements.
L’utilisation d’un tableau trié combiné à une recherche dichotomique permet d’optimiser les opérations de recherche et d’insertion.
La modularité du programme (sous-programmes indépendants) rend le code clair, maintenable et facilement extensible.
La principale limite est la taille fixe du dictionnaire (MAX_MOTS = 15), qui restreint la capacité de stockage.

