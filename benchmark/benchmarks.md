# Benchmarking the library

Install criterion package

```sh
cabal update
cabal install -j --disable-tests criterion
```

Create folder for the temporary files

```sh
cd benchamrk
mkdir output
```

Build the benchmarking application.

```sh
ghc -O -rtsopts --make -i../src -outputdir output -o output/bench Benchmarks.hs
```

Run performance tests

```sh
output/bench --output output/bench.html +RTS -T
```

Browse the results

```sh
firefox output/bench.html
```

## Latest benchmark:

```
benchmarking Time parsers/Haskell String
benchmarking Time parsers/String
time                 14.83 μs   (14.78 μs .. 14.90 μs)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 15.01 μs   (14.91 μs .. 15.25 μs)
std dev              516.9 ns   (273.3 ns .. 942.8 ns)
variance introduced by outliers: 40% (moderately inflated)

benchmarking Time parsers/ByteString
time                 14.98 μs   (14.93 μs .. 15.04 μs)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 15.04 μs   (14.96 μs .. 15.23 μs)
std dev              388.7 ns   (174.9 ns .. 712.4 ns)
variance introduced by outliers: 28% (moderately inflated)
```

