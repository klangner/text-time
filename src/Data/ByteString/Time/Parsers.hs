
module Data.ByteString.Time.Parsers
    ( parseISODateTime
    , parseUTCTimeOrError
    ) where

-- import Prelude
import           Control.Applicative
import           Control.Monad (when)
import qualified Data.Attoparsec.Text as A
import           Data.Bits ((.&.))
import           Data.Char (isDigit, ord)
import qualified Data.Text as T
import           Data.Time ( Day
                           , UTCTime(..)
                           , fromGregorian
                           , fromGregorianValid
                           )


-- | Parse ISO date. If date can't be parsed then this function will return default value instead of error
-- Adapted from sqlite-simple package
parseISODateTime :: T.Text -> UTCTime
parseISODateTime str =
    case parseUTCTimeOrError str of
        Left _ -> defaultUTCTime
        Right dt -> dt


-- | Default time if date can't be parsed
defaultUTCTime :: UTCTime
defaultUTCTime = UTCTime (fromGregorian 1 1 1) 0


parseUTCTimeOrError :: T.Text -> Either String UTCTime
parseUTCTimeOrError = A.parseOnly getUTCTime

-- | Create UTCTime parser for ISO date time
-- This code is based on code from sqlite-simple package
--
getUTCTime :: A.Parser UTCTime
getUTCTime = do
    day  <- getDay
    time <- pure 0 --((A.char ' ' <|> A.char 'T') *> getTimeOfDay) <|> pure 0
    return (UTCTime day time)


-- | Date parser
getDay :: A.Parser Day
getDay = do
    yearStr <- A.takeWhile isDigit
    when (T.length yearStr < 4) (fail "year must consist of at least 4 digits")

    let year = toNum yearStr
    month <- (A.char '-' *> digits "month") <|> pure 1
    day   <- (A.char '-' *> digits "day") <|> pure 1
    case fromGregorianValid year month day of
      Nothing -> fail "invalid date"
      Just x  -> return $! x


toNum :: Num n => T.Text -> n
toNum = T.foldl' (\a c -> 10*a + digit c) 0
{-# INLINE toNum #-}

digit :: Num n => Char -> n
digit c = fromIntegral (ord c .&. 0x0f)
{-# INLINE digit #-}

digits :: Num n => String -> A.Parser n
digits msg = do
  x <- A.anyChar
  y <- A.anyChar
  if isDigit x && isDigit y
  then return $! (10 * digit x + digit y)
  else fail (msg ++ " is not 2 digits")
{-# INLINE digits #-}