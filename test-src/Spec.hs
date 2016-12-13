import Test.Hspec
import qualified Data.Text.TimeSpec


main :: IO ()
main = hspec $ do
  describe "Time" Data.Text.TimeSpec.spec
