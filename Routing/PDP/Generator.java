package Routing.PDP;

import java.io.File;
import java.util.Random;
import java.io.FileWriter;
import java.util.ArrayList;
import java.io.BufferedWriter;

public class Generator {
    //limites pour le nb d'objets dans le problème
    static int minVilles=2;
    static int maxVilles=30;
    static int minTrucks= 1;
    static int maxTrucks= 10;
    static int minPkg= 1;
    static int maxPkg= 50;

    //retourne une liste des villes connectées pour la strucutre de graphe
    // 0: Graphe complet
    // 1: Cercle 
    // 2: random graphe
    static ArrayList<String> connetedCities (int mode, int nbVilles){
        ArrayList<String> roads= new ArrayList<>();

        if (mode==0) {
            // graphe complet
            for (int i = 1; i <= nbVilles; i++) {
                for (int j = 1; j <= nbVilles; j++) {
                    if (i != j) {
                        roads.add("(connected city_" + i + " city_" + j + ")");
                    }
                }
            }

        } else if (mode==1) {
            // graphe en cercle
            for (int i = 1; i <= nbVilles; i++) {

                int nextCity = (i % nbVilles) + 1; 
                roads.add("(connected city_" + i + " city_" + nextCity + ")");
                roads.add("(connected city_" + nextCity + " city_" + i + ")");
            }

        } else {
            // graphe random 

            ArrayList<Integer> shuffledCities = new ArrayList<>();
            for (int i = 1; i <= nbVilles; i++) {
                shuffledCities.add(i);
            }
            java.util.Collections.shuffle(shuffledCities);
            for (int i = 0; i < shuffledCities.size() - 1; i++) {
                int current = shuffledCities.get(i);
                int next = shuffledCities.get(i + 1);
                roads.add("(connected city_" + current + " city_" + next + ")");
                roads.add("(connected city_" + next + " city_" + current + ")");
            }
            Random rand = new Random();
            int extraRoads = nbVilles / 3; 
            
            for (int i = 0; i < extraRoads; i++) {
                int cityA = rand.nextInt(nbVilles) + 1;
                int cityB = rand.nextInt(nbVilles) + 1;
                if (cityA != cityB) {
                    roads.add("(connected city_" + cityA + " city_" + cityB + ")");
                    roads.add("(connected city_" + cityB + " city_" + cityA + ")");
                }
            }
        }
        return roads;
    }


    public static void main(String[] args) {
        if (args.length!=3) {
            System.err.println("Usage: <fileName> <number of problems> <Graph mode (complet/cercle/random)>");
            System.exit(1);
        }

        for (int nbfich = 1; nbfich <Integer.parseInt(args[1])+1; nbfich++) {

            String nomfich=args[0]+nbfich ;
            
            File f= new File("Routing/PDP/"+nomfich+".pddl");
    
            //creation du fichier
            try {
                if (f.createNewFile()) {
                    System.out.println("File created!");
                }else {
                    System.out.println("Problem file already exists");
                    System.exit(2);
                }
            } catch (Exception e) {
                System.err.println(e);
                e.printStackTrace();
            }
    
            // fichier a bien été crée
            // génération des objets
            Random nombres= new Random();
            int nbVilles=nombres.nextInt(maxVilles-minVilles+1)+minVilles;
            int nbTrucks=nombres.nextInt(maxTrucks-minTrucks+1)+minTrucks;
            int nbPkg=nombres.nextInt(maxPkg-minPkg+1)+minPkg;
    
            ArrayList<String> cities = new ArrayList<>();
                    for (int i = 1; i <= nbVilles; i++) {
                        cities.add("city_" + i);
                    }
    
            ArrayList<String> trucks = new ArrayList<>();
                    for (int i = 1; i <= nbTrucks; i++) {
                        trucks.add("truck_" + i);
                    }
    
            ArrayList<String> packages = new ArrayList<>();
                    for (int i = 1; i <= nbPkg; i++) {
                        packages.add("pkg_" + i);
                    }
    
            // ecriture dans le fichier
            try (BufferedWriter ecriture = new BufferedWriter(new FileWriter(f))) {

                //initialisation
                ecriture.write("(define (problem PDP_"+nomfich+")");
                ecriture.newLine();
                ecriture.write("(:domain PDP)");
                ecriture.newLine();

////////////////////////////////////////////////////////////////
                //objects
                ecriture.write("(:objects");
                ecriture.newLine();

                    //cities
                for (int i = 0; i < nbVilles; i++) {
                    ecriture.write("     "+cities.get(i));
                    ecriture.newLine();

                }
                ecriture.write("  - city");
                ecriture.newLine();

                    //trucks
                for (int i = 0; i < nbTrucks; i++) {
                    ecriture.write("     "+trucks.get(i));
                    ecriture.newLine();

                }
                ecriture.write("  - truck");
                ecriture.newLine();

                    //packages
                for (int i = 0; i < nbPkg; i++) {
                    ecriture.write("     "+packages.get(i));
                    ecriture.newLine();

                }
                ecriture.write("  - package)");
                ecriture.newLine();
////////////////////////////////////////////////////////////////
                //init
                ecriture.write("(:init");
                ecriture.newLine();

                // formation du graphe de route
                ArrayList<String> routesConnectes = new ArrayList<>();
                if (args[2].equals("complet")) {
                    routesConnectes = connetedCities(0, nbVilles);
                } else if (args[2].equals("cercle")){
                    routesConnectes = connetedCities(1, nbVilles);
                } else {
                    routesConnectes = connetedCities(2, nbVilles);

                }
                for (int i = 0; i < routesConnectes.size(); i++) {
                    ecriture.write("     "+routesConnectes.get(i));
                    ecriture.newLine();

                }

                // position des trucks
                for (int i = 1; i < nbTrucks+1; i++) {
                    int position=nombres.nextInt(nbVilles)+1;
                    ecriture.write("     (objAt truck_"+i+" city_"+position+")");
                    ecriture.newLine();
                }
                // position des colis
                int[] startCities = new int[nbPkg + 1];
                for (int i = 1; i < nbPkg+1; i++) {
                    int position=nombres.nextInt(nbVilles)+1;
                    startCities[i] = position;
                    ecriture.write("     (objAt pkg_"+i+" city_"+position+")");
                    ecriture.newLine();
                }

                    //fin init
                ecriture.write(")");
                ecriture.newLine();

////////////////////////////////////////////////////////////////
                //goal
                ecriture.write("(:goal (and");
                ecriture.newLine();

                for (int i = 1; i <= nbPkg; i++) {
                    int startCity = startCities[i];
                    int goalCity = nombres.nextInt(nbVilles) + 1;
                    
                    while (goalCity == startCity) {
                        goalCity = nombres.nextInt(nbVilles) + 1;
                    }
                    
                    ecriture.write("     (objAt pkg_" + i + " city_" + goalCity + ")");
                    ecriture.newLine();
                }

                    //fin and
                ecriture.write(")");
                ecriture.newLine();

                    //fin goal
                ecriture.write(")");
                ecriture.newLine();

////////////////////////////////////////////////////////////////
                //fin prob
                ecriture.write(")");
                ecriture.newLine();


            } catch (Exception e) {
                System.err.println(e);
                e.printStackTrace();
            }
    

        }    

        }
    }
