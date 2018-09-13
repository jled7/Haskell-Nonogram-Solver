module Nonogramas where

-- Tipos de Datos --

type Linea = [Bool]
type Dibujo = [Linea]
type Longitud = Int
type RestrLinea = [Int]
type RestrSentido = [RestrLinea]
type Nonograma = (RestrSentido,RestrSentido,Longitud,Longitud)

-----------------------------
-- Esquema de Backtracking --
-----------------------------

bt :: (a -> Bool) -> (a -> [a]) -> a -> [a]
bt esSol comp nodo
    | (esSol nodo) = [nodo]
    | otherwise    = concat (map (bt esSol comp) (comp nodo))

----------------------------------------------
-- Funciones de presentacion de los dibujos --
----------------------------------------------

-- Funcion que dado un dibujo lo prepara para ser mostrado en pantalla

dibujo2String :: Dibujo -> String
dibujo2String dib = marco ++ idibujo2String dib ++ marco
  where
    idibujo2String [] = []
    idibujo2String (f:fs) = '|':(map transforma f) ++ "|\n" ++ ( idibujo2String fs )
    marco = '+':( map (\x -> '-' ) (head dib) ) ++ "+\n"
    transforma True = 'X'
    transforma False = ' '

-- Funcion que muestra todas las soluciones de un nonograma resuelto

muestraSoluciones :: [Dibujo] -> String
muestraSoluciones [] = ""
muestraSoluciones (d:ds) = ( dibujo2String d ) ++ "\n" ++ ( muestraSoluciones ds )

-----------------------
-- Funcion principal --
-----------------------

resuelveNonograma :: Nonograma -> String
resuelveNonograma (rF,rC,nF,nC) = imprimeSoluciones soluciones
  where
    imprimeSoluciones []  = "El nonograma no tiene solucion\n"
    imprimeSoluciones [x] = "El nonograma tiene una unica solucion\n\n" ++ muestraSoluciones [x]
    imprimeSoluciones [x,y] = "El nonograma tiene varias soluciones\n\n" ++ muestraSoluciones [x,y]
    soluciones = take 2 (map (\(d,_,_,_) -> d) (solucionesNonograma ([],map (generaFila nC) rF,rC,nF)))

-----------------------------------------------
-- Funciones para la generacion de las filas --
--   ---- TRABAJO DE LOS ESTUDIANTES ----    --
-----------------------------------------------
