#!/bin/bash

# Setup env
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate rl-env
echo "hello from $(python --version) in $(which python)"

algs="a2c"
lengths="2e7 4e7"
envs="BreakoutNoFrameskip-v4 PongNoFrameskip-v4 SeaquestNoFrameskip-v4"
# Run the experiments
for alg in $algs; do
  for len in $lengths; do
    for env in $envs; do
      cmd="$HOME/baselines/baselines/run.py --alg=$alg --env=$env --num_timesteps=$len --log_path=./logs/$env/$alg/$len --save_path=./models/$env/$alg/$len --save_interval=10000"
      echo $cmd
      python $cmd
      git add -A
      git commit -m "from Lambda with love"
      git push
    done
  done
done