#!/bin/bash

d="/home/ange/OR-problems-within-IPC-Benchmarks/src/"
START=1
END=150

for i in $(seq $START $END); do
    pad=$(printf "%03d" $i)

    /usr/bin/python3 "$d/Solver.py" --c miconic $pad seq-opt-lmcut

    val Validate original_pbs/miconic/domain.pddl original_pbs/miconic/pb${pad}.pddl results/plans/planmiconic${pad}.txt
    
    echo -e "\n"
done