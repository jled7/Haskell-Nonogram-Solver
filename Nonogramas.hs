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

-- Tipos de Datos --

type ProtoFila = (Linea,RestrLinea,Longitud)

-- ([],[1,1],5)
--

-- FUNCION generaFila
--generaFila :: a -> [a] -> [Linea]
generaFila x y = takeonlyfirst(bt esSolucion componente ([],y,x))

-- FUNCION takeonlyfirst
-- crea una lista con todos elementos primeros en la lista de tuplas (a,b,c)...
takeonlyfirst [] = []
takeonlyfirst ((a,b,c):xs) = a:takeonlyfirst xs

-- FUNCION componente
-- (Una función que dado un nodo (que no es solución) genere todos sus hijos.)
--componente :: ProtoFila -> [ProtoFila]
-- [True,False] : 2 > (length [1] - 1) + sum [1]
-- [False,True,False] : 3 > (length [1] - 1) + sum [1]
-- [False,False,True,False] : 4  > (length [1] - 1) + sum [1]
-- [False,False,False,True,False] : 5 > (length [1] - 1) + sum [1]
-- ([],[1,1],5)
-- ([True,False],[1],3) -- ([False,True,False],[1],2) ++ ([False,False,True,False],[1],1)

componente (a,[],-1) = [((init a),[],0)]
componente (a,[],x) = [(a++(replicate x False),[],0)]
componente (a,(x:xs),lon) = zip3 (generaTrueFalses a x (lon - (sum xs))) (repeat xs) (map (\y -> (lon + (length a) - y)) (map (length) (generaTrueFalses a x (lon - (sum xs)))))


-- FUNCION generaTrueFalses
-- generaTrueFalses cantidadTrues limites
generaTrueFalses a x y = generaTrueFalses' x y 0
	where generaTrueFalses' x y z
		| z >= (y-(x-1)) = []
		| otherwise = (caso_base):generaTrueFalses' x y (z+1)
		where caso_base=a++(replicate z False) ++ (replicate x True) ++ [False]

-- FUNCION esSolucion
-- Una función que comprueba si la posible solucion la es.
esSolucion :: ProtoFila -> Bool

esSolucion (_,[],0) = True
esSolucion (_,_,_) = False


--------------------------------------------------------------------
-- Funciones para la generacion de las soluciones de un nonograma --
--------------------------------------------------------------------

type ProtoDibujo = (Dibujo,[[Linea]],RestrSentido,Longitud)

-- Funcion que comprueba si un protodibujo se ha convertido ya en un dibujo completo

dibujoCompleto :: ProtoDibujo -> Bool
dibujoCompleto (_,llF,_,_) = llF == []

-- Devuelve las columna del dibujo en forma de lista de listas

columnas :: Dibujo -> [Linea]
columnas ([]:rdib) = []
columnas dib = map head dib : columnas ( map tail dib )

-- Funcion que calcula el minimo espacio necesario para una lista de restricciones
-- -Si la lista es vacia, el minimo espacio necesario es 0
-- -Si la lista es unitaria, el minimo espacio necesario es el valor indicado en la restriccion
-- -Si la lista tiene, al menos, dos restricciones, el minimo espacio necesario es:
--  El valor de la primera restriccion
--  Mas 1 (para incluir un espacio en blanco
--  Mas el minimo espacio necesario para el resto de restricciones

minimoEspacio :: RestrLinea -> Longitud
minimoEspacio []= 0
minimoEspacio [x] = x
minimoEspacio (x:xs) = x + 1 + (minimoEspacio xs)

-- Funcion que comprueba las restricciones de una protocolumna

compruebaRestrProtoColumna :: Linea -> RestrLinea -> Longitud -> Bool
compruebaRestrProtoColumna c r nF = iRestriccionesColumna c r nF False
  where
    iRestriccionesColumna [] rs n _ = (minimoEspacio rs) <= n
    iRestriccionesColumna cs [] n _ = restoColumnaVacio cs
      where
         restoColumnaVacio [] = True
         restoColumnaVacio (ca:cs) = ( not ca ) && ( restoColumnaVacio cs )
    iRestriccionesColumna (ca:cs) (r:rs) n enGrupo
      | ca && r > 0  = iRestriccionesColumna cs ((r-1):rs) (n-1) True
      | not ca && r > 0  = ( not enGrupo ) && ( iRestriccionesColumna cs (r:rs) (n-1) False )
      | not ca && r == 0 = iRestriccionesColumna cs rs (n-1) False
      | otherwise          = False

-- Funcion que comprueba que todas las columnas del protodibujo cumplen las restricciones por columna

cumpleRestricciones :: ProtoDibujo -> Bool
cumpleRestricciones (dib,_,rC,nF) = compruebaColumnas (columnas dib) rC nF
  where
    compruebaColumnas [] [] _ = True
    compruebaColumnas (c:cs) (r:rs) nF = ( compruebaRestrProtoColumna c r nF ) && ( compruebaColumnas cs rs nF )

-- Funcion que calcula todos los hijos de un protodibujo
-- Comprueba si al añadir una de las posibilidades para la siguiente fila se siguen cumpliendo las restricciones
-- por columnas

hijosProtoDibujo :: ProtoDibujo -> [ProtoDibujo]
hijosProtoDibujo (dib,(lF:llF),rC,nF) = filter cumpleRestricciones (map ( hijoProtoDibujo (dib,llF,rC,nF) ) lF)

-- Funcion que calcula el hijo de un protodibujo añadiendo una nueva fila

hijoProtoDibujo :: ProtoDibujo -> Linea -> ProtoDibujo
hijoProtoDibujo (dib,llF,rC,nF) fila = (dib++[fila],llF,rC,nF)

-- Funcion que obtiene todos los protodibujos que contienen los dibujos solucion de un nonograma

solucionesNonograma :: ProtoDibujo -> [ProtoDibujo]
solucionesNonograma protoDibujo = bt dibujoCompleto hijosProtoDibujo protoDibujo

--------------------------------------------------------
-- Extraccion de las restricciones de un grafico dado --
--    ---- TRABAJO OPTATIVO DE LOS ESTUDIANTES ----   --
--------------------------------------------------------

-- [[False,True ,True ,True ,False],
--  [True ,False,False,False, True],
--  [True ,True ,True ,True , True],
--  [True ,False,False,False, True],
--  [True ,False,False,False, True]]
--  ([[3],[1,1],[5],[1,1],[1,1]],
--   [[4],[1,1],[1,1],[1,1],[4]],
--   5,5))

-- FUNCION creaNonograma
creaNonograma :: [Linea] -> (Nonograma)
creaNonograma (a) = (map cuentaTrues a,map cuentaTrues (b),length a,length b) where b = columnas a

-- FUNCION mostrarNonograma
mostrarNonograma a = putStr (resuelveNonograma (creaNonograma a))

-- FUNCION cuentaTrues
cuentaTrues = cuentaTrues' 0
cuentaTrues' 0 [] = []
cuentaTrues' n [] = [n]
cuentaTrues' n (y:ys)
	| y == True = cuentaTrues' (n+1) ys
	| y == False && n == 0 = cuentaTrues' 0 ys
	| y == False = n:cuentaTrues' 0 ys   
