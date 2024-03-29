
# Encuentra Iron�as
# Encuentra Paradojas

palabra<-"death"

# Buscar palabra en una serie de fuentes de informaci�n
# Abrir fuentes de informaci�n y colapsarlas en un solo objeto
train_text<-read.table("C:/Users/Tezzz/Documents/Data Science/R/Irony/text_input1.txt",sep="\t", quote = "")

# Obtener ubicaciones de palabra en cada texto.
# Enlistar l�neas que contienen la palabra
ubi<-grepl(palabra,train_text[,1],ignore.case = TRUE)
# Enlistar ubicaciones de inicio de la palabra en cada l�nea (-1 para NA)
ubi2<-regexpr(palabra,train_text[,1],ignore.case = TRUE)

# Muestra las primeras 20 apariciones de la palabra en el texto
head(substr(train_text[ubi,],ubi2[ubi2!=-1],ubi2[ubi2!=-1]+5),20)

# Hasta aqu� las palabras aparecen al principio, mitad y final de la l�nea
# Esto va a hacer dif�cil leer oraciones completas.
# Vale la pena juntar todo el texto en un solo string.
# Luego seccionar el texto por unidades de oraciones (.,\t,\n, etc...)
# Luego quedarse solo con l�neas que contengan palabra. 
# Quiz�s la oraci�n inmediata anterior y posterior.

# Tambi�n, la palabra no necesariamente est� descrita en la l�nea en la que
# aparece. Sino que la palabra aporta significado a la l�nea.

# M�s valdr�a extraer el significado de una enciclopedia o diccionario.

# Por cada ubicaci�n, identificar ubicaciones de separadores de oraciones 
# antes y despu�s de la palabra.
# Extraer la oraci�n entera.
# Eliminar stop words, dejar negativos.
# Poner todas las palabras juntas en un solo array.
# Hacer tabla din�mica de frecuencia de palabras.
# Filtrar las m�s comunes.
# Para las m�s comunes traducir cada componente en WordReference.
# Buscar en el corpus ingl�s el valor de cada palabra.
# Aqu� se va a poner interesante, pero por ahora experimentemos:
# Sumando los valores de cada palabra de la oraci�n.
# si existe negaci�n, invertir el signo.
# Identificar las apariciones con valores absolutos m�s altos.
# Aparear aleatoriamente positivos con negativos y ofrecer propuestas.


