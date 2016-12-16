{-# LANGUAGE OverloadedStrings #-}

-- | This code is adapted from sqlite-simple package
module Data.Text.Time.Parse
    ( parseISODateTime
    , parseUTCTimeOrError
    ) where

import           Control.Applicative
import           Control.Monad (when)
import qualified Data.Attoparsec.Text as A
import           Data.Bits ((.&.))
import           Data.Char (isDigit, ord)
import qualified Data.Text as T
import           Data.Time ( Day
                           , TimeOfDay
                           , UTCTime(..)
                           , fromGregorian
                           , fromGregorianValid
                           , makeTimeOfDayValid
                           , midnight
                           , timeOfDayToTime
                           )


-- | Parse ISO date. If date can't be parsed then this function will return default value instead of error
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
    time <- ((A.char ' ' <|> A.char 'T') *> getTimeOfDay) <|> pure midnight
    let time' = timeOfDayToTime time
    return (UTCTime day time')


-- | Date parser
getDay :: A.Parser Day
getDay = do
    yearStr <- A.takeWhile isDigit

    let year = toNum yearStr
    month <- (A.char '-' *> digits "month") <|> pure 1
    day   <- (A.char '-' *> digits "day") <|> pure 1
    case fromGregorianValid year month day of
      Nothing -> fail "invalid date"
      Just x  -> return $! x


getTimeOfDay :: A.Parser TimeOfDay
getTimeOfDay = do
    hour   <- digits "hours"
    _      <- A.char ':'
    minute <- digits "minutes"
    -- Allow omission of seconds.  If seconds is omitted, don't try to
    -- parse the sub-second part.
    (sec,subsec)
           <- ((,) <$> (A.char ':' *> digits "seconds") <*> fract) <|> pure (0,0)

    let picos' = sec + subsec

    case makeTimeOfDayValid hour minute picos' of
      Nothing -> fail "invalid time of day"
      Just x  -> return $! x

    where
      fract =
        (A.char '.' *> (decimal <$> A.takeWhile1 isDigit)) <|> pure 0


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

decimal :: Fractional a => T.Text -> a
decimal str = toNum str / 10^(T.length str)
{-# INLINE decimal #-}