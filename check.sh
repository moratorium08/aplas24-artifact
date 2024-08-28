#!/bin/bash

cd /work/hopdr/hopdr

cargo build --release
cargo test
./test.sh
