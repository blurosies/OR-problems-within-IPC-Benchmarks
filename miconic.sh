#!/bin/bash

d="/home/ange/OR-problems-within-IPC-Benchmarks"
START=1
END=150

for i in $(seq $START $END); do
    pad=$(printf "%03d" $i)

    /usr/bin/python3 "$d/Solver.py" miconic $pad

    val Validate original_pbs/miconic/domain.pddl original_pbs/miconic/pb${pad}.pddl planmiconic${pad}.txt
    
    echo -e "\n"
done