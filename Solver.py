import re , os
import argparse , subprocess

#TODO: make code more robust w error hadnling (for missing files & such)

# For etape A, simply runs FD
def runFD(domain, problem):

    #TODO:here i assume that fd is here, maybe change for later 
    result = subprocess.run(["/home/ange/fast-downward/fast-downward.py", "--alias", "lama-first", domain, problem ], capture_output=True, text=True)
    output = result.stdout + result.stderr
    
    m = {"search time":0.0, "generated states":0, "plan length":0}

    # looks at fast downward output for search time cause we only want the time the algo spent searching
    time = re.search(r"Search time:\s*([\d\.]+)s", output)
    m["search time"] = float(time.group(1))

    states = re.search(r"Generated\s*(\d+)\s*state\(s\)", output)
    m["generated states"] = int(states.group(1))
        
    planLength = re.search(r"Plan length:\s*(\d+)\s*step\(s\)", output)
    m["plan length"] = int(planLength.group(1))
        
    return m

# fct mal faite a refaire plus tard (ca fais longtemps que je n'ai pas fait du python )
def getEffects(domain, action):
    # first elem is the action name, rest are the args
    actiondecoupe = action.replace("(", "").replace(")", "").split()

    with open(domain, 'r') as f:
        content = f.read().lower()
        
    act = content.find(f"(:action {actiondecoupe[0]}")
    if act == -1:
        return [], []

    # parameeters of the action
    start = content.find(":parameters", act)
    end = content.find(")", start)
    str = content[start:end+1]
    
    var = re.findall(r'(\?[a-zA-Z0-9_-]+)', str)
    d = dict(zip(var, actiondecoupe[1:]))

    # effects of the action
    eStart = content.find(":effect", act)
    cpt = 0
    eEnd = eStart

    started = False
    for i in range(eStart, len(content)):
        if content[i] == '(':
            cpt += 1
            started = True
        elif content[i] == ')':
            cpt -= 1
        if started and cpt == 0:
            eEnd = i + 1
            break
            
    eStr = content[eStart:eEnd]

    #replacing w the real names that can be used in the micro pb
    for var in sorted(var, key=len, reverse=True):
        eStr = eStr.replace(var, d[var])


    eStr = eStr.replace(":effect", "").strip()
    if eStr.startswith("(and"):
        eStr = eStr[4:-1].strip() 

    l = []
    cpt2 = 0
    curr = ""
    for char in eStr:
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
    
(:goal 
    {goal}
)
)"""
    with open(output, "w") as file:
        file.write(pddlProblem)
    



if __name__ == "__main__": 

    parser = argparse.ArgumentParser()
    parser.add_argument("domain", choices=["Depots", "Logistics", "miconic"])
    parser.add_argument("problem", type=str)
    args = parser.parse_args()

    originalDomain = f"/home/ange/OR-problems-within-IPC-Benchmarks/original_pbs/{args.domain}/domain.pddl"
    abstractDomain = f"/home/ange/OR-problems-within-IPC-Benchmarks/Routing/{args.domain}/domain.pddl"
    problem = f"/home/ange/OR-problems-within-IPC-Benchmarks/original_pbs/{args.domain}/pb{args.problem}.pddl"
    

    # Etape A
    mesuresEtapeA = runFD(abstractDomain, problem)

    # the time, plan length and gen states for solving the pb with an abstract ver of PDP
    print(f"Results: {mesuresEtapeA}")


    # Etape B
    # for each abstract move action, reconstruct the low lvl plan
    actions = []

    #sas_plan exists
    with open("sas_plan", "r") as file:
        for line in file:
            cleanLine = line.strip().lower()
            if cleanLine and not cleanLine.startswith(";"):
                actions.append(cleanLine)

    print(f" Plan len for abstract PDP: {len(actions)}")


    # getting content for the pddl micro pbs

    with open(problem, 'r') as file:
        content = file.read()
    #limit where we want to stop copying
    i=content.lower().find("(:init")
    j=content.lower().find("(:goal")
    header=content[:i]

    init=content[i+7:j] # 7 bc the length of "(:init" and an empty space
    init=init.split("\n")

    #the elems have a tab included so stripping all empty charas for later (when we wanna update the memory)
    init = [fact.strip() for fact in init if fact.strip() != ""]


    finalPlan = []
    searchTime=mesuresEtapeA["search time"]
    states=mesuresEtapeA["generated states"]


    for index, action in enumerate(actions):
        print(f"\n[pb {index + 1}/{len(actions)}]: {action}")
        parts1 = action.replace("(", "").replace(")", "").split()
        plan = []
        
        if parts1[0] == "move":
            filename = f"tempPb{index}.pddl"
            
            effectP, effectN = getEffects(abstractDomain, action)
            generatePDDLProblem(init, effectP, header, filename)

            mesures = runFD(originalDomain, filename) 
            searchTime += mesures["search time"]
            states += mesures["generated states"]
            

            with open("sas_plan", "r") as file:
                for line in file:
                    cleanLine = line.strip().lower()

                    if cleanLine and not cleanLine.startswith(";"):
                        # gerer les doublons
                        if not (cleanLine.startswith("(drop") or cleanLine.startswith("(lift")):
                            plan.append(cleanLine)
                            finalPlan.append(cleanLine)
                    
            os.remove(filename)
            os.remove("sas_plan")
        else:
            plan.append(action)
            finalPlan.append(action)


        # update init
        for step in plan:

            positif, negatif = getEffects(originalDomain, step)
            
            for n in negatif:
                if n in init:
                    init.remove(n)
                    
            for p in positif:
                if p not in init:
                    init.append(p)


    print(f"\nFinal Plan Length: {len(finalPlan)}")
    print(f"Total Search Time: {searchTime}")
    print(f"Total generated states: {states}")
    
    with open(f"plan{args.domain}{args.problem}.txt", "w") as file:
        for action in finalPlan:
            file.write(f"{action}\n")
            

    