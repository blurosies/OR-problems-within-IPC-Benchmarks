(define (problem PDP_pbCERCLE2)
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
     city_13
     city_14
     city_15
     city_16
     city_17
     city_18
  - city
     truck_1
     truck_2
     truck_3
     truck_4
  - truck
     pkg_1
     pkg_2
     pkg_3
     pkg_4
     pkg_5
     pkg_6
     pkg_7
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
     (connected city_8 city_9)
     (connected city_9 city_8)
     (connected city_9 city_10)
     (connected city_10 city_9)
     (connected city_10 city_11)
     (connected city_11 city_10)
     (connected city_11 city_12)
     (connected city_12 city_11)
     (connected city_12 city_13)
     (connected city_13 city_12)
     (connected city_13 city_14)
     (connected city_14 city_13)
     (connected city_14 city_15)
     (connected city_15 city_14)
     (connected city_15 city_16)
     (connected city_16 city_15)
     (connected city_16 city_17)
     (connected city_17 city_16)
     (connected city_17 city_18)
     (connected city_18 city_17)
     (connected city_18 city_1)
     (connected city_1 city_18)
     (objAt truck_1 city_18)
     (objAt truck_2 city_12)
     (objAt truck_3 city_3)
     (objAt truck_4 city_1)
     (objAt pkg_1 city_18)
     (objAt pkg_2 city_13)
     (objAt pkg_3 city_8)
     (objAt pkg_4 city_12)
     (objAt pkg_5 city_10)
     (objAt pkg_6 city_8)
     (objAt pkg_7 city_9)
)
(:goal (and
     (objAt pkg_1 city_6)
     (objAt pkg_2 city_6)
     (objAt pkg_3 city_1)
     (objAt pkg_4 city_6)
     (objAt pkg_5 city_12)
     (objAt pkg_6 city_5)
     (objAt pkg_7 city_12)
)
)
)
