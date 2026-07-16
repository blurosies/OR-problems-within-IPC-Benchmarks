import argparse, json
import matplotlib.pyplot as plt
import re , sys , math

def pbnum(problem_key):
    match = re.search(r"_(\d+)", problem_key)
    if match:
        return int(match.group(1))
    return 0


def score(time_val, plan_len):
    if plan_len <= 0 or time_val >= 600.0:
        return 0.0
    if time_val <= 1.0:
        return 1.0
    # IPC logarithmic decay formula
    return 1.0 - (math.log(time_val) / math.log(600.0))









if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--comp", action="store_true")
    parser.add_argument("--len", action="store_true")
    parser.add_argument("--score", action="store_true")
    parser.add_argument("json1", type=str)
    parser.add_argument("json2", type=str)

    args = parser.parse_args()

    file1 = args.json1
    file2 = args.json2

    try:
        with open(file1, 'r') as f:
            data1 = json.load(f)
        with open(file2, 'r') as f:
            data2 = json.load(f)
    except Exception as e:
        print(f"Error loading JSON files: {e}", file=sys.stderr)
        sys.exit(1)


    matchingPb = set(data1.keys()).intersection(set(data2.keys()))
    if not matchingPb:
        print("All problems within the json files are different, unable to compare", file=sys.stderr)
        sys.exit(1)

    sorted_problems = sorted(list(matchingPb), key=lambda pb: data1[pb].get("time", 600.0))






    '''
    Graph 1 : Compares planner search time for a specific or a set of problems 
    between 2 result json files (can be script vs FD, or can be 2 script results 
    with different fd parameters for example)

    if there are more than two args, only takes into consideration the first two

    x axis: problem size (which is equivalent to just the problem number)
    y axis: time (in seconds)
    '''
    if args.comp:
        x_labels = []
        time_data1 = []
        time_data2 = []

        for pb in sorted_problems:
            pb_num = int(re.search(r"_(\d+)", pb).group(1))
            x_labels.append(str(pb_num))
            time_data1.append(data1[pb].get("time", 0.0))
            time_data2.append(data2[pb].get("time", 0.0))

    plt.figure(figsize=(10, 6))
    plt.plot(x_labels, time_data1, label='Data 1', color='red', marker='o', linestyle='-', linewidth=2)
    plt.plot(x_labels, time_data2, label='Data 2', color='blue', marker='x', linestyle='--', linewidth=2)


    plt.title('Execution Time vs Problem Size', fontsize=14, fontweight='bold')
    plt.xlabel('Problem Number', fontsize=12)
    plt.ylabel('Time (seconds)', fontsize=12)
    plt.yscale('log')
    plt.xticks(rotation=45, ha='right', fontsize=8)
    plt.legend(fontsize=12)
    plt.grid(True, which="both", ls="--", alpha=0.4)
    plt.tight_layout()
    plt.show()

    








    '''
    Graph 2 : compares plan length between 2 result json files, can also be script vs fd or just different
    fd parameters

    x axis: problem size (which is equivalent to just the problem number)
    y axis: plan length
    '''
    #TODO: make it accept 3+ args to be able to compare many things at the same time

    if args.len:
        x_labels = []
        len_data1 = []
        len_data2 = []

        for pb in sorted_problems:
            pb_num = int(re.search(r"_(\d+)", pb).group(1))
            x_labels.append(str(pb_num))
            
            # Map timeouts to 0 so they don't plunge below the x axis
            l1 = data1[pb].get("planlength", -1)
            l2 = data2[pb].get("planlength", -1)
            len_data1.append(0 if l1 == -1 else l1)
            len_data2.append(0 if l2 == -1 else l2)

        x_indices1 = [i - 0.2 for i in range(len(x_labels))]
        x_indices2 = [i + 0.2 for i in range(len(x_labels))]

        plt.figure(figsize=(12, 6))
        plt.bar(x_indices1, len_data1, width=0.4, label='Data 1', color='red')
        plt.bar(x_indices2, len_data2, width=0.4, label='Data 2', color='blue')

        plt.title('Plan Length vs Problem Size', fontsize=14, fontweight='bold')
        plt.xlabel('Problem Number', fontsize=12)
        plt.ylabel('Plan Length (Steps)', fontsize=12)
        plt.xticks(range(len(x_labels)), x_labels, rotation=45, ha='right', fontsize=8)
        plt.legend(fontsize=12)
        plt.grid(True, axis="y", ls="--", alpha=0.4)
        plt.tight_layout()
        plt.show()








    '''
    3 : Calculates the IPC score for comparison between two json results files

    if there are more than two args, only takes into consideration the first two
    1 score for data one, one score for data 2
    '''
    if args.score:
        x_labels = []
        score_data1 = []
        score_data2 = []

        for pb in sorted_problems:
            pb_num = int(re.search(r"_(\d+)", pb).group(1))
            x_labels.append(str(pb_num))
            
            t1 = data1[pb].get("time", 600.0)
            l1 = data1[pb].get("planlength", -1)
            t2 = data2[pb].get("time", 600.0)
            l2 = data2[pb].get("planlength", -1)
            
            score_data1.append(score(t1, l1))
            score_data2.append(score(t2, l2))

        total_score1 = sum(score_data1)
        total_score2 = sum(score_data2)
        max_possible = len(sorted_problems)

        print(f"\n" + "="*50)
        print(f" TOTAL IPC SCORE ")
        print(f"_"*50)
        print(f" Data 1 Total Score : {total_score1:.2f} / {max_possible}")
        print(f" Data 2 Total Score : {total_score2:.2f} / {max_possible}")
        print(f"="*50 + "\n")
