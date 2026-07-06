#!/bin/bash

d="/home/ange/OR-problems-within-IPC-Benchmarks"
START=1
END=22

for i in $(seq $START $END); do
    pad=$(printf "%02d" $i)

    /usr/bin/python3 "$d/Solver.py" Depots $pad

    val Validate original_pbs/Depots/domain.pddl original_pbs/Depots/pb${pad}.pddl planDepots${pad}.txt
    
    echo -e "\n"
done