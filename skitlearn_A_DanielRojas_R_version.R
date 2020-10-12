## Nombre: Geman Daniel Rojas
## Materia: Progrmacion cientifica
## Universidad Sergio Arboleda

## Se importa el dataset de datos Correspondiente
datosS = read.table(file.choose(), header = T, sep=',')
## Se visualiza el contenido del dataset
datosS

## Se alamcenan en memoria las columnas del Dataset.
attach(datosS)

##Se realiza un Resumen ESTADISTICO por cada columna contenida en el dataset.
summary(datosS)
## Se realiza un resumen  ESTADISTICO de la variable TargeT de Evaluación.
summary(Profit)

## Ahora se realizara la correlacion de las variables independientes con la dependiente (Target 'Profit')
## En el estudio de correlacion de omite las columnas STATE ya que sus valores son tipo Categoricos, asi mismo se omite la variable PROFIT
## ya que producira una correlación de 1 (100%), siendo irrelevante para el estudio;
cor_obtenida = cor(Profit,datosS[,1:3]) 
cor_obtenida[1]


## Basado en la correlacion de las features pasadas, se escoge un umbral de aceptación mayor al 50%
## S e realiza un filtrado para obtenerlos numbres de las festures que cumplen con el umbral de correlacion 
lista_features_filtrada = c();
for (variable in 1:length(cor_obtenida)) {
    if(cor_obtenida[variable] >= 0.5){
      lista_features_filtrada = c(lista_features_filtrada, colnames(cor_obtenida)[variable])
    }
}
lista_features_filtrada ##Features seleccionadas 

## Se extraen los datos del datset original, basado en los nombres de la features obtenidas anteriormente
datosFiltrados = subset(datosS, select = lista_features_filtrada)
datosFiltrados ## Datos de la variables independientes
datosObjetivo  = Profit

## Se realizan sub-secciones de datos (X_train, X_test, Y_Train, Y_test), se selecciona el 80% del dataset para entrenamiento y el 20% para testeo
sizeDatos = 50 ## total de filas del dataset


## Se decalra el modelo lineal multivariable
model1 = lm((Profit~datosFiltrados$R.D.Spend+datosFiltrados$Marketing.Spend))

## Se realiza un resumen estadistico del modelo obtenido
summary(model1)

## Conclusiones

#1. Segun la evalauacion de la metrica (R2) se observa un alto porcentaje de confiabilidad en la prediccion del modelo
#2. Basado en el dataset, se demuestra como (R&D Spend) y (Marketing Spend) son de gran influencia en comportamiento del profit

##### Obervemos los atributos del modelo
attributes(model1)
model1$coefficients
model1$residuals



##Se realiza un Plot de graficas , que permiten analizar el modelo
plot(model1)
#### Primer grafico : "Si se cumple el supuesto de linealidad, pero se alcanza a observar que es inestable la linealidad"
###Segundo grafico: qqplot "Cuartil grafico" - Se observa como los errores residuales pueden se muy inestable, pero se respeta un patron lo suficientemente bueno para un estudio
#Eje y: errrores residuaels ordenados, estandarizado
#Eje x: errores residuales ordenados teoricos

## Tercer y cuarto Grafico
# identifica la No linealida, no varianza constannte
## Es alta la no linealidad de los datos obtenidos en tercer grafico, los errores residuales frente al modelo aclaran que las predicciones pueden ser muy inexactas
