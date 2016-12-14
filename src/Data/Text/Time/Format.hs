{-# LANGUAGE OverloadedStrings #-}

module Data.Text.Time.Format
    ( formatISODateTime
    ) where

import Data.Text.Lazy (Text)
import Formatting (format, (%))
import Formatting.Time (dateDash, hms)
import Data.Time ( UTCTime )


-- | Format ISO date.
formatISODateTime :: UTCTime -> Text
formatISODateTime utc = format (dateDash % "T" % hms) utc utc
