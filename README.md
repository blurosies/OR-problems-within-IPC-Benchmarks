# OR-problems-within-IPC-Benchmarks

How to use the generator:

Compilation:

            javac -d bin Routing/PDP/Generator.java

Execution: 

            java -cp bin Routing.PDP.Generator <problem name> <problem quantity (int)> <Graph mode (complet/cercle/random)>



How to use the miconic path finder: (later on, general path finder)

Compilation:

            javac -d bin Solver.java

Execution: 

            java -cp bin Solver <problem name>
            
note: the problem in question has to be one of the original miconic problems from the IPC competition (found in original_pbs/Elevator/). 

Do not write the path name while executing, only the problem name:


Example: 

            java -cp bin Solver pb150
            
            
