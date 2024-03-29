module W3 where

import Control.Monad
import Data.List
import Data.IORef
import System.IO

-- ATTENZION! Palauta vain tiedosto joka _kääntyy_. Tämä tarkoittaa
-- sitä että komennon "runhaskell W3Test.hs" pitää toimia. Yksittäiset
-- testit siis saavat olla menemättä läpi mutta testien ajamisen tulee
-- toimia.
--
-- Ei myöskään ole suositeltavaa poistaa tässä pohjassa olevia
-- tyyppiannotaatioita. Ne kertovat mikä funktion tyypin _pitää_ olla.
-- Jos saat tyyppivirheitä, vika on toteutuksessasi, ei tehtäväpohjan
-- mukana tulevissa tyypeissä.

-- Tehtävä 1: Määrittele operaatio hei, joka tulostaa kaksi riviä,
-- joista ensimmäinen on "HEI" ja toinen on "MAAILMA".

hei :: IO ()
hei = do
  putStrLn "HEI"
  putStrLn "MAAILMA"

-- Tehtävä 2: Määrittele operaatio tervehdi siten, että tervehdi nimi
-- tulostaa "HEI nimi"

tervehdi :: String -> IO ()
tervehdi s = do
  putStrLn $ "HEI "++s

-- Tehtävä 3: Määrittele operaatio tervehdi', joka lukee nimen
-- näppäimistöltä ja sitten tervehtii kuten edellisessä tehtävässä.

tervehdi' :: IO ()
tervehdi' = do
  s <- getLine
  putStrLn $ "HEI "++s

-- Tehtävä 4: Määrittele operaatio lueSanat n joka lukee käyttäjältä n
-- sanaa (yksi per rivi) ja palauttaa ne aakkosjärjestyksessä

lueSanat :: Int -> IO [String]
lueSanat 0 = return []
lueSanat n = do 
  s <- getLine
  t <- lueSanat (n-1)
  return $ sort $ s:t

-- Tehtävä 5: Määrittele operaatio lueKunnes f, joka lukee käyttäjältä
-- merkkijonoja ja palauttaa ne listana. Lukeminen lopetetaan kun f
-- palauttaa luetulle alkiolle True. (Sitä alkiota jolle f palauttaa
-- True ei liitetä listaan).

lueKunnes :: (String -> Bool) -> IO [String]
lueKunnes f = do
  line <- getLine  
  if f line  
      then return []  
      else do 
          rivit <- lueKunnes f
          return $ line  : rivit

-- Tehtävä 6: Määrittele operaatio printFibs n, joka tulostaa n
-- ensimmäistä fibonaccin lukua, yhden per rivi

printFibs :: Int -> IO ()
printFibs 0 = return ()
printFibs n = do 
  let fibs = map (show . fibonacci) [1..n]
  mapM_ putStrLn fibs


fibonacci :: Int -> Int
fibonacci n = fibonacci' 0 1 n

fibonacci' :: Int -> Int -> Int -> Int
fibonacci' a b 1 = b
fibonacci' a b n = fibonacci' b (a+b) (n-1)

-- Tehtävä 7: Määrittele operaatio isums n, joka lukee käyttäjältä n
-- lukua ja palauttaa niitten summan. Lisäksi jokaisen luvun jälkeen
-- tulostetaan siihenastinen summa luvuista.

isums :: Int -> IO Int
isums n = isums' n 0

isums' 0 prev_sum = return prev_sum
isums' n prev_sum = do
  line <- readLn
  let cur_sum =  line + prev_sum
  putStrLn $ show $ cur_sum
  isums' (n-1) cur_sum

-- Tehtävä 8: when on hyödyllinen funktio, mutta sen ensimmäien
-- argumentti on tyyppiä Bool. Toteuta whenM joka toimii samoin mutta
-- ehto on tyyppiä IO Bool.

whenM :: IO Bool -> IO () -> IO ()
whenM cond op = do
  foo <- cond
  if foo
    then
      op
    else
      return ()

-- Tehtävä 9: Toteuta funktio while ehto operaatio, joka suorittaa
-- operaatiota niin kauan kun ehto palauttaa True.
-- 
-- Esimerkkejä:
-- while (return False) (putStrLn "MAHDOTONTA")  -- ei tulosta mitään
-- 
-- let kysy :: IO Bool
--     kysy = do putStrLn "K/E?"
--               line <- getLine
--               return $ line == "K"
-- in while kysy (putStrLn "JEE!") 
--
-- Tämä tulostaa JEE niin kauan kuin käyttäjä vastaa K

while :: IO Bool -> IO () -> IO ()
while ehto op = do
  foo <- ehto
  if not foo
    then return ()
    else do
      op
      while ehto op

-- Tehtävä 10: Toteuta funktio debug, joka ottaa merkkijonon s ja
-- IO-operaation op, ja palauttaa IO-operaation joka tulostaa annetun
-- s, kutsuu op, ja tulostaa jälleen s. Lopuksi operaation pitäisi
-- palauttaa op:n palautusarvo.
--
-- Jos edellinen kuulostaa heprealta, tässä vaihtoehtoinen
-- tehtävänanto: (debug s op) toimii täsmälleen kuten op, mutta aluksi
-- ja lopuksi tulostetaan merkkijono s.
--
-- Esimerkkejä:
--   debug "MOI" (return 3)
--     - tulostaa kaksi riviä joilla lukee "MOI"
--     - tuottaa arvon 3
--   debug "HEI" getLine
--     1. tulostaa "HEI"
--     2. lukee käyttäjältä rivin
--     3. tulostaa "HEI"
--     4. tuottaa käyttäjän syöttämän rivin

debug :: String -> IO a -> IO a
debug s op = do
  putStrLn s
  foo <- op
  putStrLn s
  return foo

-- Tehtävä 11: Toteuta itse funktio mapM_. Saat käyttää (puhtaita)
-- listafunktioita ja listojen hahmontunnistusta

mymapM_ :: (a -> IO b) -> [a] -> IO ()
mymapM_ = undefined

-- Tehtävä 12: Toteuta itse funktio forM. Saat käyttää (puhtaita)
-- listafunktioita ja listojen hahmontunnistusta

myforM :: [a] -> (a -> IO b) -> IO [b]
myforM as f = undefined

-- Tehtävä 13: Joskus törmää IO-operaatioihin jotka palauttavat
-- IO-operaatiota. Esimerkiksi IO-operaatio joka palauttaa
-- IO-operaation joka palauttaa Intin on tyypiltään IO (IO Int).
--
-- Toteuta funktio tuplaKutsu, joka ottaa IO-operaation joka palauttaa
-- IO operaation. tuplaKutsu op palauttaa IO-operaation joka
--   1. kutsuu op
--   2. kutsuu op:n palauttamaa operaatiota
--   3. palauttaa tämän palauttaman arvon
--
-- Esimerkkejä: 
--   - tuplaKutsu (return (return 3)) on sama kuin return 3
--
--   - let op :: IO (IO [String])
--         op = do l <- readLn
--                 return $ replicateM l getLine
--     in tuplaKutsu op
--
--     toimii kuten
--
--     do l <- readLn
--        replicateM l getLine
--
-- Tämä tehtävä on siitä mielenkiintoinen että jos saat sen menemään
-- tyypintarkastuksesta läpi, se on lähes välttämättä oikein.

tuplaKutsu :: IO (IO a) -> IO a
tuplaKutsu op = undefined

-- Tehtävä 14: Monesti IO-operaatioita halutaan ketjuttaa. Toteuta
-- funktio yhdista joka toimii hieman kuten operaattori (.)
-- funktioille. yhdista siis ottaa operaation op1 tyyppiä
--     a -> IO b
-- ja operaation op2 tyyppiä
--     c -> IO a
-- ja arvon tyyppiä
--     c
-- ja palauttaa operaation op3 tyyppiä
--     IO b
-- op3 tekee tietenkin seuraavaa:
--   1. ottaa argumenttinsa (tyyppiä c) ja syöttää sen op2:lle
--   2. ottaa tämän lopputuloksen (tyyppiä a) ja syöttää sen op1:lle
--   3. palauttaa lopputuloksen (tyyppiä b)
--
-- Tämä tehtävä on siitä mielenkiintoinen että jos saat sen menemään
-- tyypintarkastuksesta läpi, se on lähes välttämättä oikein.

yhdista :: (a -> IO b) -> (c -> IO a) -> c -> IO b
yhdista op1 op2 c = undefined

-- Tehtävä 15: Tutustu modulin Data.IORef dokumentaatioon
-- <http://www.haskell.org/ghc/docs/latest/html/libraries/base/Data-IORef.html>
--
-- Toteuta funktio mkCounter, joka palauttaa operaatiot inc :: IO ()
-- ja get :: IO Int. Näitten operaatioitten tulee toimia yhteen seuraavasti:
--
-- 1. jos operaatiota inc ei ole ajettu kertaakaan, palauttaa get arvon 0
-- 2. operaation inc ajaminen kasvattaa seuraavien get-kutsujen palautusarvoa
--
-- Kyseessä on siis yksinkertainen tilallinen laskuri
-- 
-- Esimerkki mkCounterin toiminnasta (GHCi:ssä)
--  *W3> (inc,get) <- mkCounter
--  *W3> inc
--  *W3> inc
--  *W3> get
--  2
--  *W3> inc
--  *W3> inc
--  *W3> get
--  4


mkCounter :: IO (IO (), IO Int)
mkCounter = undefined

-- Tehtävä 16: Toteuta operaatio hFetchLines, joka hakee annetusta
-- tiedostoskahvasta rivit, joitten rivinumerot (rivinumerointi alkaa
-- 1:stä) ovat annetussa listassa. Voit olettaa että rivinumerolista
-- on nousevassa järjestyksessä.
--
-- Modulin System.IO dokumentaatio auttanee.

hFetchLines :: Handle -> [Int] -> IO [String]
hFetchLines h nums = undefined

-- Tehtävä 17: CSV on tiedostoformaatti, jossa taulukollinen arvoja on
-- tallenettu tiedostoon niin, että tiedoston yksi rivi vastaa
-- taulukon yhtä riviä, ja rivin alkiot on eroteltu ,-merkeillä.
--
-- Tee funktio readCSV joka lukee CSV-tiedoston listaksi listoja.
--
-- Huom! Funktiosi ei tarvitse osata käsitellä lainausmerkkejä,
-- kenoviivoja, eikä muitakaan erinäisten CSV-formaattien hienouksia.
-- Voit olettaa että jokainen kerkki , syötteessä on kentän raja.
--
-- Huom! Eri riveillä voi olla eri määrä kenttiä

readCSV :: FilePath -> IO [[String]]
readCSV path = undefined

-- Tehtävä 18: Toteuta operaatio compareFiles, joka saa kaksi
-- tiedostonimeä, a ja b. Tiedostojen sisältöjen haluttaisiin olevan
-- samat, mutta niissä on jotakin eroja. Siispä kun tiedostojen a ja b
-- rivit nro i poikkeavat toisistaan, tulostaa ohjelma:
--
-- < tiedoston a versio rivistä
-- > tiedoston b versio rivistä 
--
-- Esimerkki:
--
-- Tiedoston a sisältö:
-- a
-- aa
-- x
-- aa
-- bb
-- cc
--
-- Tiedoston b sisältö:
-- a
-- aa
-- bb
-- aa
-- cc
-- dd
-- 
-- Tulostus:
-- < x  
-- > bb
-- < bb 
-- > cc
-- < cc
-- > dd
--
-- Huom! Voit olettaa että tiedostoissa on sama määrä rivejä.
--
-- Vihje! Eroavien rivien löytäminen on hyödyllistä erottaa omaksi
-- puhtaaksi funktiokseen (jonka tyyppi voi olla vaikkapa [String] ->
-- [String] -> [String]).

compareFiles :: FilePath -> FilePath -> IO ()
compareFiles a b = undefined

-- Tehtävä 19: Tässä tehtävässä näet miten funktionaalisessa
-- ohjelmassa logiikan voi toteuttaa puhtaana funktiona, jota ympäröi
-- yksinkertainen IO-"ajuri".
--
-- Toteuta funktio interact', joka ottaa puhtaan funktion f tyyppiä
--   (String,a) -> (Bool,String,a)
-- ja alkutilan tyyppiä a ja palauttaa IO-operaation tyyppiä IO a
-- 
-- interact':n tulisi toimia niin että se lukee käyttäjältä rivin,
-- syöttää rivin ja tämänhetkisen tilan f:lle. f palauttaa booleanin,
-- tulosteen ja uuden tilan. f:n palauttama tuloste tulostetaan
-- ruudulle, ja jos palautettu boolean on True, jatketaan interact':n
-- suorittamista uudella tilalla. Jos palautettu boolean on False,
-- loppuu suoritus ja operaatio palauttaa lopputilan.
--
-- Esimerkki:
--
-- let f :: (String,Integer) -> (Bool,String,Integer)
--     f ("inc",n)   = (True,"",n+1)
--     f ("print",n) = (True,show n,n)
--     f ("quit",n)  = (False,"bye bye",n)
-- in interact' f 0
--

interact' :: ((String,a) -> (Bool,String,a)) -> a -> IO a
interact' f state = undefined

