import re , os , sys
import argparse , subprocess


def runFD (domain, problem, FDpath):
    # modify the list to change FD args
    res= subprocess.run([FDpath,"--alias","lama-first",domain, problem],capture_output=True, text=True)

    if res.returncode!=0:
        print("Error with FD execution, double check your paths", file=sys.stderr)
        sys.exit(1)

    output= res.stdout+res.stderr

    m = {"search time":0.0, "generated states":0, "plan length":0}

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





# update init state of next problem
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
            # need parenthesis parsing to find end of effects
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
    parser.add_argument("domain", choices=["Depots", "Logistics", "miconic"])
    parser.add_argument("problem", type=str)
    args = parser.parse_args()

    originalDomain = f"/home/ange/OR-problems-within-IPC-Benchmarks/original_pbs/{args.domain}/domain.pddl"
    abstractDomain = f"/home/ange/OR-problems-within-IPC-Benchmarks/Routing/{args.domain}/domain.pddl"
    problem = f"/home/ange/OR-problems-within-IPC-Benchmarks/original_pbs/{args.domain}/pb{args.problem}.pddl"
    FDpath="/home/ange/fast-downward/fast-downward.py"
    


    # Etape A
    mesuresEtapeA = runFD(abstractDomain, problem, FDpath)


    # Etape B
    # for each abstract move action, reconstruct the low lvl plan
    actions = []

    #sas_plan exists
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

    init_u=content[i+7:j] # 7 bc the length of "(:init" and an empty space
    #then we need to filter it because some problems are formatted differently

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
        
        if parts1[0] == "move":
            moveNB+=1
            filename = f"tempPb{index}.pddl"
            
            effectP, effectN = geteffects(abstractDomain, action)
            generatePDDLProblem(init, effectP, header, filename)

            mesures = runFD(originalDomain, filename,FDpath) 
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

    print(f"\n \n Final plan saved in \"plan{args.domain}{args.problem}.txt\" ")
    print(f"\n----------------------------------------------------------------------\n")
    
    with open(f"plan{args.domain}{args.problem}.txt", "w") as file:
        for action in finalPlan:
            file.write(f"{action}\n")
            

    