(define (problem PDP_pbCERCLE4)
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
  - city
     truck_1
     truck_2
     truck_3
     truck_4
     truck_5
  - truck
     pkg_1
     pkg_2
     pkg_3
     pkg_4
     pkg_5
     pkg_6
     pkg_7
     pkg_8
     pkg_9
     pkg_10
     pkg_11
     pkg_12
     pkg_13
     pkg_14
     pkg_15
     pkg_16
     pkg_17
  - package)
(:init
     (connected city_1 city_2)
     (connected city_2 city_1)
     (connected city_2 city_3)
     (connected city_3 city_2)
     (connected city_3 city_4)
     (connected city_4 city_3)
     (connected city_4 city_5)
     (connected city_5 city_4)
     (connected city_5 city_6)
     (connected city_6 city_5)
     (connected city_6 city_7)
     (connected city_7 city_6)
     (connected city_7 city_8)
     (connected city_8 city_7)
     (connected city_8 city_1)
     (connected city_1 city_8)
     (objAt truck_1 city_4)
     (objAt truck_2 city_2)
     (objAt truck_3 city_3)
     (objAt truck_4 city_5)
     (objAt truck_5 city_6)
     (objAt pkg_1 city_2)
     (objAt pkg_2 city_7)
     (objAt pkg_3 city_8)
     (objAt pkg_4 city_8)
     (objAt pkg_5 city_4)
     (objAt pkg_6 city_7)
     (objAt pkg_7 city_4)
     (objAt pkg_8 city_5)
     (objAt pkg_9 city_6)
     (objAt pkg_10 city_3)
     (objAt pkg_11 city_7)
     (objAt pkg_12 city_1)
     (objAt pkg_13 city_7)
     (objAt pkg_14 city_2)
     (objAt pkg_15 city_2)
     (objAt pkg_16 city_8)
     (objAt pkg_17 city_6)
)
(:goal (and
     (objAt pkg_1 city_1)
     (objAt pkg_2 city_4)
     (objAt pkg_3 city_6)
     (objAt pkg_4 city_4)
     (objAt pkg_5 city_7)
     (objAt pkg_6 city_8)
     (objAt pkg_7 city_6)
     (objAt pkg_8 city_6)
     (objAt pkg_9 city_5)
     (objAt pkg_10 city_8)
     (objAt pkg_11 city_4)
     (objAt pkg_12 city_3)
     (objAt pkg_13 city_2)
     (objAt pkg_14 city_5)
     (objAt pkg_15 city_8)
     (objAt pkg_16 city_6)
     (objAt pkg_17 city_1)
)
)
)
