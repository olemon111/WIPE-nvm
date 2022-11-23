#!/usr/bin/env bash
mkdir -p build
cd build
rm -rf *
cmake -DSERVER:BOOL=ON .. # build on server
make -j16
cd ..
# # benchmark
# chmod +x ./tests/run_benchmark.sh
# sudo ./tests/run_benchmark.sh

chmod +x ./tests/run_multi_bench.sh
sudo ./tests/run_multi_bench.sh

# chmod +x ./tests/run_microbench.sh
# sudo ./tests/run_microbench.sh