cat fs-watchdog.slurm
#!/bin/bash
#SBATCH --job-name=tr6f-1B3-prefix-lm  # job name
#SBATCH --ntasks=1                   # number of MP tasks
#SBATCH --nodes=1                    # number of nodes
#SBATCH --cpus-per-task=1            # number of cores per task
#SBATCH --hint=nomultithread         # we get physical cores not logical
#SBATCH --time=2:00:00               # maximum execution time (HH:MM:SS)
#SBATCH --output=%x-%j.out           # output file name
#SBATCH --partition=compil
#SBATCH --account=six@cpu

echo "START TIME: $(date)"

source $six_ALL_CCFRWORK/start-prod
module load git-lfs

DATA_OUTPUT_PATH=$six_ALL_CCFRSCRATCH/checkpoints/tr6f-1B3-oscar-no-loss-on-targets-only
CHECKPOINT_PATH=$DATA_OUTPUT_PATH/checkpoints
REPO_PATH=$DATA_OUTPUT_PATH/tr6f-1B3-oscar-no-loss-on-targets-only-logs

BIG_SCIENCE_REPO_PATH=$DATA_OUTPUT_PATH/code/bigscience

$BIG_SCIENCE_REPO_PATH/tools/hub-sync.py --repo-path $REPO_PATH --patterns 'tensorboard/*tfevents*' 'codecarbon/*.csv' 'logs/*.txt' -d

echo "END TIME: $(date)"

