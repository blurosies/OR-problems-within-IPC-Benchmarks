#!/bin/bash

d="/home/ange/OR-problems-within-IPC-Benchmarks/src/"
START=1
END=84

for i in $(seq $START $END); do
    pad=$(printf "%02d" $i)

    /usr/bin/python3 "$d/Solver.py" -c Logistics $pad lama-first

    val Validate original_pbs/Logistics/domain.pddl original_pbs/Logistics/pb${pad}.pddl results/plans/planLogistics${pad}.txt
    
    echo -e "\n"
done