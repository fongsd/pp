print :: String -> IO()
print s = putStrLn(s)

duplo :: Double -> Double
duplo d = d * d

ostatak3 :: Int -> Int
ostatak3 n = mod n 3 

korenCeli :: Int -> Float
korenCeli n = sqrt (fromIntegral n)


sumaN' :: Int -> Int
sumaN' n = 
    if n == 0 then 0 
        else n + sumaN'(n - 1)

suma :: Int -> Int
suma = \x -> x + sum[1,2..10]

add :: Int -> Int -> Int
add = \x y -> x + y