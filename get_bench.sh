#!/bin/bash

set -eux

mkdir -p /work/benchmark
cd /work/benchmark

cwd=/work/benchmark

GOLEM_BENCH="https://github.com/blishko/chc-benchmarks"
GOLEM_COMMIT="200d7efc0b8621de19127f10715cec8c41ece363"

CHC_COMP="https://github.com/chc-comp/chc-comp23-benchmarks"
CHC_COMP_COMMIT="cca5a86a4939e406b714cb5a55f35a8a2f581a48"

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


##### CHC_COMP
cd $tmp_dir
git clone $CHC_COMP && cd chc-comp23-benchmarks && git checkout $CHC_COMP_COMMIT
find . -type f -name '*.gz' -exec gunzip {} +
mkdir -p $INPUTS/comp_LIA-nonlin $INPUTS/comp_LIA-lin $INPUTS/comp_ADT-LIA-nonlin
cp LIA-nonlin/*.smt2 $INPUTS/comp_LIA-nonlin
cp LIA-lin/*.smt2 $INPUTS/comp_LIA-lin
cp ADT-LIA-nonlin/*.smt2 $INPUTS/comp_ADT-LIA-nonlin
cd $INPUTS && find comp_LIA-nonlin -type f > $LISTS/comp_LIA-nonlin
cd $INPUTS && find comp_LIA-lin -type f > $LISTS/comp_LIA-lin
cd $INPUTS && find comp_ADT-LIA-nonlin -type f > $LISTS/comp_ADT-LIA-nonlin

echo "comp_LIA-lin" > $INPUTS/.gitignore
echo "comp_LIA-nonlin" >> $INPUTS/.gitignore
echo "comp_ADT-LIA-nonlin" >> $INPUTS/.gitignore


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
