(define (problem PDP_pbRANDOM3)
(:domain PDP)
(:objects
     city_1
     city_2
     city_3
     city_4
     city_5
     city_6
     city_7
     city_8
     city_9
     city_10
     city_11
     city_12
  - city
     truck_1
     truck_2
     truck_3
     truck_4
  - truck
     pkg_1
     pkg_2
  - package)
(:init
     (connected city_9 city_8)
     (connected city_8 city_9)
     (connected city_8 city_7)
     (connected city_7 city_8)
     (connected city_7 city_2)
     (connected city_2 city_7)
     (connected city_2 city_12)
     (connected city_12 city_2)
     (connected city_12 city_4)
     (connected city_4 city_12)
     (connected city_4 city_5)
     (connected city_5 city_4)
     (connected city_5 city_1)
     (connected city_1 city_5)
     (connected city_1 city_11)
     (connected city_11 city_1)
     (connected city_11 city_6)
     (connected city_6 city_11)
     (connected city_6 city_10)
     (connected city_10 city_6)
     (connected city_10 city_3)
     (connected city_3 city_10)
     (connected city_12 city_4)
     (connected city_4 city_12)
     (connected city_2 city_10)
     (connected city_10 city_2)
     (connected city_7 city_3)
     (connected city_3 city_7)
     (connected city_9 city_3)
     (connected city_3 city_9)
     (objAt truck_1 city_3)
     (objAt truck_2 city_11)
     (objAt truck_3 city_12)
     (objAt truck_4 city_1)
     (objAt pkg_1 city_11)
     (objAt pkg_2 city_4)
)
(:goal (and
     (objAt pkg_1 city_9)
     (objAt pkg_2 city_5)
)
)
)
