{-# LANGUAGE OverloadedStrings #-}
module Data.Text.TimeSpec (spec) where

import Data.Text.Time
import Test.Hspec
import Data.Time


spec :: Spec
spec = do

  describe "Parse" $ do

    it "iso format: YYYY" $ do
        parseISODateTime "2014" `shouldBe` UTCTime (fromGregorian 2014 1 1) 0

    it "iso format: YYYY-MM" $ do
        parseISODateTime "2014-04" `shouldBe` UTCTime (fromGregorian 2014 4 1) 0

    it "iso format: YYYY-MM-DD" $ do
        parseISODateTime "2014-04-23" `shouldBe` UTCTime (fromGregorian 2014 4 23) 0

    it "iso format: YYYY-MM-DDTHH:MM:SS" $ do
        let t = timeOfDayToTime (TimeOfDay 12 34 56)
        parseISODateTime "2014-04-23T12:34:56" `shouldBe` UTCTime (fromGregorian 2014 4 23) t

    it "iso format: YYYY-MM-DD HH:MM:SS" $ do
        let t = timeOfDayToTime (TimeOfDay 12 34 56)
        parseISODateTime "2014-04-23 12:34:56" `shouldBe` UTCTime (fromGregorian 2014 4 23) t


  describe "Format" $ do

    it "to iso" $ do
        formatISODateTime (UTCTime (fromGregorian 2014 1 1) 13513) `shouldBe` "2014-01-01T03:45:13"

