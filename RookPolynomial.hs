--Mateusz Wołowiec
--Wielomian szachowy

countTrue :: [Bool] -> Integer
countTrue = foldr (\x -> (+) (if x then 1 else 0)) 0 

placementsForOne :: [[Bool]] -> Integer
placementsForOne = foldr ((+) . countTrue) 0
--placementsForOne = foldr (\boolList -> (+) (countTrue boolList)) 0

forbidWholeRow :: [Bool] -> [Bool]
forbidWholeRow row = replicate (length row) False 

forbidInRow :: [Bool] -> Integer -> Integer -> [Bool]
forbidInRow [] _ _ = []
forbidInRow (x:xs) col currInd
  | col == currInd = False : forbidInRow xs col (currInd + 1)
  | otherwise = x : forbidInRow xs col (currInd + 1)

forbidRowAndColumn :: [[Bool]] -> Integer -> Integer -> Integer -> [[Bool]]
forbidRowAndColumn [] _ _ _ = []
forbidRowAndColumn (x:xs) row col currRow
  | currRow == row = forbidWholeRow x : forbidRowAndColumn xs row col (currRow + 1)
  | otherwise = forbidInRow x col 0 : forbidRowAndColumn xs row col (currRow + 1)

forbidSquare :: [[Bool]] -> Integer -> Integer -> Integer -> [[Bool]]
forbidSquare [] _ _ _= []
forbidSquare (x:xs) row col currRow
  | currRow == row = forbidInRow x col 0: forbidSquare xs row col (currRow + 1)
  | otherwise = x : forbidSquare xs row col (currRow + 1)

placementsForK :: Integer -> [[Bool]] -> Integer -> Integer -> Integer -> Integer -> Integer
placementsForK k board x y m n 
    | x == m = 0    
    | k == 1 = placementsForOne board
    | not ((board !! fromInteger x) !! fromInteger y) = placementsForK k board newX newY m n
    | otherwise = placementsForK (k-1) (forbidRowAndColumn board x y 0) x y m n + 
    placementsForK k (forbidSquare board x y 0) newX newY m n
    where newY = if y == n-1 then 0 else y+1 
          newX = if y == n-1 then x+1 else x

getCoefficients :: [[Bool]] -> Integer -> Integer -> [Integer]
getCoefficients plansza m n = map (\x -> placementsForK x plansza 0 0 m n) [1.. (min m n)]

toBool :: Char -> Bool
toBool '1' = True
toBool '0' = False

rowToBool :: String -> [Bool]
rowToBool = map toBool 

parseBoard :: String -> [[Bool]]
parseBoard = map rowToBool . lines
--parseBoard board = map rowToBool (lines board)

convertToEquation :: [Integer] -> Integer -> String
convertToEquation [] _ = ""
convertToEquation (x:xs) powerExponent = show x ++ "*x^" ++ show powerExponent ++ 
    (if xs /= [] then " + " else "") ++ convertToEquation xs (powerExponent + 1)

main :: IO()
main = do
    putStrLn "Provide a filepath for file with a chessboard."
    file <- getLine
    board <- readFile file
    let parsedBoard = parseBoard board
    let polynomial = getCoefficients parsedBoard (toInteger (length parsedBoard)) (toInteger (length (head parsedBoard)))
    print ("r(x) = 1 + " ++ convertToEquation polynomial 1)

