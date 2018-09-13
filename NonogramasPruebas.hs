---------------------------------------------
-- Teoria de los Lenguajes de Programacion --
-- Practica del Curso: 2014-2015           --
---------------------------------------------
-- Codigo Haskell con los juegos de prueba --
-- de la practica. Realizado por el Equipo --
-- Docente de la asignatura                --
---------------------------------------------

module NonogramasPruebas where

import Nonogramas

-----------------------------------------
--- JUEGOS DE PRUEBA PARA LA PRACTICA ---
-----------------------------------------

-- Filas para generar

ejecutaTestFilas = map pruebaGeneraFila filasTest
  where pruebaGeneraFila (longitud,restricciones,soluciones) = ( length (generaFila longitud restricciones) ) == soluciones

filasTest :: [(Int,[Int],Int)]
filasTest = [ (4,[2],3),
              (5,[1,1],6),
              (8,[2,2],10),
              (10,[1,2,1],35),
              (15,[2,5,1,2],15) ]

------------------------------------------
-- DIBUJOS DE PRUEBA PARA LA CUESTION 1 --
------------------------------------------

ejecutaTestCuestion1 = map pruebaCreaNonograma cuestion1Test
  where pruebaCreaNonograma (dibujo,nonograma) = ( creaNonograma dibujo ) == nonograma


cuestion1Test = [c1_jdp1,c1_jdp2,c1_jdp3,c1_jdp4]


c1_jdp1 :: (Dibujo,Nonograma)
c1_jdp1 = ([[False,True,True,True,False],
            [True,False,False,False,True],
            [True,True,True,True,True],
            [True,False,False,False,True],
            [True,False,False,False,True]],
           ([[3],[1,1],[5],[1,1],[1,1]],
            [[4],[1,1],[1,1],[1,1],[4]],
            5,
            5))

c1_jdp2 :: (Dibujo,Nonograma)
c1_jdp2 = ([[False,True,True,True,True,True,True,False],
            [True,False,False,False,False,False,False,True],
            [True,False,True,False,False,True,False,True],
            [True,False,False,False,False,False,False,True],
            [True,False,True,False,False,True,False,True],
            [True,False,False,True,True,False,False,True],
            [True,False,False,False,False,False,False,True],
            [False,True,True,True,True,True,True,False]],
           ([[6],[1,1],[1,1,1,1],[1,1],[1,1,1,1],[1,2,1],[1,1],[6]],
            [[6],[1,1],[1,1,1,1],[1,1,1],[1,1,1],[1,1,1,1],[1,1],[6]],
            8,
            8))

c1_jdp3 :: (Dibujo,Nonograma)
c1_jdp3 = ([[False,False,False,False,True,True,True,True,True,False],
            [False,False,False,False,True,False,True,True,True,True],
            [False,False,False,False,True,False,False,False,False,False],
            [False,True,True,False,True,False,True,True,False,False],
            [True,True,True,True,True,True,False,True,True,False],
            [True,True,True,True,True,False,False,False,True,False],
            [True,True,True,True,True,False,False,False,True,False],
            [True,True,True,True,True,False,False,False,True,False],
            [True,True,True,True,True,False,False,True,True,False],
            [False,True,True,True,False,True,True,True,False,False]],
           ([[5],[1,4],[1],[2,1,2],[6,2],[5,1],[5,1],[5,1],[5,2],[3,3]],
            [[5],[7],[7],[6],[9],[1,1,1],[2,1,1],[2,2,2],[2,5],[1]],
            10,
            10))

c1_jdp4 :: (Dibujo,Nonograma)
c1_jdp4 = ([[False,False,False,False,False,False,False,False,False,False,True,True,True,False,False,False,False,False,False,False],
            [False,False,False,False,False,False,False,False,False,True,True,True,True,True,False,False,False,False,False,False],
            [False,False,False,False,False,False,False,False,False,True,True,True,False,True,False,False,False,False,False,False],
            [False,False,False,False,False,False,False,False,False,True,True,False,False,True,False,False,False,False,False,False],
            [False,False,False,False,False,False,True,True,True,False,True,True,True,False,True,True,True,True,False,False],
            [False,False,False,False,True,True,False,False,True,True,False,False,False,True,True,True,True,True,True,True],
            [False,False,True,True,True,True,True,True,False,True,False,False,False,True,False,False,False,False,False,False],
            [False,True,True,True,True,False,False,False,True,True,False,False,True,True,False,False,False,False,False,False],
            [False,False,False,False,False,False,False,False,True,False,False,False,True,False,False,False,False,False,False,False],
            [False,False,False,False,False,False,False,True,True,True,False,False,True,False,False,False,False,False,False,False],
            [False,False,False,False,False,False,False,True,True,True,True,True,True,False,False,False,False,False,False,False],
            [False,True,True,False,False,False,True,True,True,True,True,True,True,False,False,False,False,False,False,False],
            [True,True,True,True,True,True,False,False,True,True,True,False,True,False,False,False,False,False,False,False],
            [True,False,True,True,False,False,True,True,False,True,False,False,True,False,False,False,False,False,False,False],
            [False,False,False,True,True,True,True,False,False,True,False,True,False,False,True,True,True,False,False,False],
            [False,False,False,False,False,False,False,False,True,True,True,True,False,True,True,False,True,True,False,False],
            [False,False,False,False,False,False,False,False,True,True,True,False,False,True,True,True,False,True,False,False],
            [False,False,False,False,False,False,False,True,True,True,False,False,False,False,True,True,True,False,False,False],
            [False,False,False,False,False,False,True,True,True,False,False,False,False,False,False,False,False,False,False,False],
            [False,False,False,False,False,False,True,True,False,True,False,False,False,False,False,False,False,False,False,False]],
           ([[3],[5],[3,1],[2,1],[3,3,4],[2,2,7],[6,1,1],[4,2,2],[1,1],[3,1],
             [6],[2,7],[6,3,1],[1,2,2,1,1],[4,1,1,3],[4,2,2],[3,3,1],[3,3],[3],[2,1]],
            [[2],[1,2],[2,3],[2,3],[3,1,1],[2,1,1],[1,1,1,2,2],[1,1,3,1,3],[2,6,4],[3,3,9,1],
             [5,3,2],[3,1,2,2],[2,1,7],[3,3,2],[2,4],[2,1,2],[2,2,1],[2,2],[1],[1]],
            20,
            20))

