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
time                 15.50 μs   (15.03 μs .. 16.06 μs)
                     0.994 R²   (0.988 R² .. 0.999 R²)
mean                 15.31 μs   (15.12 μs .. 15.63 μs)
std dev              807.1 ns   (499.3 ns .. 1.368 μs)
variance introduced by outliers: 62% (severely inflated)

benchmarking Time parsers/ByteString
time                 1.410 μs   (1.393 μs .. 1.436 μs)
                     0.998 R²   (0.996 R² .. 0.999 R²)
mean                 1.414 μs   (1.400 μs .. 1.432 μs)
std dev              50.96 ns   (33.99 ns .. 71.29 ns)
variance introduced by outliers: 49% (moderately inflated)
```

