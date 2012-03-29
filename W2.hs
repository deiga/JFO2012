module W2 where

import Data.List
import Data.Char

-- Tehtävä 1: Määrittele vakio vuodet, jonka arvo on lista jossa on
-- arvot 1982, 2004, 2012 tässä järjestyksessä.

vuodet = [1982,2004,2012]

-- Tehtävä 2: Toteuta funktio measure, joka palauttaa tyhjälle
-- listalle -1 ja muuten listan pituuden

measure :: [String] -> Int
measure [] = -1
measure ss = length ss

-- Tehtävä 3: Toteuta funktio takeFinal, joka palauttaa listan viimeiset n alkiota

takeFinal :: Int -> [Int] -> [Int]
takeFinal _ [] = []
takeFinal 0 _  = []
takeFinal n xs = reverse (take n (reverse xs))

-- Tehtävä 4: Toteuta funktio remove, joka poistaa annetun listan
-- n:nnen alkion. Tarkemmin ottaen remove palauttaa uuden listan, joka
-- on muuten sama kuin syöte, mutta indeksissä n ollut alkio puuttuu.
--
-- Huom! indeksit alkavat nollasta
--
-- Esimerkkejä:
-- remove 0 [1,2,3]    ==>  [2,3]
-- remove 2 [4,5,6,7]  ==>  [4,5,7]
--
-- Muista! removen tyypissä esiintyvä [a] tarkoittaa "kaikentyyppiset
-- listat"


remove :: Int -> [a] -> [a]
remove i xs = take (i) xs ++ drop (i+1) xs

-- Tehtävä 5: Toteuta funktio substring i n s, joka palauttaa
-- merkkijonon s indeksistä i alkavan n:n pituisen alimerkkijonon.

-- Muista! merkkijonot ovat listoja

substring :: Int -> Int -> String -> String
substring i n s = take n (drop i s )

-- Tehtävä 6: Määrittele funktio mymax, joka ottaa argumenteikseen
-- mittausfunktion tyyppiä a -> Int ja kaksi alkiota tyyppiä a.
-- mymax palauttaa sen alkioista, jolle mittausfunktio palauttaa
-- suuremman arvon. Esimerkkejä:
--
--  mymax (*2)   3       5      ==>  5
--  mymax length [1,2,3] [4,5]  ==>  [1,2,3]
--  mymax head   [1,2,3] [4,5]  ==>  [4,5]  

mymax :: (a -> Int) -> a -> a -> a
mymax measure a b
  | measure a > measure b = a
  | measure b > measure a = b

-- Tehtävä 7: Määrittele funktio countSorted, joka laskee montako
-- sille annetuista merkkijonoista on aakkosjärjestyksessä.
--
-- Muista funktiot length, filter ja sort.

countSorted :: [String] -> Int
countSorted ss = length (filter sorted ss)
  where sorted xs = xs == sort xs

-- Tehtävä 8: Määrittele funktio hassu, joka ottaa syötteenään listan
-- merkkijonoja, ja palauttaa yhden merkkijonon, joka sisältää
-- välilyönnein eroteltuina syötelistan ne merkkijonot, joitten pituus
-- on yli 5. Lisäksi tulosmerkkijonon tulevat kirjaimet tulee muuttaa
-- isoiksi kirjaimiksi.
--
-- Näistä funktioista voi olla hyötyä:
--  - toUpper :: Char -> Char   modulista Data.Char
--  - intercalate               modulista Data.List

hassu :: [String] -> String
hassu strings = intercalate " " (map  firstUpper  (filter overFive strings))
  where overFive xs = length xs > 5
        firstUpper :: String -> String
        firstUpper [] = []
        firstUpper (x:xs) = toUpper(x) : firstUpper(xs)

-- Tehtävä 9: Toteuta "quicksort", eli rekursiivinen
-- lajittelualgoritmi joka toimii seuraavasti:
--
--  - Tyhjä lista on rekursion pohjatapaus: se on jo järjestyksessä
--  - Epätyhjästä listasta otetaat ensimmäinen alkio "pivot" ja
--    - otetaan listasta alkiot jotka ovat pienempiä kuin pivot
--    - otetaan listasta alkiot jotka ovat suurempia _tai_yhtäsuuria_ kuin pivot
--    - järjestetään nämä listat käyttämällä rekursiota
--    - yhdistetään pivot sekä järjestetyt listat yhdeksi järjestetyksi listaksi
--
-- PS. quicksort on lainausmerkeissä koska oikean quicksortin ideana
-- on se, että jakaminen pivottia isompiin ja pienempiin alkioihin
-- tapahtuu "in-place", käyttämättä lisätilaa.

quicksort :: [Int] -> [Int]
quicksort xs = undefined

-- Tehtävä 10: Määrittele funktio powers k max, joka palauttaa
-- (järjestetyn) listan kaikista k:n potensseista, jotka ovat
-- arvoltaan korkeintaan max. Siis esimerkiksi:
--
-- powers 2 5 ==> [1,2,4]
-- powers 3 30 ==> [1,3,9,27]
-- powers 2 2 ==> [1,2]
--
-- Vihjeitä:
--   * n^max > max
--   * takeWhile

powers :: Int -> Int -> [Int]
powers n max = undefined

-- Tehtävä 11: Tee funktio search, joka ottaa argumenteikseen
-- alkuarvon, päivitysfunktion ja lopetusehdon. Search käyttää
-- päivitysfunktiota alkuarvoon toistuvasti, kunnes lopetusehto
-- palauttaa True saadulle arvolle. Tällöin palautetaan saatu arvo.
--
-- Esimerkkejä:
--   search (+1) even 0   ==>   0
--
--   search (+1) (>4) 0   ==>   5
--
--   let check [] = True 
--       check ('A':xs) = True
--       check _ = False
--   in search tail check "xyzAvvt" 
--     ==> Avvt

search :: (a->a) -> (a->Bool) -> a -> a
search f p x = undefined

-- Tehtävä 12: Määrittele funktio fromTo n k, joka tuottaa listan
-- luvuista n..k. Rakenna lista itse, käyttämällä :-operaattoria.

fromTo :: Int -> Int -> [Int]
fromTo n k = undefined

-- Tehtävä 13: Määrittele funktio sums i, joka tuottaa listan
-- [1, 1+2, 1+2+3, .., 1+2+..+i]

sums :: Int -> [Int]
sums i = undefined

-- Tehtävä 14: Määrittele rekursiota ja listojen hahmonsovitusta
-- käyttäen funktio mylast, joka palauttaa listan viimeisen alkion tai
-- tyhjälle listalle annetun oletusarvon. Esimerkkejä:
--   mylast 0 [] ==> 0
--   mylast 0 [1,2,3] ==> 3

mylast :: a -> [a] -> a
mylast def xs = undefined

-- Tehtävä 15: Määrittele funktio sorted :: [Int] -> Bool, joka
-- tarkastaa, onko annettu lista nousevassa suuruusjärjestyksessä.
-- Käytä listojen hahmonsovitusta ja rekursiota, älä valmiita
-- listafunktioita.

sorted :: [Int] -> Bool
sorted xs = undefined

-- Tehtävä 16: Määrittele funktio sumsOf, joka laskee annetun listan
-- juoksevat summat näin:
--   sumsOf [a,b,c]  ==>  [a,a+b,a+b+c]
--   sumsOf [a,b]    ==>  [a,a+b]
--   sumsOf []       ==>  []
-- Käytä listojen hahmontunnistusta ja rekursiota, älä valmiita listafunktioita.

sumsOf :: [Int] -> [Int]
sumsOf xs = undefined

-- Tehtävä 17: Määrittele funktio mymaximum, joka palauttaa listan
-- suurimman arvon. mymaximumille kuitenkin annetaan parametrina
-- oletusarvo (joka palautetaan jos lista on tyhjä) ja vertailufunktio
-- (tyyppiä a -> a -> Ordering).
--
-- Esimerkkejä:
--   mymaximum compare (-1) [] ==> -1
--   mymaximum compare (-1) [1,3,2] ==> 3
--   let comp 0 0 = EQ
--       comp _ 0 = LT
--       comp 0 _ = GT
--       comp x y = compare x y
--   in mymaximum comp 1 [1,4,6,100,0,3]
--     ==> 0

mymaximum :: (a -> a -> Ordering) -> a -> [a] -> a
mymaximum cmp def xs = undefined


-- Tehtävä 18: Määrittele funktio map2 käyttäen rekursiota. Funktio
-- toimii kuten map, mutta kaksiargumenttiselle funktiolle ja kahdelle
-- listalle. Siis:
--   map2 f [x,y,z,w] [a,b,c]  ==> [f x a, f y b, f z c]
--
-- PS. tämä funktio on itseasiassa standardikirjastossa nimellä
-- zipWith.

map2 :: (a -> b -> c) -> [a] -> [b] -> [c]
map2 f as bs = undefined

-- Tehtävä 19: Tee "komentotulkki" seuraavalla tavalla: määrittele
-- funktio laskuri :: [String] -> [String], joka saa syötteenään
-- listan komentoja, ja tuottaa listan tulosteita. Komennot ovat:
--
-- incA -- kasvata laskuria a yhdellä
-- incB -- kasvata laskuria b yhdellä
-- decA -- vähennä laskura b yhdellä
-- decB -- vähennä laskura b yhdellä
-- printA -- tulosta laskurin a arvo
-- printB -- tulosta laskurin b arvo
--
-- Kummatkin laskurit ovat alussa 0. Funktiosi tulisi toimia siis
-- seuraavasti:
--
-- laskuri ["incA","incA","incA","printA","decA","printA"] ==> ["3","2"]
-- laskuri ["incA","incB","incB","printA","printB"] ==> ["1","2"]
--
-- YLLÄTYS! kun olet toteuttanut funktion laskuri, aja seuraava lauseke ghci:ssä:
--     interact (unlines . laskuri . lines)
-- ja kirjoita komentoja rivinvaihdoilla eroteltuna (control-c lopettaa)
--
-- HUOM! yllätys ei välttämättä toimi jos olet toteuttanut laskurisi
-- oikein mutta kummallisesti :(

laskuri :: [String] -> [String]
laskuri commands = undefined

-- Tehtävä 20: Tee funktio squares :: Int -> [Integer], joka palauttaa
-- n pienintä neliötä (eli lukua joka on muotoa x*x) jotka alkavat ja
-- päättyvät samalla numerolla.
--
-- Esimerkki: squares 9 ==> [1,4,9,121,484,676,1521,1681,4624]

squares :: Int -> [Integer]
squares n = undefined
