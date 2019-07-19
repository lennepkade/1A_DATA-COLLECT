Un Système d'Information Géographique (SIG) est, comme son nom l'indique, un système d'information dédié à l'usage de données spatiales. Il est aussi bien utilisé pour de la consultation, modification et création de données géographiques, mais aussi pour de l'analyse spatiale. 

Le SIG est l'outil indispensable pour réaliser des cartes. Pour ce faire, deux grands types de données sont utilisés par ces logiciels :  

- vecteur (polygones, points et lignes)
- raster (images)

![Différence entre vecteur (à gauche) et raster (à droite)](figures/icon_vector-raster.jpg)

Ces données ont obligatoirement :

1. un système de coordonnées (eg. Lambert-93 EPSG:2154 pour la France, Mercator EPSG:4326 pour le monde)
2. des coordonnées issues du précédent système (pour localiser la latitude et la longitude d'un point)

L'objectif de ce cours est de prendre en main un SIG comme QGIS. Pour ce faire, nous allons utiliser des données de différents types (point comme le siège de votre exploitation agricole, polygone comme une parcelle agricole).
Il s'agit de se familiariser avec un tel outil en adoptant les bonnes pratiques du domaine.

# Créer un nouveau projet

Quand vous lancez QGIS, commencez par créer un nouveau projet : 
`Projet > Nouveau`.

## Choisir une projection adaptée

Par défaut votre projet utilise la projection UTM (Transverse Universelle de Mercator), nom de code EPSG:4326.

Dans QGIS, la projection du projet est toujours affichée en bas à droite de la fenêtre de QGIS, vous pouvez donc vérifier votre projection : 

![SRC actuel dans QGIS : EPSG:4326](figures/EPSG4326.png)

Pour regarder les propriétés de votre projet : `Projet > Propriétés`.

Dans l'onglet `SCR` (Système de Coordonnées de Référence), recherchez  `2154`, soit le code de la projection Lambert-93 qui est obligatoire en France pour les données publiques. 
Si vous voulez en savoir plus sur cette projection, une page Wikipedia est dédié à cette projection : [https://fr.wikipedia.org/wiki/Projection_conique_conforme_de_Lambert](https://fr.wikipedia.org/wiki/Projection_conique_conforme_de_Lambert).

Une fois la projection Lambert-93 EPSG:2154 validée, vous pouvez à nouveau vérifier en bas à droite de la fenêtre de QGIS :

![SRC actuel dans QGIS : EPSG:2154](figures/EPSG2154.png)

Dans l'onglet `Général`, pensez à donner un nom à votre projet, il apparaîtra à côté du nom de la fenêtre QGIS.

Une fois ces manipulations effectuées, vous pouvez sauvegarder votre projet dans votre dossier de travail (ce dossier contiendra également vos données vecteur/raster)

`Projet > Enregistrer sous...`


# Charger des données

L'Institut Géographique National (IGN) est le plus grand producteur français de données spatiales. Il fournit notamment les limites administratives (communes, départements, régions), les fleuves, mais aussi des données comme le Registre Parcellaire Graphique (RPG) qui sert de référence pour l'attribution des aides de la politique agricole commune (PAC).

Liste indicative des quelques fournisseurs de données :

| Fournisseur        | Type           | Site  |
| ------------- |-------------| -----|
| IGN      | raster/vecteur | [www.ign.fr](https://www.ign.fr) |
| Toulouse      | vecteur |   [data.toulouse-metropole.fr](https://data.toulouse-metropole.fr/) |
| BRGM | raster/vecteur | 	[www.brgm.fr](https://www.brgm.fr) |
| OpenStreetMap | raster/vecteur      | [www.openstreetmap.org](https://www.openstreetmap.org/) |


## Localiser votre exploitation

Le géoportail est l'équivalent IGN de Google Maps : [www.geoportail.gouv.fr/](https://www.geoportail.gouv.fr/)

Commencez par rechercher votre exploitation. N'hésitez pas à choisir comme fond de cartes les photographies aériennes. Une fois votre exploitation localisée, cliquez sur la molette à droite de l'écran, puis sur `Annoter la carte`, et choisissez votre système de référence (Lambert 93). Les coordonnées X et Y correspondent à la position du curseur sur la carte.

![Annoter la carte pour créer un point votre exploitation](figures/geoportail_annoter.png)

![Placez votre point et exportez le résultat](figures/geoportail_ajoutpoint.png)

Le site Géoportail créera pour vous un fichier de type `kml` qu'il sera possible de charger dans QGIS.

## Ajouter votre exploitation dans QGIS

Dans QGIS 3, il n'y a plus qu'un bouton pour ouvrir n'importe quel type de couche.

![Charger une couche dans QGIS](figures/QGIS_charger.png)

Une fois la fenêtre ouverte, sélectionnez l'onglet 'Vecteur' et ajoutez votre fichier obtenu via le géoportail.

Une autre méthode consiste à glisser/déposer votre fichier `kml` dans la fenêtre QGIS.

Une nouvelle couche est ainsi ajoutée à votre carte.  Vous pouvez faire un clic droit sur le nom de la couche dans la fenêtre `Couches` et regarder ses propriétés. Dans `Information` vous verrez que la projection est de type `EPSG:4326`.

Pour changer cela, allez dans la Boîte à outils de traitements en bas à gauche de QGIS (si la boîte n'est pas ouverte, cliquez sur `Traitement>Boîte à outils`), et recherchez l'algorithme `Reprojeter une couche`. Le SRC cible devra être `EPSG:2154` comme celui de votre projet.

![Enregistre votre nouvelle couche au format gpkg](figures/QGIS_gpkg.png)

Enregistrez votre nouvelle couche sous un format de type geopackage. Une fois enregistrée, votre nouveau fichier sera chargé automatiquement dans QGIS. Vous pouvez supprimer de la liste des couches l'ancien fichier.

## Ajouter le nom de votre exploitation

Pour afficher sur la carte le nom de votre exploitation, il va falloir modifier votre fichier vectoriel.

Faites un clic droit sur la couche qui contient votre exploitation et faites `Ouvrir la table d'attributs`. Par défaut vous ne pouvez pas modifier le contenu des champs. Pour cela, il faut d'abord cliquer sur le petit crayon en haut à gauche de la fenêtre, puis vous pouvez ajouter le nom de votre exploitation dans la colonne `Name`.

Une fois le nom ajouté, pensez à recliquer sur le petit crayon pour terminer l'édition.

## Modifier l'affichage de votre exploitation
### Afficher le nom

**Objectif : Faire afficher le nom de l'exploitation sur la carte.**
Faites un clic droit sur la couche, puis `Propriétés` puis dans l'onglet `Étiquettes` choisissez Étiqueter avec le champ `Name`. Le nom de l'exploitation doit désormais apparaître sur la carte.

### Changer le type d'icône

**Objectif : Changer le symbole simple (point) par un symbole SVG.**

Toujours dans la fenêtre `Propriétés`, l'onglet `Symbologie` vous permet de changer tout ce qui a trait à l'affichage de vos données. 

Cliquer sur `Symbole Simple` et changer à `Symbole SVG`. De nombreux symboles sont disponibles, libre à vous de choisir celui que vous préférez. Il est aussi possible d'importer des fichiers SVG.

![Exploitation avec étiquette et icône SVG](figures/QGIS_labelicon.png)


<!-- Partie supprimée car trop lourde (~700mo que pour l'Occitanie, on numérisera les parcelles à la mano!)
# Télécharger une donnée spatiale

Objectif : **Télécharger la carte géologique** et la faire apparaître avec vos parcelles dans QGIS.


#### RPG 2017 (IGN)

Le flux WMS de l'IGN nécessite une clé personnelle, ce qui signifie que vous devez avoir un compte IGN afin de consulter le fond de carte depuis QGIS.      
Cependant, pour télécharger les données au format vecteur, aucune identification n'est nécessaire.

Rendez-vous sur la page du RPG pour télécharger celui de votre région : [http://professionnels.ign.fr/rpg](http://professionnels.ign.fr/rpg).
- Pour l'Occitanie : ftp://RPG_ext:quoojaicaiqu6ahD@ftp3.ign.fr/RPG_2-0__SHP_LAMB93_R76-2017_2017-01-01.7z.001.

Dézippez le fichier téléchargé dans votre dossier de travail, et glissez/déposez le fichier de type _.shp_ dans l'interface QGIS.


## Gérer l'affichage et la symbologie

La symbologie est le fait de représenter les données par des symboles. Par exemple, afin de différencier les différentes couches géologiques, vous allez
Afin de mieux comprendre
Mettre 
clic droit
Propriété
Symbologie
-->

# Visualiser des données distantes

Les données distantes sont disponibles la plupart du temps en plusieurs formats : WMS (Web Map Service, retourne une image qui peut être composée à partir de plusieurs sources), WFS (Web Feature Service, retourne les données vecteur) ou plus rare le WCS (Web Coverage Service, données raster).


## Afficher les unités géologiques

**Objectif : Ajouter le WMS du BRGM sur la géologie.**

`Ajouter une nouvelle couche > WMS/WMTS > Nouveau`
Et ajouter l'adresse de la carte géologique 1/1 000 000 France Métropole (BRGM) : [http://mapsref.brgm.fr/wxs/1GG/BRGM_1M_INSPIRE_geolUnits_geolFaults?language=fr&](http://mapsref.brgm.fr/wxs/1GG/BRGM_1M_INSPIRE_geolUnits_geolFaults?language=fr&)

Pour avoir tout le flux du BRGM (WFS/WMS):
[http://geoservices.brgm.fr/geologie](http://geoservices.brgm.fr/geologie)

![Aperçu de l'explotation avec le WMS des couches géologiques en arrière plan](figures/QGIS_exploitationGeologique.png)

Pour en savoir plus sur le type de géologie, vous pouvez utiliser l'outil d'identification (l'icône du curseur qui pointe sur un petit _i_) et cliquer sur la couleur de l'unité géologique.

Si vous rencontrez des problèmes d'accès au flux WMS, vous pouvez télécharger la donnée au format `shp` sur le site du BRGM : [http://geoservices.brgm.fr/geol1M/fr/download/geol_1M_fr_surface.zip](http://geoservices.brgm.fr/geol1M/fr/download/geol_1M_fr_surface.zip).

Si les liens ne sont pas accessibles, le fichier `geol_1M_fr_surface.zip` est disponible dans le dossier `data` du TD.

## Afficher un fond OpenStreetMap ou Google Earth 

**Objectif : Ajouter des fonds de carte dans QGIS**.

Par défaut QGIS n'intègre pas des fournisseurs de tuiles (Google Maps, Bing, OpenStreetMap), et pourtant c'est bien pratique !

Pour palier à ce défaut, il vous suffira de copier/coller les lignes du fichier suivant dans la console python de QGIS (`Ctrl+Alt+P`) :  [**https://git.io/fjMJq**](https://raw.githubusercontent.com/klakar/QGIS_resources/master/collections/Geosupportsystem/python/qgis_basemaps.py).

Dans le panneau explorateur sur la gauche de QGIS, vous aurez désormais accès à des dizaines de fournisseurs de tuiles dans la partie `XYZ Tiles`. Double-cliquez sur `Google Satellite` pour avoir uniquement une photo aérienne en fond.

# Créer un vecteur

**Objectif : Dessiner votre parcelle**.

Vérifier que dans le menu `Vue > Barre d'outils` que les deux `Barre d'outils de numérisation` et `Barre d'outils de numérisation avancée` soient cochées.

Ensuite :
- Créer un fichier vectoriel de type polygone (au format geopackage)
    - Menu `Couche > Créer une couche > Nouvelle couche GeoPackage`
    - Choisissez bien le type de géométrie `polygone` et la projection `EPSG:2154`.
- Ajouter un champ de type `Donnée texte` et nommez-le `description`.
- Une fois la couche créée, cliquez sur le petit crayon en haut à gauche dans le menu pour commencer à dessiner votre parcelle.
- Il suffira ensuite d'ajouter une entité polygonale et de dessiner la parcelle.

![Créer une entité polygonale](figures/QGIS_vectorpoly.png)

À chaque clic gauche un nouveau point de votre polygone est ajouté. Pour terminer votre polygone il suffit de faire un clic droit.

Pour se déplacer pendant la vectorisation, vous pouvez soit dézoomer (avec la molette de la souris) soit changer d'endroit en maintenant la touche espace tout en déplaçant votre curseur.

# Géoréférencer une image

**Objectif : Ajouter à votre carte une image obtenue à partir des photos historiques de l'IGN.**

Accéder au site [remonterletemps.ign.fr](https://remonterletemps.ign.fr/) et télécharger une photo aérienne couleur de votre exploitation. Une fois cette donnée téléchargée, nous allons la géoréférencer pour l'utiliser en fond de carte sur QGIS.

1. Activer le plugin dans le menu `Extension > Installer/Gérer > Activer Géoréférenceur GDAL`
2. Vous devriez trouver désormais dans le menu `Raster > Géoréférencer`
3. Suivre la procédure : [https://docs.qgis.org/2.8/fr/docs/training_manual/forestry/map_georeferencing.html](https://docs.qgis.org/2.8/fr/docs/training_manual/forestry/map_georeferencing.html)