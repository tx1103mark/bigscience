#!/bin/bash
#SBATCH --job-name=oscar-fast-shuffle      # job name
#SBATCH --ntasks=1                   # number of MP tasks
#SBATCH --nodes=1
#SBATCH --cpus-per-task=40           # number of cores per tasks
#SBATCH --gres=gpu:0                 # number of gpus
#SBATCH --hint=nomultithread         # we get physical cores not logical
#SBATCH --time=20:00:00              # maximum execution time (HH:MM:SS)
#SBATCH --output=%x-%j.out          # output file name
#SBATCH --error=%x-%j.out           # error file name (same to watch just one file)
#SBATCH --account=six@cpu

set -x -e

source $six_ALL_CCFRWORK/start-prod

# must set tmp to SCRATCH to be fast
export TMPDIR=$six_ALL_CCFRSCRATCH/tmp
mkdir -p $TMPDIR

# memory to use in GBs float
export MEMORY=150.0

input=oscar.jsonl
output=oscar-shuffled.jsonl

cd $six_ALL_CCFRSCRATCH/datasets/oscar-small
/usr/bin/time -v $six_ALL_CCFRWORK/bin/terashuf < $input > $output