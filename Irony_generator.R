
# Encuentra Ironías
# Encuentra Paradojas

palabra<-"death"

# Buscar palabra en una serie de fuentes de información
# Abrir fuentes de información y colapsarlas en un solo objeto
train_text<-read.table("C:/Users/Tezzz/Documents/Data Science/R/Irony/text_input1.txt",sep="\t", quote = "")

# Obtener ubicaciones de palabra en cada texto.
# Enlistar líneas que contienen la palabra
ubi<-grepl(palabra,train_text[,1],ignore.case = TRUE)
# Enlistar ubicaciones de inicio de la palabra en cada línea (-1 para NA)
ubi2<-regexpr(palabra,train_text[,1],ignore.case = TRUE)

# Muestra las primeras 20 apariciones de la palabra en el texto
head(substr(train_text[ubi,],ubi2[ubi2!=-1],ubi2[ubi2!=-1]+5),20)

# Hasta aquí las palabras aparecen al principio, mitad y final de la línea
# Esto va a hacer difícil leer oraciones completas.
# Vale la pena juntar todo el texto en un solo string.
# Luego seccionar el texto por unidades de oraciones (.,\t,\n, etc...)
# Luego quedarse solo con líneas que contengan palabra. 
# Quizás la oración inmediata anterior y posterior.

# También, la palabra no necesariamente está descrita en la línea en la que
# aparece. Sino que la palabra aporta significado a la línea.

# Más valdría extraer el significado de una enciclopedia o diccionario.

# Por cada ubicación, identificar ubicaciones de separadores de oraciones 
# antes y después de la palabra.
# Extraer la oración entera.
# Eliminar stop words, dejar negativos.
# Poner todas las palabras juntas en un solo array.
# Hacer tabla dinámica de frecuencia de palabras.
# Filtrar las más comunes.
# Para las más comunes traducir cada componente en WordReference.
# Buscar en el corpus inglés el valor de cada palabra.
# Aquí se va a poner interesante, pero por ahora experimentemos:
# Sumando los valores de cada palabra de la oración.
# si existe negación, invertir el signo.
# Identificar las apariciones con valores absolutos más altos.
# Aparear aleatoriamente positivos con negativos y ofrecer propuestas.


