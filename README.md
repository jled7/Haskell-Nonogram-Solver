## 1. Introduction: Nonograms.

A nonogram (http://en.wikipedia.org/wiki/Nonogram) is a logic puzzle developed on a rectangular NxM board. There are two types of squares on such a board: marked squares (represented by a black box) and free squares (blank). The idea is that the marked squares represent a drawing. 

The shape of this drawing is determined by a list of numerical values that indicate for each row (or column) of the board the groups of consecutive marked squares that exist in that row (or column). For example, if in a row we have the values 5 3 9 , it means that there are three groups of marked squares in that row: the first of length 5, the second of length 3 and the last of length 9. All these groups must be separated by at least one free square.

For example, The next image shows an unsolved Nonogram:
<p align = "center"><img src = "https://github.com/jled7/Haskell-Nonogram-Solver/raw/master/images/emptynonogram.png"><br />20x20 nonogram (source: wikipedia)</p>

And in the next image we can see a solution of such a nonogram. It should be noted that the solution of a nonogram (if it exists) does not have to be unique, since the same constraints can give rise to more than one drawing that meets them.

<p align = "center"><img src = "https://github.com/jled7/Haskell-Nonogram-Solver/raw/master/images/nonograma.png"><br />The same nonogram already solved (source wikipedia)</p>


We will consider the problem of a computer scientist hired by a newspaper that intends to offer its readers a daily nonogram for them to solve. The practice consists, therefore, in developing a program that, given a nonogram expressed as a set of constraints, checks whether the nonogram has a solution and whether it is unique or not. 

Specifically, the practice consists of writing a function in Haskell called `resuelveNonograma` that, given a set of constraints and a number of rows and columns, checks if there is a solution of the appropriate size that responds to that set of constraints, reporting, in addition, if the solution is unique.

When visualizing the solutions of the nonograms, we will represent the marked boxes by an X, while the free boxes will be represented by a blank space. However, during the solution phase, the cells will be represented by Boolean values (cell marked with a true, and not marked with a false), in order to facilitate the calculations. 

Thus, if the constant function `ejemploNonograma` contains the necessary information (set of constraints, number of rows and number of columns) about the nonogram shown in the first image, an execution of `resuelveNonograma` would be:

```
Nonogramas> putStr ( resuelveNonograma ejemploNonograma )
El nonograma tiene una unica solucion

+--------------------+
|          XXX       |
|         XXXXX      |
|         XXX X      |
|         XX  X      |
|      XXX XXX XXXX  |
|    XX  XX   XXXXXXX|
|  XXXXXX X   X      |
| XXXX   XX  XX      |
|        X   X       |
|       XXX  X       |
|       XXXXXX       |
| XX   XXXXXXX       |
|XXXXXX  XXX X       |
|X XX  XX X  X       |
|   XXXX  X X  XXX   |
|        XXXX XX XX  |
|        XXX  XXX X  |
|       XXX    XXX   |
|      XXX           |
|      XX X          |
+--------------------+

Nonogramas>
```

Where Haskell's putStr function allows formatting codes (line breaks, tabs...) of character strings to be interpreted correctly.

## 2. Data structures used

The first thing to do is to define the data structures to be used in the program. To do this we will take
as an example the following drawing:

```
 XXX
X   X
XXXXX
X   X
X   X
```

- A **line** : we will consider that a line will represent a row or a column of the drawing. As we have already said, we are going to use the Boolean data type to represent the cells during the resolution. That is to say:

>```
>Linea :: [Bool]
>```
&emsp;&emsp;&emsp;Por ejemplo, la primera línea del dibujo la vamos a representar con la lista `[False,True,True,True,False]`

- **Drawing** : a drawing contains the information about all the cells in the drawing. It can be seen as the set of all its rows (or columns), i.e. as the list of N (number of rows) lists of boolean values representing each of the rows of the drawing). Therefore:

>```
>Dibujo :: [Linea]
>```

&emsp;&emsp;&emsp;In our example, the list of rows in the drawing will be:

>```
>[[False,True,True,True,False],
> [True,False,False,False,True],
> [True,True,True,True,True],
> [True,False,False,False,True],
> [True,False,False,False,True]]
>```

- **Length of a line** (row or column): represents the length of that line. That is:

>```
>Longitud :: Int
>```

- **Restrictions for a line** : these restrictions will be expressed by a list of integers, which will represent the groups of consecutive checked boxes that exist in that line (row or column). That is:
>```
>RestrLinea :: [Int]
>```

&emsp;&emsp;&emsp; For example, the constraints for row 1 are represented by the list [3] and the constraints for row 2 by the list [1,1].

- **One-way constraints** (all rows or columns): extending the previous structure, one-way constraints are a list containing, for each line going in that direction (row or column) the constraints for that line. That is, row constraints are a list of N (number of rows) lists of constraints per row, while column constraints are a list of M (number of columns) lists of constraints per column:

>```
>RestrSentido :: [RestrLinea]
>```

&emsp;&emsp;&emsp;For example, in the drawing used as an example in the Line data type, the restrictions for each direction are:
&emsp;&emsp;&emsp; -By row: `[[3],[1,1],[5],[1,1],[1,1]]`
&emsp;&emsp;&emsp; -By column: `[[4],[1,1],[1,1],[1,1],[4]]`

- **Nonogram** : since a nonogram consists of a series of row and column constraints, in addition to the number of rows and columns, we can use a tuple in which the first value contains the row constraints, the second the column constraints and the third and fourth values the length of the rows and columns respectively. That is:

>```
>Nonograma :: (RestrSentido,RestrSentido,Longitud,Longitud)
>```

&emsp;&emsp;&emsp;In our example, the nonogram would be:
>```
>([[3],[1,1],[5],[1,1],[1,1]],[[4],[1,1],[1,1],[1,1],[4]],5,5)
>```

## 2.2 Resolution method

To find all the solutions of a nonogram, a brute force method can be used. Although it is not the best way to solve this problem, it allows us to obtain the desired results in a reasonable time.

When solving the problem of computer scientists hired in a newspaper, we will divide it into two steps, the second of which will be programmed, so the student's task will be to solve the first one.

## 2.2.1 Step 1: Generation of possible rows

The objective is to create a `generaFila` function that, given the total length of the row and its constraint list, generates the list of all possible rows that are compatible with that constraint list.
For example:

```
Nonogramas> generaFila  8  [2,2,1]
[[True,True,False,True,True,False,True,False],
[True,True,False,True,True,False,False,True],
[True,True,False,False,True,True,False,True],
[False,True,True,False,True,True,False,True]]
```

One way to generate all the possible rows is to perform an exhaustive search by backtracking over a graph in which each node contains the proto-row built up to that moment (not complete row, formed by a series of checked and unchecked boxes that fulfill, up to that moment, the row constraints), the constraints that remain to be analyzed and the number of boxes that still remain to be completed. That is:

```
ProtoFila :: (Linea,RestrLinea,Longitud)
```
Once this step is solved, we have changed the starting problem. Before, we had two sets of constraint lists: one by rows and one by columns. Now, the problem consists of a set of lists of possible rows and a set of lists of columnar constraints.

## 2.2.2 Step 2: Checking the constraints by columns

Once for each row of the drawing we have all the possibilities (thanks to the function `generaFila`), we have reduced the original problem to choose properly each one of the possible rows to be able to fulfill the restrictions by columns. We are going to solve this by performing again a backtracking in which the nodes will contain proto-drawings , whose type will be:

```
ProtoDibujo :: (Dibujo,[[Linea]],RestrSentido,Longitud)
```

The drawings contained in the nodes will be formed by the top rows of a possible solution to the nonogram that, up to that point, meet the columnar constraints. Therefore, a first function that is necessary to apply the backtracking scheme is the one that indicates whether a proto-drawing contains a complete drawing or not. This function is called `dibujoCompleto` and its type is:

```
dibujoCompleto :: ProtoDibujo ­> Bool
```

Next, as in every backtracking, it is necessary to program the completions function, which, given a node, generates all its possible children. In our case this function is hijosProtoDibujo, whose expected type is:

```
hijosProtoDibujo :: ProtoDibujo ­> [ProtoDibujo]
```

This function completes the drawing contained in the proto-drawing by adding all those possibilities for the next row that make the new drawing still meet the columnar constraints. Therefore, a function is needed to filter out those proto-drawings whose drawings do NOT meet the constraints. This is taken care of by the function `cumpleRestricciones`. Basically that function checks that the constraints are met for each column, so it makes use of an auxiliary function (`compruebaRestrProtoColumna`) that, given a proto-column (which is one of the columns of a proto-drawing that, possibly, does not have the full length of a nonogram column), the constraints for that column and the full size of the column, tells us if that proto-column meets the constraints or not. For example:

```
Nonogramas> compruebaRestrProtoColumna [True,True,True,False,True] [3,3,1]  10 
True
Nonogramas> compruebaRestrProtoColumna [True,True,False,True,True,True] [2,2]  8 
False
Nonogramas>
```
In the first example we see that the first constraint (a group of three checked boxes) is satisfied, while the second constraint (a second group of three boxes) is compatible with the fact that there is a new checked box.  However, in the second example we see that the first constraint is met, but since there is a group of three consecutive boxes, the second constraint is not met, so the last row added (which is responsible for the last checked box in that column) will not be valid to complete the drawing with the constraints we have.  The main function that launches this backtracking is the function `solucionesNonograma`, which is called by the function `resuelveNonograma`. The type of this function is:

```
solucionesNonograma :: ProtoDibujo ­> [ProtoDibujo]
```

Since function `resuelveNonograma` makes use of `generaFila` to perform the first resolution step and thus generate the initial node of this backtracking.

