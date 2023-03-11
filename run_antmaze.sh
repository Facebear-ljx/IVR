#!/bin/bash

# Script to reproduce results

sleep 10800

GPU_LIST=(0 1 2 3 4 5 6 7)

for seed in 0 1 2 3 4; do
for alg in "SQL" "EQL"; do

GPU_DEVICE=${GPU_LIST[task%${#GPU_LIST[@]}]}
CUDA_VISIBLE_DEVICES=$GPU_DEVICE python train_offline.py \
  --env_name "antmaze-umaze-v2" \
  --config=configs/antmaze_config.py \
  --alg $alg \
  --alpha 0.5 \
  --eval_interval 10000 \
  --eval_episodes 100 \
  --seed $seed &

sleep 20
let "task=$task+1"

GPU_DEVICE=${GPU_LIST[task%${#GPU_LIST[@]}]}
CUDA_VISIBLE_DEVICES=$GPU_DEVICE python train_offline.py \
  --env_name "antmaze-umaze-diverse-v2" \
  --config=configs/antmaze_config.py \
  --alg $alg \
  --alpha 5.0 \
  --eval_interval 10000 \
  --eval_episodes 100 \
  --seed $seed &

sleep 20
let "task=$task+1"

GPU_DEVICE=${GPU_LIST[task%${#GPU_LIST[@]}]}
CUDA_VISIBLE_DEVICES=$GPU_DEVICE python train_offline.py \
  --env_name "antmaze-medium-play-v2" \
  --config=configs/antmaze_config.py \
  --alg $alg \
  --alpha 0.5 \
  --eval_interval 10000 \
  --eval_episodes 100 \
  --seed $seed &

sleep 20
let "task=$task+1"

GPU_DEVICE=${GPU_LIST[task%${#GPU_LIST[@]}]}
CUDA_VISIBLE_DEVICES=$GPU_DEVICE python train_offline.py \
  --env_name "antmaze-medium-diverse-v2" \
  --config=configs/antmaze_config.py \
  --alg $alg \
  --alpha 0.5 \
  --eval_interval 10000 \
  --eval_episodes 100 \
  --seed $seed &

sleep 20
let "task=$task+1"

GPU_DEVICE=${GPU_LIST[task%${#GPU_LIST[@]}]}
CUDA_VISIBLE_DEVICES=$GPU_DEVICE python train_offline.py \
  --env_name "antmaze-large-play-v2" \
  --config=configs/antmaze_config.py \
  --alg $alg \
  --alpha 0.5 \
  --eval_interval 10000 \
  --eval_episodes 100 \
  --seed $seed &

sleep 20
let "task=$task+1"

GPU_DEVICE=${GPU_LIST[task%${#GPU_LIST[@]}]}
CUDA_VISIBLE_DEVICES=$GPU_DEVICE python train_offline.py \
  --env_name "antmaze-large-diverse-v2" \
  --config=configs/antmaze_config.py \
  --alg $alg \
  --alpha 0.5 \
  --eval_interval 10000 \
  --eval_episodes 100 \
  --seed $seed &

sleep 20
let "task=$task+1"

done
done