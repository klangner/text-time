
import Criterion.Main
import Data.ByteString.Char8 as BS
import Data.Time
import Data.ByteString.Time


parseString :: String -> UTCTime
parseString str = parseTimeOrError True defaultTimeLocale "%Y-%m-%dT%H:%M:%S" str


parseByteString :: ByteString -> UTCTime
parseByteString str = parseTimeOrError True defaultTimeLocale "%Y-%m-%dT%H:%M:%S" (BS.unpack str)


main :: IO ()
main = defaultMain
    [ bgroup "Time parsers"
        [ bench "String"  $ nf parseString "2016-12-12T20:56:34"
        , bench "ByteString"  $ nf parseByteString (pack "2016-12-12T20:56:34")
        ]
    ]