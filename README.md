# APLAS24 Artifact

## Paper

Hiroyuki Katsura, Naoki Kobayashi, Ken Sakayori and Ryosuke Sato, 
"Mode-based Reduction from Validity Checking of Fixpoint Logic Formulas to Test-Friendly Reachability Problem", APLAS 2024

## Repository 

Original repository: https://github.com/hopv/hopdr

## Docker Image

The attached Docker image provides the environment for executing our tools and benchmark scripts.


### Files

Important files are located in the `/work` directory.

- hopdr: Source code for the implementation
- bin: Auxiliary binaries
- benchmark: Benchmark sets used in the evaluation of our paper
- ml2hfl: translator from ml programs to νHFL(Z) formulas


### Benchmark

Benchmark inputs are located in the `/work/benchmark` directory. 

```
root@3852c734e22e:/work# ls benchmark/
inputs  lists
root@3852c734e22e:/work# ls benchmark/lists/
comp_LIA  comp_LIA-Lin  golem_safe  golem_unsafe  ml-unsafe  nonlin-unsafe
```

The text files in the `lists` directory enumerate the paths to each input.
The following shows the correspondence between the notations in the paper and the file names:

- comp\_XXX: CHC-COMP Benchmark
- golem\_unsafe: AE-VAL unsafe
- ml-unsafe: Higher-order
- nonlin-unsafe: Mode



### How to run `bench.py`

`bench.py` is the script to run our evaluation. 
For example, the following command runs our solver on the golem\_unsafe benchmark

```
$ python3 bench.py --timeout=180 --json=golem_unsafe.json golem_unsafe
```

### Use `ModeHFL` directly

You can easily test our solver by using the check command.

```
root@d1113ea73c33:/work# check --chc --input benchmark/inputs/golem_unsafe/s_split_01.smt2
stats: Some(CounterStats { retry: 8001, recursion: 44010001, rand_int: 0 })
Verification Result: Invalid
```

If you want to find a counterexample of an OCaml program, you can use the check-infer command as shown below:

```
root@d1113ea73c33:/work# check-infer benchmark/inputs/ml-unsafe/ack-e.ml
Verification Result: Invalid
```
