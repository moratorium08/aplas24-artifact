#!/bin/bash

set -eux

mkdir -p /work/benchmark
cd /work/benchmark

cwd=/work/benchmark

GOLEM_BENCH="https://github.com/blishko/chc-benchmarks"
GOLEM_COMMIT="200d7efc0b8621de19127f10715cec8c41ece363"

CHC_COMP24="https://github.com/chc-comp/chc-comp24-benchmarks"
CHC_COMP_COMMIT24="1e8596fb798baafb55fb1a693afc31b12553d281"

HOPV="https://github.com/hopv/benchmarks"
HOPV_COMMIT="1bfed6143dc1f44aeddf8268759c2f357ce1e04f"

rm -rf inputs lists
mkdir -p inputs lists

INPUTS=$cwd/inputs
LISTS=$cwd/lists

tmp_dir=$(mktemp -d -t hopdr-XXXX)
if [ $? -ne 0 ]; then
    echo "Error: Failed to create temporary file."
    exit 1
fi

##### GOLEM
cd $tmp_dir
git clone $GOLEM_BENCH && cd chc-benchmarks && git checkout $GOLEM_COMMIT
cd transition_systems/multi-phase

mkdir -p $INPUTS/golem_safe $INPUTS/golem_unsafe
cp *.smt2 $INPUTS/golem_safe
cp unsafe/*.smt2 $INPUTS/golem_unsafe
cd $INPUTS && find golem_safe -type f > $LISTS/golem_safe
cd $INPUTS && find golem_unsafe -type f > $LISTS/golem_unsafe

##### CHC_COMP 24
cd $tmp_dir
git clone $CHC_COMP24 && cd chc-comp24-benchmarks && git checkout $CHC_COMP_COMMIT24
find . -type f -name '*.gz' -exec gunzip {} +
mkdir -p $INPUTS/24comp_LIA-Lin $INPUTS/24comp_LIA $INPUTS/24comp_ADT-LIA
cp LIA-Lin/*.smt2 $INPUTS/24comp_LIA-Lin
cp LIA/*.smt2 $INPUTS/24comp_LIA
cp ADT-LIA/*.smt2 $INPUTS/24comp_ADT-LIA
cd $INPUTS && find 24comp_LIA-Lin -type f > $LISTS/24comp_LIA-Lin
cd $INPUTS && find 24comp_LIA -type f > $LISTS/24comp_LIA
cd $INPUTS && find 24comp_ADT-LIA -type f > $LISTS/24comp_ADT-LIA

echo "24comp_LIA-Lin" >> $INPUTS/.gitignore
echo "24comp_LIA" >> $INPUTS/.gitignore
echo "24comp_ADT-LIA" >> $INPUTS/.gitignore

cp $INPUTS/.gitignore $LISTS/.gitignore


##### Higher-order 
cd $tmp_dir
git clone $HOPV && cd benchmarks && git checkout $HOPV_COMMIT

mkdir -p $INPUTS/ml-unsafe $INPUTS/nonlin-unsafe
cd clauses/lia/unsafe-aplas24
cp *.smt2 $INPUTS/nonlin-unsafe
cd -


cd caml/lia/unsafe
cp *.ml $INPUTS/ml-unsafe
cd -

cd $INPUTS && find ml-unsafe -type f > $LISTS/ml-unsafe
cd $INPUTS && find nonlin-unsafe -type f > $LISTS/nonlin-unsafe
