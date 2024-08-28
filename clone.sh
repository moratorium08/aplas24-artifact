#!/bin/bash

set -eux

rm -rf ./hopdr
mkdir -p hopdr

git clone https://github.com/hopv/hopdr
cd hopdr
git checkout 15cebf0ca2eef344b7e073420694aecd8bbd0119
cd ..

git clone https://github.com/moratorium08/hflmc2

cd /work/hopdr/hopdr && cargo build --release


cd /work
git clone https://github.com/moratorium08/ml2hfl
cd ml2hfl

eval $(opam env)
opam switch create 4.08.1
eval $(opam env --switch=4.08.1)
cp parser_wrapper_4.08.ml parser_wrapper.ml
opam install -y dune batteries re2 yojson ppx_deriving core fmt
dune build ./ml2hfl.exe
opam switch remove 4.08.1
cp _build/default/ml2hfl.exe /work/bin
