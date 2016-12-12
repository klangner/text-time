{-# LANGUAGE OverloadedStrings #-}
module Data.ByteString.TimeSpec (spec) where

import Data.ByteString.Time
import Test.Hspec
import Data.Time ( UTCTime(..)
                 , fromGregorian
                 )



spec :: Spec
spec = do

  describe "Parsers" $ do

    it "iso year" $ do
        parseISODateTime "2014" `shouldBe` UTCTime (fromGregorian 1456 1 23) 4000
