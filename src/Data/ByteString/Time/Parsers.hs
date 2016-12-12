
module Data.ByteString.Time.Parsers
    ( parseISODateTime
    ) where

import Prelude
import Data.ByteString (ByteString)
import Data.Time ( UTCTime(..)
                 , fromGregorian
                 )


parseISODateTime :: ByteString -> UTCTime
parseISODateTime _ = UTCTime (fromGregorian 1456 1 23) 4000