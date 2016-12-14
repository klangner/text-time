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
ghc -O2 -rtsopts --make -i../src -outputdir output -o output/bench Benchmarks.hs
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
benchmarking Time parsers/String
time                 14.97 μs   (14.90 μs .. 15.12 μs)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 14.96 μs   (14.92 μs .. 15.03 μs)
std dev              172.4 ns   (85.98 ns .. 275.0 ns)

benchmarking Time parsers/ByteString
time                 1.454 μs   (1.451 μs .. 1.457 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 1.457 μs   (1.454 μs .. 1.461 μs)
std dev              9.828 ns   (6.512 ns .. 16.24 ns)
```

