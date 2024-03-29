# Ejemplos de iron�as

# "Para que puedan morir saludables" - Saramago
# "Los n�meros son mejores que las personas [...], 
# uno siempre puede confiar en ellos."
# "No se moleste, ya lo mataron" -G. M�rquez
# "Cuando despierte recu�rdame que me voy a casar con ella."
# "No le quedaba ni un ba�l de consolaci�n para guardar tanto dinero."
# "Estim� que hab�an puesto adornos florales por un valor igual al de catorce
# entierros de primera clase."
# "Muchos sab�an que en la inconsciencia de la parranda le propuse a Mercedes
# Barcha que se casara conmigo, cuando apenas hab�a terminado la escuela 
# primaria, tal como ella misma me lo record� cuando nos casamos catorce
# a�os despu�s." 
# "�Y se puede saber por qu� quieren matarlo tan temprano?"
    # Important vs Unimportant
# "Y le ten�a tanto respeto que no volvi� a acostarse con nadie si �l 
# estaba presente."
# Sobre la autopsia: "fue como si hubi�ramos vuelto a matarlo despu�s de muerto"
# "Comer sin medida fue su �nico modo de llorar."
     # Positivo vs Negativo: Positivo - depresi�n - Negativo
# Mujeres de alquiler
# Sonrisa comercial
# "De tanto ser antiguo se hab�a vuelto a poner de moda"
    # Ant�nimos, palabra en com�n: vintage
# Hab�a que traer el alma muy bien puesta.


# Generador de Iron�as BASADO EN WIKIPEDIA
term<-"coffee"

# Empleamos la biblioteca para leer c�digos web
library(rvest)
library(dplyr)
library(urltools)

# Se manda al buscador la l�nea para encontrar art�culos de Wikipedia
# que contengan las palabras.

contenidos<-paste0("site%3Aen.wikipedia.org+",term)
url<-URLencode(paste0("https://www.google.com/search?q=", contenidos))# palabra1+palabra2

# Aqu� se reciben varios resultados 
webpage <- read_html(url)

# Inicializar cuadro final
resultados<-data.frame()

for (ciclo in 1:10) {
    # Empleamos el complemeto SelectorGadget de Chrome para identificar en c�digo CSS que necesitamos. Identificamos su parte del c�digo correspondiente.
    # Headers de cada resultado de b�squeda
    titulo_data<- webpage %>% html_nodes('h3.r') %>% html_text()
    # URLs de cada resultado de b�squeda
    url_data <- webpage %>% html_nodes('cite') %>% html_text()
    # Descripciones de cada resultado de b�squeda
    descr_data<-webpage %>% html_nodes("span.st") %>% html_text()
    # URL de la siguiente pantalla
    siguiente<-webpage %>% html_node('a:contains("Siguiente")')
    siguiente_data <- html_attr(siguiente,"href")
    
    # En algunos casos se muestran m�s t�tulos que resultados (Im�genes de wikipedia)
    # Hay que eliminarlos
    if(length(titulo_data)>length(url_data)){
      # Crear l�nea de expresi�n regular (corrigiendo los '+' por '\+')
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
    
    # Traer nueva p�gina
    nuevo_url<-paste0("https://www.google.com",siguiente_data)
    # Tiempo de espera para evitar bloqueos
    Sys.sleep(3)
    webpage <- read_html(nuevo_url)
}
# Algunos incluyen la palabra en el t�tulo: estos no sirven
# Al final de la lista hay que llamar a la siguiente p�gina

# --------------------- Wikipedia ---------------------------
url_wiki<-URLencode("https://en.wikipedia.org/wiki/Cortado")
wikipage<-read_html(url_wiki)
intro_texto<-wikipage %>% html_nodes("#mw-content-text") %>% html_text()
# Devuelve TODO el texto de la p�gina. La introducci�n termina con la tabla
# de "Contents", se puede identificar cada p�rrafo por el /n final
