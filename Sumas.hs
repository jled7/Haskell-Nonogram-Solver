---------------------------------------------
-- Teoria de los Lenguajes de Programacion --
-- Practica del Curso: 2013-2014           --
---------------------------------------------
-- Codigo HUGS para la implementación de   --
-- la practica realizado por el Equipo     --
-- Docente de la asignatura                --
---------------------------------------------


module Sumas where

import Data.List

-- Tipos de datos utilizados --

type Problema = ([Int],[Int])
type Suma = (Int,Int)
type Solucion = [Suma]
type Nodo = ([Int],[Int],Solucion)

-- Funcion de backtracking --

bt :: (a -> Bool) -> (a -> [a]) -> a -> [a]
bt esSol compleciones nodo
  | esSol nodo = [nodo]
  | otherwise = concat (map (bt esSol compleciones) (compleciones nodo))

-- Impresion de soluciones --

imprimeSoluciones :: [Solucion] -> String
imprimeSoluciones [] = "El problema no tiene soluciones\n"
imprimeSoluciones [x] = "El problema tiene una unica solucion:\n" ++ (imprimeSolucion x)
imprimeSoluciones (x:y:zs) = "El problema tiene mas de una solucion:\n" ++
                             (imprimeSolucion x) ++ "y\n\n" ++
                             (imprimeSolucion y) 

imprimeSolucion :: Solucion -> String
imprimeSolucion [] = "\n"
imprimeSolucion ((x,y):ss) = (show (x+y)) ++ " = " ++
                             (show x) ++ " + " ++
                             (show y) ++ "\n" ++
                             (imprimeSolucion ss)

ejemploEnunciado :: Problema
ejemploEnunciado = ([12,11,8],[1,3,9,6,7,5])

--- Implementación de las funciones que solucionan la práctica ---


