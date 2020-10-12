import numpy as np
import sys
import random
from datetime import datetime
import math as mt


##German Daniel Rojas


##Generador de matriz (nxn) Python
def generaMatrizPython(n):
    arrM= []
    arrN = []
    for d in range(0,(n*n)+1):
        x = random.randint(0, 50)
        if(len(arrN)<n):
            arrN.append(x)
        else:
            arrM.append(arrN)
            arrN = []
            arrN.append(x)
        pass
    return arrM
    pass

## Funcion que recibe una matriz hecha en python y asigna a cada elemento x = sen(x)*cos(x)
def procesarMatrizResultadoPython(mat):
    counfila = 0;
    countColumna = 0 ;
    for fila in mat:
        for elemento in fila:
            mat[counfila][countColumna] = mt.sin(elemento) * mt.cos(elemento)
            countColumna+=1
            pass
        pass
        counfila +=1;
        countColumna = 0;
    pass
    return mat




##Generador de Matriz (n*n) hecha en Numpy
def generaMatrizNumpy(n):
     return (np.random.randint(0,50,(n,n)))

## Funcion que recibe una matriz hecha en Numpy y asigna a cada elemento x = sen(x)*cos(x)
def procesarMatrizResultadoNumpy(mat):
    counfila = 0;
    countColumna = 0;
    for fila in mat:
        for elemento in fila:
            mat[counfila][countColumna] = np.sin(elemento) * np.cos(elemento)
            countColumna += 1
            pass
        pass
        counfila += 1;
        countColumna = 0;
    pass
    return mat




def AnalisisRendimientoPython():
    timePython =[];
    for x in range(10):
        start = datetime.now()
        mat = generaMatrizPython(5)
        matrizResultado = procesarMatrizResultadoPython(mat)
        delta = datetime.now() - start
        timePython.append(delta.microseconds)
        pass
    return np.mean(timePython);

def AnalisisRendimientoNumpy():
    timeNumpy = [];
    for x in range(10):
        start = datetime.now()
        mat = generaMatrizNumpy(5)
        matrizResultado = procesarMatrizResultadoNumpy(mat)
        delta = datetime.now() - start
        timeNumpy.append(delta.microseconds)
        pass
    return np.mean(timeNumpy)

print('Promedio de tiempo en Python  = ', AnalisisRendimientoPython())
print('Promedio de tiempo en Numpy = ', AnalisisRendimientoNumpy())








