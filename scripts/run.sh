#!/bin/bash

if [[ $OSTYPE == "linux-gnu" && -z "$ASAN_RUN" ]]; then
  valgrind --error-exitcode=1 --leak-check=full --show-leak-kinds=all ./build/bin/core_func_tests
  valgrind --error-exitcode=1 --leak-check=full --show-leak-kinds=all ./build/bin/ref_func_tests

#  valgrind --error-exitcode=1 --leak-check=full --show-leak-kinds=all ./build/bin/omp_func_tests
  valgrind --error-exitcode=1 --leak-check=full --show-leak-kinds=all ./build/bin/seq_func_tests
  valgrind --error-exitcode=1 --leak-check=full --show-leak-kinds=all ./build/bin/stl_func_tests
#  valgrind --error-exitcode=1 --leak-check=full --show-leak-kinds=all ./build/bin/tbb_func_tests
fi

./build/bin/core_func_tests --gtest_also_run_disabled_tests --gtest_repeat=10 --gtest_recreate_environments_when_repeating
./build/bin/ref_func_tests  --gtest_also_run_disabled_tests --gtest_repeat=10 --gtest_recreate_environments_when_repeating

./build/bin/sample_omp
./build/bin/sample_stl
./build/bin/sample_tbb

#if [[ $OSTYPE == "linux-gnu" ]]; then
#    NUM_PROC=$(cat /proc/cpuinfo|grep processor|wc -l)
#elif [[ $OSTYPE == "darwin"* ]]; then
#    NUM_PROC=$(sysctl -a | grep machdep.cpu | grep thread_count | cut -d ' ' -f 2)
#else
#    echo "Unknown OS"
#    NUM_PROC="1"
#fi
#echo "NUM_PROC: " $NUM_PROC

./build/bin/omp_func_tests --gtest_also_run_disabled_tests --gtest_repeat=10 --gtest_recreate_environments_when_repeating
./build/bin/seq_func_tests --gtest_also_run_disabled_tests --gtest_repeat=10 --gtest_recreate_environments_when_repeating
./build/bin/stl_func_tests --gtest_also_run_disabled_tests --gtest_repeat=10 --gtest_recreate_environments_when_repeating
./build/bin/tbb_func_tests --gtest_also_run_disabled_tests --gtest_repeat=10 --gtest_recreate_environments_when_repeating
