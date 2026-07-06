# OR-problems-within-IPC-Benchmarks

How to use the generator:

Compilation:

            javac -d bin Routing/PDP/Generator.java

Execution: 

            java -cp bin Routing.PDP.Generator <problem name> <problem quantity (int)> <Graph mode (complet/cercle/random)>



How to use the solver 

            args: Domain, problem number

Validator command:
            source ~/planning_env/bin/activate
            source ~/planning_env/bin/planutils_activate
            val Validate original_pbs/(DOMAIN)/domain.pddl original_pbs/(DOMAIN)/PROBLEM.pddl <PLAN>.txt

            
