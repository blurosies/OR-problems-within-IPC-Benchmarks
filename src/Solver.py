import re , os , sys
import argparse , subprocess, json


def runFD (domain, problem, FDpath, FDparameter):
    #seq-opt-lmcut
    #lama-first     
    m = {"search time":0.0, "generated states":0, "plan length":0}

    try:
        res= subprocess.run([FDpath,"--alias",FDparameter,domain, problem],capture_output=True, text=True, timeout=600)

        if res.returncode!=0:
            print("Error with FD execution, double check your paths", file=sys.stderr)
            sys.exit(1)

        output= res.stdout+res.stderr


        time = re.search(r"Total time:\s*([\d\.]+)s", output)
        states = re.search(r"Generated\s*(\d+)\s*state\(s\)", output)
        planLength = re.search(r"Plan length:\s*(\d+)\s*step\(s\)", output)

        if not time or not states or not planLength:
            print("Error with FD output, double check your files", file=sys.stderr)
            sys.exit(1)

        m["search time"] = float(time.group(1))
        m["generated states"] = int(states.group(1))
        m["plan length"] = int(planLength.group(1))

        return m
    
    except subprocess.TimeoutExpired: 
        #pb timed out here
        m["search time"] = 601
        m["generated states"] = -1
        m["plan length"] = 0

        return m




# update init state of next sub problem
def geteffects (domain,action):
    # 1st element is action name, rest are the action s args
    actiondecoupe= action.replace("(","").replace(")","").split()
    
    try:
        with open(domain, 'r') as f:
            content = f.read().lower()

            act = content.find(f"(:action {actiondecoupe[0]}")
            if act == -1:
                return [], []
            
            #finfing params and effects
            startP = content.find(":parameters", act)
            startE = content.find(":effect", act)

            endP = content.find(")", startP)
            # parenthesis parsing to find end of effects
            endE = startE

            started = False
            cpt=0
            for i in range(startE, len(content)):
                if content[i] == '(':
                    cpt += 1
                    started = True
                elif content[i] == ')':
                    cpt -= 1
                if started and cpt == 0:
                    endE = i + 1
                    break


            parameters=content[startP:endP+1]
            effects=content[startE:endE+1]

            var = re.findall(r'(\?[a-zA-Z0-9_-]+)', parameters)
            d = dict(zip(var, actiondecoupe[1:]))

            for var in sorted(var, key=len, reverse=True):
                effects = effects.replace(var, d[var])


            effects = effects.replace(":effect", "").strip()
            if effects.startswith("(and"):
                effects = effects[4:-1].strip() 

            l = []
            cpt2 = 0
            curr = ""
            for char in effects:
                curr += char
                if char == '(':
                    cpt2 += 1
                elif char == ')':
                    cpt2 -= 1
                    if cpt2 == 0:
                        l.append(curr.strip())
                        curr = ""
                        
            pos = []
            neg = []
            for elem in l:
                if elem.startswith("(not"):
                    neg.append(elem[4:-1].strip()) 
                else:
                    pos.append(elem)
            
            return pos, neg
            
    except IOError:
        print("geteffects: bad file")
        sys.exit(1)




def generatePDDLProblem(initMemory, effectsPos, header, output):
    initBlock = "\n        ".join(initMemory)
    
    # goal parag: effects of the abstract move
    goalBlock = "\n        ".join(effectsPos)

    if len(effectsPos) > 1:
        goal = f"(and\n        {goalBlock}\n    )"
    else:
        goal = goalBlock

    pddlProblem = f"""{header}
(:init
        {initBlock}
)
(:goal 
    {goal}
)
)"""
    with open(output, "w") as file:
        file.write(pddlProblem)
    










###################################################################################

if __name__ == "__main__": 

    parser = argparse.ArgumentParser()
    # compare arg: if we wish to compare this method with the original method, so it runs the problems with the devide and conquer method, saves everything to a json
    # then runs everything with the normal FD way and saves to another json, that gives us material for the compare algo, not a required option
    #if this argument is not provided, no json file will be generated
    parser.add_argument("--c", action="store_true")

    # SATTELITE NOT AVAILABLE
    parser.add_argument("domain", choices=["Depots", "Logistics", "miconic","satellite"])
    parser.add_argument("problem", type=str)
    parser.add_argument("FDparameter", type=str, choices=["lama-first", "seq-opt-lmcut"])

    args = parser.parse_args()

    # sorry i hard coded these paths, please replace with your own path to this folder
    originalDomain = f"/home/ange/OR-problems-within-IPC-Benchmarks/original_pbs/{args.domain}/domain.pddl"
    abstractDomain = f"/home/ange/OR-problems-within-IPC-Benchmarks/ABSd/{args.domain}/domain.pddl"
    problem = f"/home/ange/OR-problems-within-IPC-Benchmarks/original_pbs/{args.domain}/pb{args.problem}.pddl"
    FDpath="/home/ange/fast-downward/fast-downward.py"

    # Etape A
    mesuresEtapeA = runFD(abstractDomain, problem, FDpath, args.FDparameter)


    # Etape B
    # for each abstract move action, reconstruct the low lvl plan
    actions = []

    if os.path.exists("sas_plan"):
        with open("sas_plan", "r") as file:
            for line in file:
                cleanLine = line.strip().lower()
                if cleanLine and not cleanLine.startswith(";"):
                    actions.append(cleanLine)


        # getting content for the pddl micro pbs
        with open(problem, 'r') as file:
            content = file.read()
        #limit where we want to stop copying
        i=content.lower().find("(:init")
        j=content.lower().find("(:goal")
        header=content[:i]

        init_u=content[i+7:j].lower() # 7 bc the length of "(:init" and an empty space
        #then we need to filter 
        # it because some problems are formatted differently

        init = []
        cpt = 0
        currfact = ""
        
        for char in init_u:
            if char == '(':
                cpt += 1
            if cpt > 0:
                currfact += char
                
            if char == ')':
                cpt -= 1
                if cpt == 0:
                    if currfact.strip() != "":
                        init.append(currfact.strip())
                    currfact = ""

        #the elems have a tab included so stripping all empty charas for later (when we wanna update the memory)
        init = [fact.strip() for fact in init if fact.strip() != "" and fact.strip() != ")"]


        finalPlan = []
        searchTime=mesuresEtapeA["search time"]
        states=mesuresEtapeA["generated states"]
        moveNB=0


        for index, action in enumerate(actions):
            # print(f"\n[pb {index + 1}/{len(actions)}]: {action}")
            parts1 = action.replace("(", "").replace(")", "").split()
            plan = []
            
            if parts1[0] == "schedule":
                moveNB+=1
                filename = f"tempPb{index}.pddl"
                
                effectP, effectN = geteffects(abstractDomain, action)
                generatePDDLProblem(init, effectP, header, filename)

                mesures = runFD(originalDomain, filename,FDpath,args.FDparameter) 
                searchTime += mesures["search time"]
                states += mesures["generated states"]
                

                with open("sas_plan", "r") as file:
                    for line in file:
                        cleanLine = line.strip().lower()

                        if cleanLine and not cleanLine.startswith(";"):
                            plan.append(cleanLine)
                            finalPlan.append(cleanLine)
                    
                os.remove(filename)
                os.remove("sas_plan")
            else:
                plan.append(action)
                finalPlan.append(action)

            # update init
            for step in plan:

                positif, negatif = geteffects(originalDomain, step)
                
                for n in negatif:
                    if n in init:
                        init.remove(n)
                        
                for p in positif:
                    if p not in init:
                        init.append(p)


    # All results ############################################
        print(f"----------------------------------------------------------------------\n")
        print(f"Resolution for : {args.domain} problem number {args.problem}\n")
        print(f"Stats taken for Abstract resolution:\n \n \t {mesuresEtapeA} \n")
        print(f" Plan length: {len(actions)} \n Within this plan, there are {moveNB} move actions. \n \n")
        print("Stats taken for the final generated Plan")
        print(f"\nFinal Plan Length: {len(finalPlan)}")
        print(f"Total Planner Time: {searchTime} second(s)")
        print(f"Total generated states: {states}")

        
        with open(f"results/plans/plan{args.domain}{args.problem}.txt", "w") as file:
            for action in finalPlan:
                file.write(f"{action}\n")

        print(f"\n \n Final plan saved in \"plan{args.domain}{args.problem}.txt\" ")
        print(f"\n----------------------------------------------------------------------\n")
        ####################################################
    else:
        print("script did not find a plan")
        searchTime=601
        finalPlan=[]

    if args.c :

        problem_key = f"{args.domain}_{args.problem}"
        res = {
            "FD parameter": args.FDparameter,
            "time": searchTime,
            "planlength": len(finalPlan)
        }

        file = f"results/json/Script_{args.domain}_{args.FDparameter}.json"
        data = {}
        if os.path.exists(file):
            try:
                with open(file, "r") as json_file:
                    data = json.load(json_file)
            except json.JSONDecodeError:
                print("Error with existing Json file")

        data[problem_key] = res

        with open(file, "w") as json_file:
            json.dump(data, json_file, indent=4)
        print(f"Mesurement results saved in \"ScriptRes.json\"\n \n")





        print(f"Running Fast downward for problem {args.domain} {args.problem} \n")
        mesures2= runFD(originalDomain, problem, FDpath, args.FDparameter)

        res2 = {
            "FD parameter": args.FDparameter,
            "time": mesures2["search time"],
            "planlength": mesures2["plan length"]
        }

        file2 = f"results/json/FD_{args.domain}_{args.FDparameter}.json"
        data2 = {}
        if os.path.exists(file2):
            try:
                with open(file2, "r") as json_file2:
                    data2 = json.load(json_file2)
            except json.JSONDecodeError:
                print("Error with existing Json file")

        data2[problem_key] = res2

        with open(file2, "w") as json_file2:
            json.dump(data2, json_file2, indent=4)
        print(f"Mesurement results saved in \"FDRes.json\"\n \n")


    