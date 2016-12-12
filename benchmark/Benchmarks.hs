
import Criterion.Main
import Data.ByteString
import Data.Time
import Data.ByteString.Time


main :: IO ()
main = defaultMain
    [ bgroup "Time parsers"
        [ bench "Haskell String"  $ nf parseTimeOrError True defaultTimeLocale "%Y-%m-%dT%H:%M:%S" "2016-12-12T20:56:34"
--         , bench "ByteString"  $ nf TS.size bigSeries
        ]
    ]