#!/bin/bash

set -eux

rm -rf ./hopdr
mkdir -p hopdr

git clone https://github.com/hopv/hopdr
cd hopdr
git checkout 15cebf0ca2eef344b7e073420694aecd8bbd0119
cd ..

git clone https://github.com/moratorium08/hflmc2

#cd hopdr/hopdr
#cargo test
#cargo build

