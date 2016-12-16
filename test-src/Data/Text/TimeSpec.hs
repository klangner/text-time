{-# LANGUAGE OverloadedStrings #-}
module Data.Text.TimeSpec (spec) where

import Data.Text.Lazy (toStrict)
import Data.Time
import Data.Time.Calendar.MonthDay
import Test.Hspec
import Test.QuickCheck

import Data.Text.Time



spec :: Spec
spec = do

  describe "Parse" $ do

    it "iso format: YYYY" $ do
        parseISODateTime "2014" `shouldBe` UTCTime (fromGregorian 2014 1 1) 0

    it "iso format: YYYY" $ do
        parseISODateTime "98" `shouldBe` UTCTime (fromGregorian 98 1 1) 0

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


  describe "Invariants" $ do

    it "is inverse to show" $ property $
        \x -> (parseISODateTime . toStrict . formatISODateTime) x == (x :: UTCTime)


instance Arbitrary UTCTime where
  arbitrary = do
      year <- choose (0, 10^4) :: Gen Integer
      month <- choose (1, 12) :: Gen Int
      day <- choose (1, monthLength False month) :: Gen Int
      seconds <- choose (0, 86399) :: Gen Int
      return $ UTCTime (fromGregorian year month day) (realToFrac seconds)
