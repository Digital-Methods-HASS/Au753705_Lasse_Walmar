###   GETTING STARTED WITH LEAFLET

# Try to work through down this script, observing what happens in the plotting pane.

# Review favorite backgrounds in:
# https://leaflet-extras.github.io/leaflet-providers/preview/
# beware that some need extra options specified

# Text written by (S)
# We went to the website “https://leaflet-extras.github.io/leaflet-providers/preview/”, 
# with the different available background-layouts, where we tried different backgrounds 
# and ended up using the “Esri.WorldPhysical” and “Esri.WorldImagery” for our assignment. 
# We experienced that only “Esri-backgrounds” where available for our assignment.

# To install Leaflet package, run this command at your R prompt:
install.packages("leaflet")

# Code and text written by (L)
# This code “install.packages("leaflet")“ instals “leaflet” into our R file,
# making certain bits of code available.

# We will also need this widget to make pretty maps:
install.packages("htmlwidget")


# Code and text written by (B)
# This code “install.packages("htmlwidget")” instals “htmlwidget” into our R file,
# making it possible to create maps.

# Activate the libraries
library(leaflet)
library(htmlwidgets)

# Code and text written by (L) 
# These bits of code “library(leaflet)” and “library(htmlwidgets)” activates the libraries,
# making it possible to both create maps using the code given by “leaflet”, 
# and make client side interactions using the code given by “htmlwidget”,
# which in this specific case allows us to see our map in the corner in R.












########## Example with Markers on a map of Europe


# First, create labels for your points
popup = c("Robin", "Jakub", "Jannes")

# You create a Leaflet map with these basic steps: you need to run the whole chain of course
leaflet() %>%                                 # create a map widget by calling the library
  addProviderTiles("Esri.WorldPhysical") %>%  # add Esri World Physical map tiles
  addAwesomeMarkers(lng = c(-3, 23, 11),      # add layers, specified with longitude for 3 points
                    lat = c(52, 53, 49),      # and latitude for 3 points
                    popup = popup)            # specify labels, which will appear if you click on the point in the map

# Code and text written by (S)
# The code “popup = c("Robin", "Jakub", "Jannes")” creates labels for our three points 
# “Robin, Jakub, and Jannes”, which creates coordinates attached to the points later used 
#  in the following “leaflet” code.
# The “leaflet” code creates a map with the maptexture of "Esri.WorldPhysical"
# wherafter the code "addAwesomeMarkers" adds markers at longitudes and latitudes.
# These are the "lng = c(x1, y1, z1) and lat = c(x2, y2, z2)", where the x1 and x2 are the 
# coordinates for Robin, y1 and y2 are for Jakub, and z1 and z2 are for Jannes.
# The coordinates are as follows, Robin (-3, 52), Jakub (23, 53), Jannes (11, 49), 
# which matches what the map shows, Robin in Great Britain, Jakub in Eastern Europe, 
# and Jannes is in Central Europe.

### Let's look at Sydney with setView() function in Leaflet
leaflet() %>%
  addTiles() %>%                              # add default OpenStreetMap map tiles
  addProviderTiles("Esri.WorldImagery",       # add custom Esri World Physical map tiles
                   options = providerTileOptions(opacity=0.5)) %>%     # make the Esri tile transparent
  setView(lng = 151.005006, lat = -33.9767231, zoom = 10)              # set the location of the map 

# Code and text written by (B)
# The code “setView(lng = x, lat = y, zoom = 10) determines a location on our map (x,y),
# while “zoom =10” determines how close we are to the specific point in terms of scale ratio.
# “lng” is longitude and “lat” is latitude, which for our specific example is “lng = 151.005006, lat = -33.9767231”, which is a place located in Sydney, Australia.







# Now let's refocus on Europe again
leaflet() %>% 
  addTiles() %>% 
  setView( lng = 2.34, lat = 48.85, zoom = 5 ) %>%  # let's use setView to navigate to our area
  addProviderTiles("Esri.WorldPhysical", group = "Physical") %>% 
  addProviderTiles("Esri.WorldImagery", group = "Aerial") %>% 
  addProviderTiles("MtbMap", group = "Geo") %>% 
  
  addLayersControl(                                 # we are adding layers control to the maps
    baseGroups = c("Geo","Aerial", "Physical"),
    options = layersControlOptions(collapsed = T))

# Code and text written by (B)
# Again the setView(lng = 2.34, lat = 48.85, zoom = 5) determines a location on the maps,
# which now is located in Western Europe. We then add three separate maps: 
# "addProviderTiles ("Esri.WorldPhysical, group = "Physical") %>%
# "addProviderTiles ("Esri.WorldImagery, group = Aerial) %>%
# "addProviderTiles ("MtbMap", group = "Geo")",
# which add three map-layouts (Physical, Aerial, Geo) for our location in Western Europe.
# Afterwards the code "addLayersControl (
#                     	baseGroups = c("Geo","Aerial", "Physical"),
#                     	options = layersControlOptions(collapsed =T))"
# makes a menu in the right corner of the map, where the three map-layouts are available,
# and when your mouse hovers over the menu, it opens the three available map-layouts.






# click the box in topright corner in your Viewer 
# to select between different background layers


########## SYDNEY HARBOUR DISPLAY WITH LAYERS
# Let's create a more complicated map 

# Set the location and zoom level
leaflet() %>% 
  setView(151.2339084, -33.85089, zoom = 13) %>%
  addTiles()  # checking I am in the right area

# Code and text written by (S)
# Again we choose a location and zoom “setView(151.2339084, -33.85089, zoom = 13)”,
# which gives us a location in Sydney with a bigger zoom on the location.




# Bring in a choice of esri background layers  

# Create a basic basemap
l_aus <- leaflet() %>%   # assign the base location to an object
  setView(151.2339084, -33.85089, zoom = 13)

# Code and text written by (L)
# This takes the code mentioned above and attaches it to the item “l_aus”,
# which it does through the assignment operator “<-”.

# Now, prepare to select backgrounds
esri <- grep("^Esri", providers, value = TRUE)

# Code and text written by (B)
# This takes the available “Esri” map-layouts and attaches them to the item “esri”.

# Select backgrounds from among provider tiles. To view them the options, 
# go to https://leaflet-extras.github.io/leaflet-providers/preview/
for (provider in esri) {l_aus <- l_aus %>% addProviderTiles(provider, group = provider)}


















### Map of Sydney, NSW, Australia
# We make a layered map out of the components above and write it to 
# an object called AUSmap
AUSmap <- l_aus %>%
  addLayersControl(baseGroups = names(esri),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
             position = "bottomright") %>%
  addMeasure(
    position = "bottomleft",
    primaryLengthUnit = "meters",
    primaryAreaUnit = "sqmeters",
    activeColor = "#3D535D",
    completedColor = "#7D4479") %>% 
  htmlwidgets::onRender("
                        function(el, x) {
                        var myMap = this;
                        myMap.on('baselayerchange',
                        function (e) {
                        myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                        })
                        }") %>% 
  addControl("", position = "topright")

# Code and text written by (B)
# This code attaches the item “l_aus”, which is a leaflet map, to the item “AUSmap”, 
# meanwhile all the other bits of code get attached to the AUSmap.
# The code “addLayersControl(baseGroups = names(esri),” determines that the maps,
# that we can chose between, are in the “esri” group, which show the esri map-names.
# The code “options = layerControlOptions(collapsed = FALSE))” determines that the menu,
# where you change between the “esri” maps, doesn’t collapse when you mouse doesn’t       # hover over it.
# The code “addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,” adds a minimap with a  
# larger perspective of the location, where you are able to see the primary map’s location.
# The code “addMeasure(
#    position = "bottomleft",
#    primaryLengthUnit = "meters",
#    primaryAreaUnit = "sqmeters",
#    activeColor = "#3D535D",
#    completedColor = "#7D4479")”
# Adds a measuring tool in the bottom left corner, which can be used to measure distances
# between several points on the map. And you can even measure the area in square meters.
# The measuring tool will have the color “activeColor = "#3D535D",” when active measuring, 
# while it gets the color “completedColor = "#7D4479")” when we are done measuring.



# run this to see your product
AUSmap

########## SAVE THE FINAL PRODUCT

# Save map as a html document (optional, replacement of pushing the export button)
# only works in root

saveWidget(AUSmap, "AUSmap.html", selfcontained = TRUE)

#Code and text written by (S)
# The code “saveWidget(AUSmap, "AUSmap.html", selfcontained = TRUE)” is available 
# from “htmlwidget”, which allow us to save the AUSmap as a html-file and thereby share
# AUSmap on our device with other devices without the need to share the R file.









###################################  YOUR TASK NUMBER ONE


# Task 1: Create a Danish equivalent of AUSmap with esri layers, 
# but call it DANmap
l_dan <- leaflet() %>%   # assign the base location to an object
  setView(10.2042896,56.1517, zoom = 13)

# Code and text written by (S)
# The code “l_dan <- leaflet() %>%
#                     setView(10.2042896,56.1517, zoom = 13)”
# takes a leaflet code and attaches it to the “l_dan” item, which is coordinates showing 
# the danish location “Skt. Knuds Skole” in Aarhus, Denmark.

# Now, prepare to select backgrounds
esri <- grep("^Esri", providers, value = TRUE)

# Code and text written by (L)
# The code “esri <- grep("^Esri", providers, value = TRUE)” does the same as earlier code
# making an “esri” item to be used in the following making of a specific DANmap.

# Select backgrounds from among provider tiles. To view them the options, 
# go to https://leaflet-extras.github.io/leaflet-providers/preview/
for (provider in esri) {
  l_dan <- l_dan %>% addProviderTiles(provider, group = provider)}

# Code and text written by (B)
# The code “l_dan <- l_dan %>% addProviderTiles(provider, group = provider)}”
# adds provider tiles onto the item “l_dan”: “leaflet() %>%
#                                                                        setview(10.2042896, 56.1517, zoom =13)”, 
# which we have already used earlier in the AUSmap task.
# The final results will be   “leaflet() %>%
#	                                     setview(10.2042896, 56.1517, zoom =13) %>%
#                                               addProviderTiles(provider, group = provider)}”
# The item “l_dan” replaces the first leaflet string of code in the following DANmap task, 
# which means that when creating the DANmap, it is not necessary to write the leaflet string,
# because the “i_dan” item already has a “setview” code and “addProviderTiles” code in it.


DANmap <- l_dan %>%
  addLayersControl(baseGroups = names(esri),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
             position = "bottomright") %>%
  addMeasure(
    position = "bottomleft",
    primaryLengthUnit = "meters",
    primaryAreaUnit = "sqmeters",
    activeColor = "#3D535D",
    completedColor = "#7D4479") %>% 
  htmlwidgets::onRender("
                        function(el, x) {
                        var myMap = this;
                        myMap.on('baselayerchange',
                        function (e) {
                        myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                        })
                        }") %>% 
  addControl("", position = "topright")


# Code and text written by (S)
# The code above has been mostly reused from the AUSmap code written earlier.
# The only difference was the replacing of the coordinates, the addition of provider tiles, 
# and the fact that writing the leaflet string of code was not necessary, as the item “l_dan” 
# replaced it. 












########## ADD DATA TO LEAFLET

# In this section you will manually create machine-readable spatial
# data from GoogleMaps: 

### First, go to https://bit.ly/CreateCoordinates1
### Enter the coordinates of your favorite leisure places in Denmark 
# extracting them from the URL in googlemaps, adding name and type of monument.
# Remember to copy the coordinates as a string, as just two decimal numbers separated by comma. 

# Caveats: Do NOT edit the grey columns! They populate automatically!

### Second, read the sheet into R. You will need gmail login information. 
# watch the console, it may ask you to authenticate or put in the number 
# that corresponds to the account you wish to use.


# Libraries
library(tidyverse)
library(googlesheets4)
library(leaflet)

# Code and text written by (L)
# The libraries “library(tidyverse)”, “library(googlesheets4)”, and “library(leaflet)” are activated # to make the integration of google sheets data available and usable in our DANmap.


# Read in a Google sheet
gs4_deauth()
Places<-read_sheet("https://docs.google.com/spreadsheets/d/1PlxsPElZML8LZKyXbqdAYeQCDIvDps2McZx1cTVWSzI/edit#gid=124710918",
                   col_types = "cccnncnc", range="DigitalMethods")

# Code and text written by (S)
# The code above makes it possible for the R project to read the data from the specific 
# google sheet linked above, and loads the data onto the “places” item.

glimpse(places)

# Code and text written by (B)
# The code “glimpse(places) was simply added to check if everything looked correct.






# load the coordinates in the map and check: are any points missing? Why?
DANmap<-leaflet() %>%
  addTiles() %>%
  addMarkers(lng = places$Longitude,
             lat = places$Latitude,
             popup = paste("Place", places$Place_Name, "<br>",
                           "Description:", places$Description, "<br>",
                           "Notes:", places$Notes, "<br>",
                           "Type:", places$Type),
             clusterOptions = markerClusterOptions())

saveWidget(DANmap, "DANmap.html", selfcontained = TRUE)

# Code and text written by (L)
# The code takes everything that has been added to DANmap and adds a string of code, 
# which is longitude and latitude from the item “places”, which is the google sheets data,
# through the code “lng = places$Longitude” and “lat = places$Latitude”.
# Afterwards the “popup = places$Place_Name” code adds names that will “popup” once the # marker clicks on the points, and all “places$” code draws the data from the google sheets.
# It then adds the “clusterOptions” code, which cluster many points together if the map is
# sufficiently zoomed out. 

#########################################################


# Task 2: Read in the googlesheet data you and your colleagues 
# populated with data into the DANmap object you created in Task 1.

# Text written by (S + L)
# This is done by creating an object with the google sheet data, and putting it on a map, 
# this was a joint effort.

# Task 3: Can you cluster the points in Leaflet? Google "clustering options in Leaflet"

# Text written by (member)
# The code "clusterOptions = markerClusterOptions()” makes it so that the points are 
# getting clustered if the view is zoomed sufficiently out.
# the code was found by Benjamin.

# Task 4: Look at the map and consider what it is good for and what not.

# Text written by (S)
# If you have a map with a large database of points, the clustering of points into areas can 
# help the map not to be cluttered and thereby easier to search through and understand.

# Task 5: Find out how to display notes and classifications in the map.

# Text written by (L)
# This has been retroactively added to the DANmap part of the document.

