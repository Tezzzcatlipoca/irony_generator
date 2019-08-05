# Ejemplos de ironías

# "Para que puedan morir saludables" - Saramago
# "Los números son mejores que las personas [...], 
# uno siempre puede confiar en ellos."
# "No se moleste, ya lo mataron" -G. Márquez
# "Cuando despierte recuérdame que me voy a casar con ella."
# "No le quedaba ni un baúl de consolación para guardar tanto dinero."
# "Estimó que habían puesto adornos florales por un valor igual al de catorce
# entierros de primera clase."
# "Muchos sabían que en la inconsciencia de la parranda le propuse a Mercedes
# Barcha que se casara conmigo, cuando apenas había terminado la escuela 
# primaria, tal como ella misma me lo recordó cuando nos casamos catorce
# años después." 
# "¿Y se puede saber por qué quieren matarlo tan temprano?"
    # Important vs Unimportant
# "Y le tenía tanto respeto que no volvió a acostarse con nadie si él 
# estaba presente."
# Sobre la autopsia: "fue como si hubiéramos vuelto a matarlo después de muerto"
# "Comer sin medida fue su único modo de llorar."
     # Positivo vs Negativo: Positivo - depresión - Negativo
# Mujeres de alquiler
# Sonrisa comercial
# "De tanto ser antiguo se había vuelto a poner de moda"
    # Antónimos, palabra en común: vintage
# Había que traer el alma muy bien puesta.


# Generador de Ironías BASADO EN WIKIPEDIA
term<-"coffee"

# Empleamos la biblioteca para leer códigos web
library(rvest)
library(dplyr)
library(urltools)

# Se manda al buscador la línea para encontrar artículos de Wikipedia
# que contengan las palabras.

contenidos<-paste0("site%3Aen.wikipedia.org+",term)
url<-URLencode(paste0("https://www.google.com/search?q=", contenidos))# palabra1+palabra2

# Aquí se reciben varios resultados 
webpage <- read_html(url)

# Inicializar cuadro final
resultados<-data.frame()

for (ciclo in 1:10) {
    # Empleamos el complemeto SelectorGadget de Chrome para identificar en código CSS que necesitamos. Identificamos su parte del código correspondiente.
    # Headers de cada resultado de búsqueda
    titulo_data<- webpage %>% html_nodes('h3.r') %>% html_text()
    # URLs de cada resultado de búsqueda
    url_data <- webpage %>% html_nodes('cite') %>% html_text()
    # Descripciones de cada resultado de búsqueda
    descr_data<-webpage %>% html_nodes("span.st") %>% html_text()
    # URL de la siguiente pantalla
    siguiente<-webpage %>% html_node('a:contains("Siguiente")')
    siguiente_data <- html_attr(siguiente,"href")
    
    # En algunos casos se muestran más títulos que resultados (Imágenes de wikipedia)
    # Hay que eliminarlos
    if(length(titulo_data)>length(url_data)){
      # Crear línea de expresión regular (corrigiendo los '+' por '\+')
      terminos<-gsub("\\+","\\\\+",term)
      linea<-paste0("^Im(.+)",terminos,"$")
      cuales_coinc<-!grepl(linea,titulo_data)
      titulos_trasq<-titulo_data[cuales_coinc]
    } else {
      titulos_trasq<-titulo_data
    }
    
    # Crear cuadro
    provisional<-data.frame(titulo=titulos_trasq,descr=descr_data,url=url_data,pantalla=ciclo)

    # Concatenar resultados
    resultados<-rbind(resultados,provisional)
    
    # Traer nueva página
    nuevo_url<-paste0("https://www.google.com",siguiente_data)
    # Tiempo de espera para evitar bloqueos
    Sys.sleep(3)
    webpage <- read_html(nuevo_url)
}
# Algunos incluyen la palabra en el título: estos no sirven
# Al final de la lista hay que llamar a la siguiente página

# --------------------- Wikipedia ---------------------------
url_wiki<-URLencode("https://en.wikipedia.org/wiki/Cortado")
wikipage<-read_html(url_wiki)
intro_texto<-wikipage %>% html_nodes("#mw-content-text") %>% html_text()
# Devuelve TODO el texto de la página. La introducción termina con la tabla
# de "Contents", se puede identificar cada párrafo por el /n final
