## Nombre: Geman Daniel Rojas
## Materia: Progrmacion cientifica
## Universidad Sergio Arboleda

## Se importa el dataset de datos Correspondiente
datosS = read.table(file.choose(), header = T, sep=';')
## Se visualiza el contenido del dataset
datosS 

## Se grafica los features de distribucion lineal y compotamiento
## Se establece como a unos puntos de concentracion de disribucion, asi mismo, como hay muchos datos que no so exactos, demostrando que no hay una lienalidad confiable entre los examenes.
pairs(datosS[,1:4])

## Dado que el problema es de examenes, elimine aquellos registros que estaban vacios, por la siguientes razones:
## Si remplazo por 0 lo hago menos logico y lineal con la  relacion del examen Final, esto quiere decir que añado ruido a la hora de predecir un resultado
## Por lo tanto es mejor eliminar registros invariables con datos vacios que añadir ruido de comportamiento del estudio, haciendo mas predecible el comportamiento del la varable de target posteriormente
datosS = na.omit(datosS)
## Se alamcenan en memoria las columnas del Dataset.
attach(datosS)
names(datosS) ## Nombre de las features 

##Se realiza un Resumen ESTADISTICO por cada columna contenida en el dataset.
summary(datosS)
## Se realiza un resumen  ESTADISTICO de la variable TargeT de Evaluación.
summary(FINAL)

## Ahora se realizara la correlacion de las variables independientes con la dependiente (Target 'FINAL')
#asi mismo se omite la variable FINAL
## ya que producira una correlación de 1 (100%), siendo irrelevante para el estudio;
cor_obtenida = cor(FINAL,datosS[,1:3]) 
cor_obtenida

cor.test(FINAL,datosS[,1])

## Basado en la correlacion de las features pasadas, se escoge un umbral de aceptación mayor al 0.04% que  basaod en la correlacion incluiria a todos los features
## S e realiza un filtrado para obtenerlos numbres de las features que cumplen con el umbral de correlacion 
lista_features_filtrada = c();
for (variable in 1:length(cor_obtenida)) {
  if(cor_obtenida[variable] >= 0.04){
    lista_features_filtrada = c(lista_features_filtrada, colnames(cor_obtenida)[variable])
  }
}
lista_features_filtrada ##Features seleccionadas 

## Se extraen los datos del datset original, basado en los nombres de la features obtenidas anteriormente
datosFiltrados = subset(datosS, select = lista_features_filtrada)
datosFiltrados ## Datos de la variables independientes
datosObjetivo  = Profit

## Se decalra el modelo lineal multivariable
model1 = lm((FINAL~datosFiltrados$EXAM1+datosFiltrados$EXAM2+datosFiltrados$EXAM3))

## Se realiza un resumen estadistico del modelo obtenido
summary(model1)

## Conclusiones

#1. Segun la evalauacion de la metrica (R2) se observa un bajo porcentaje de confiabilidad en la prediccion del modelo
#2. Basado en el dataset, se demuestra como ningun  feature tiene incidencia de alta confiabilidad sobre la carablr TARGET (EXAMEN FINAL)

##### Obervemos los atributos del modelo
attributes(model1)
model1$coefficients
model1$residuals

##Se realiza un Plot de graficas , que permiten analizar el modelo
plot(model1)

#### Primer grafico : "Si se cumple el supuesto de linealidad, pero se encuentra una distribución altamente dinamica"
###Segundo grafico: qqplot "Cuartil grafico" - Se observa como los errores residuales pueden se muy inestable, pero se respeta un patron lo suficientemente bueno para un estudio
#Eje y: errrores residuaels ordenados, estandarizado
#Eje x: errores residuales ordenados teoricos

## Tercer y cuarto Grafico
# identifica la No linealida, no varianza constannte
## Es alta la no linealidad de los datos obtenidos en tercer grafico, los errores residuales frente al modelo aclaran que las predicciones pueden ser muy inexactas
## En cuarto grafico se puede observar como estos datos  en los examenes tienden a tener una decandencia de linealidad 

