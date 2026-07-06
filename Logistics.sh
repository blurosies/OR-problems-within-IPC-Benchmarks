#!/bin/bash

d="/home/ange/OR-problems-within-IPC-Benchmarks"
START=1
END=84

for i in $(seq $START $END); do
    pad=$(printf "%02d" $i)

    /usr/bin/python3 "$d/Solver.py" Logistics $pad

    val Validate original_pbs/Logistics/domain.pddl original_pbs/Logistics/pb${pad}.pddl planLogistics${pad}.txt
    
    echo -e "\n"
done