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

    it "iso format: YYYY" $ do
        parseISODateTime "2014" `shouldBe` UTCTime (fromGregorian 2014 1 1) 0

    it "iso format: YYYY-MM" $ do
        parseISODateTime "2014-04" `shouldBe` UTCTime (fromGregorian 2014 4 1) 0

    it "iso format: YYYY-MM-DD" $ do
        parseISODateTime "2014-04-23" `shouldBe` UTCTime (fromGregorian 2014 4 23) 0
