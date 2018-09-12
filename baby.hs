doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100 then x else x * 2
doubleSmallNumber' x = (if x > 100 then x else x * 2) + 1

conanO'Brien = "It's a-me, Conan O'Brien!"

removeNonUpperCase :: [Char] -> [Char]
removeNonUpperCase st = [c | c <- st, c `elem` ['A'..'Z']]

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double
circumference' r = 2 * pi * r

lucky :: (Integral a) => a -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"   

sayMe :: (Integral a) => a -> String  
sayMe 1 = "One!"  
sayMe 2 = "Two!"  
sayMe 3 = "Three!"  
sayMe 4 = "Four!"  
sayMe 5 = "Five!"  
sayMe x = "Not between 1 and 5"  

head' :: [a] -> a
head' [] = error "Lista vacia"
head' (x:_) = x

tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

capital :: String -> String
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

--bmiTell :: (RealFloat a) =>  a -> String
--bmiTell bmi
--	| bmi <= 18.5 = "You're underweight, you emo, you!"
--	| bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
--	| bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
--	| otherwise   = "You're a whale, congratulations!"

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
	|	weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
	|	weight / height ^ 2 <= 25.0 = "You're supposedly normal.Pffft, I bet you're ugly!"
	|	weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
	| 	otherwise					= "You're a whale, congratulations!"
	
max' :: (Ord a) => a -> a -> a
max' a b 
	| a > b 	= a
	| otherwise = b
	
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
	| a > b		= GT
	| a == b 	= EQ
	| otherwise	= LT
	
bmiTell' :: (RealFloat a) => a -> a -> String
bmiTell' weight height
	|	bmi <= 18.5 = "You're underweight, you emo, you!"
	|	bmi <= 25.0 = "You're supposedly normal.Pffft, I bet you're ugly!"
	|	bmi <= 30.0	  = "You're fat! Lose some weight, fatty!"
	| 	otherwise					= "You're a whale, congratulations!"
	where bmi = weight / height ^ 2
		  
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "." 
    where (f:_) = firstname
    (l:_) = lastname
		
cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
        let sideArea = 2 * pi * r * h  
            topArea = pi * r ^2  
        in  sideArea + 2 * topArea  
