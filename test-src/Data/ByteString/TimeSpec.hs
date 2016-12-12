module Data.TimeSeries.TimeSpec (spec) where

import Data.ByteString.Time
import Test.Hspec


spec :: Spec
spec = do

  describe "Parsers" $ do

    it "iso year" $ do
        parseISODateTime "2014" `shouldBe` 3
