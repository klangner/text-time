
import Criterion.Main
import Data.Time (UTCTime)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime)


main :: IO ()
main = defaultMain
--     [ bgroup "Big series"
--         [ bench "size"  $ nf TS.size bigSeries
--         , bench "valueAt"  $ nf (\xs -> TS.valueAt xs lastIndex) bigSeries
--         , bench "slice"  $ nf (\xs -> TS.valueAt (TS.slice xs (index 2) lastIndex) (index 1)) bigSeries
--         ]
--     ]