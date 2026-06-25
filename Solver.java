
import java.util.*;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;


// a faire: rendre algo domain independant
public class Solver {

    static class Passenger {
        String id;
        int origin;
        int destin;
        public Passenger(String id, int origin, int destin) {
            this.id = id;
            this.origin = origin;
            this.destin = destin;
        }
    }

    public static void main(String[] args) {
        if (args.length!=1) {
            System.err.println("Usage: <problem name>");
            System.exit(1);
        }

        // a faire: security pour fichier
        String inputFilePath = "original_pbs/Elevator/"+args[0]+".pddl"; 
        String outputFilePath = "Routing/Elevator/noPDP_"+args[0]+".pddl";


        try {

            System.out.println("Start:");

            //parser pour remplir les infos necessaires
            List<String> rawLines = Files.readAllLines(Paths.get(inputFilePath));
            List<String> cleanLines = new ArrayList<>();
            
            // a remplir pour les passengers
            Map<String, Integer> originsMap = new HashMap<>();
            Map<String, Integer> destinsMap = new HashMap<>();

            for (String line : rawLines) {
                // above n'est pas dans le domaine sans pdp
                if (!line.contains("(above ")) {
                    cleanLines.add(line);
                }
                
                if (line.contains("(origin ")) {
                    String[] parts = line.replace("(", "").replace(")", "").trim().split("\\s+");
                    if (parts.length >= 3) {
                        originsMap.put(parts[1], Integer.parseInt(parts[2].replace("f", "")));
                    }
                } 

                else if (line.contains("(destin ")) {
                    String[] parts = line.replace("(", "").replace(")", "").trim().split("\\s+");
                    if (parts.length >= 3) {
                        destinsMap.put(parts[1], Integer.parseInt(parts[2].replace("f", "")));
                    }
                }

            }

            // liste de passagers qui ne sont pas encore choisis 
            List<Passenger> unpicked = new ArrayList<>();
            for (String pId : originsMap.keySet()) {
                if (destinsMap.containsKey(pId)) {
                    unpicked.add(new Passenger(pId, originsMap.get(pId), destinsMap.get(pId)));
                }
            }


            

            // Algo glouton pdp
            List<String> chemins = new ArrayList<>();
            chemins.add("");
            chemins.add("    ;; les paths ajoutés par le solver");

            int currentFloor = 0;
            List<Passenger> boarded = new ArrayList<>();

            while (!unpicked.isEmpty() || !boarded.isEmpty()) {
                boolean activity = true;
                while (activity) {
                    activity = false;
                    
                    // drop off
                    Iterator<Passenger> itBoard = boarded.iterator();
                    while (itBoard.hasNext()) {
                        if (itBoard.next().destin == currentFloor) {
                            itBoard.remove();
                            activity = true;
                        }
                    }
                    
                    // pick up
                    Iterator<Passenger> itUnpick = unpicked.iterator();
                    while (itUnpick.hasNext()) {
                        Passenger p = itUnpick.next();
                        if (p.origin == currentFloor) {
                            boarded.add(p);
                            itUnpick.remove();
                            activity = true;
                        }
                    }
                }

                if (unpicked.isEmpty() && boarded.isEmpty()) {
                    break; 
                }
                //glouton
                int bestDist = Integer.MAX_VALUE;
                int nextFloor = currentFloor;
                for (Passenger p : unpicked) {
                    int dist = Math.abs(p.origin - currentFloor);
                    if (dist > 0 && dist < bestDist) {
                        bestDist = dist;
                        nextFloor = p.origin;
                    }
                }
                
                for (Passenger p : boarded) {
                    int dist = Math.abs(p.destin - currentFloor);
                    if (dist > 0 && dist < bestDist) {
                        bestDist = dist;
                        nextFloor = p.destin;
                    }
                }

                if (nextFloor != currentFloor) {
                    chemins.add("    (next-step f" + currentFloor + " f" + nextFloor + ")");
                    currentFloor = nextFloor;
                }
            }
            chemins.add("");





            //ecriture des chemins trouvés dans le probleme original

            int insertion = -1;
            for (int i = 0; i < cleanLines.size(); i++) {
                if (cleanLines.get(i).contains("(:goal")) {
                    for (int j = i - 1; j >= 0; j--) {
                        if (cleanLines.get(j).trim().equals(")")) {
                            insertion = j;
                            break;
                        }
                    }
                    break;
                }
            }

            if (insertion != -1) {
                cleanLines.addAll(insertion, chemins);
            } else {
                cleanLines.addAll(chemins);
            }
            FileWriter writer = new FileWriter(outputFilePath);
            for (String line : cleanLines) {
                writer.write(line + "\n");
            }
            writer.close();
            System.out.println("Generated PDP route with " + (chemins.size() - 3) + " steps.");
            System.out.println("Saved solved problem to: " + outputFilePath);


        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
    }
}