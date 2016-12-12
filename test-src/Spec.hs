import Test.Hspec
import qualified Data.ByteString.TimeSpec


main :: IO ()
main = hspec $ do
  describe "Time" Data.ByteString.TimeSpec.spec
