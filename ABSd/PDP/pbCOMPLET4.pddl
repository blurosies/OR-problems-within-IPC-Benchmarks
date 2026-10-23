(define (problem PDP_pbCOMPLET4)
(:domain PDP)
(:objects
     city_1
     city_2
  - city
     truck_1
     truck_2
     truck_3
     truck_4
     truck_5
     truck_6
     truck_7
     truck_8
     truck_9
     truck_10
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
     pkg_18
     pkg_19
     pkg_20
     pkg_21
     pkg_22
     pkg_23
     pkg_24
     pkg_25
     pkg_26
     pkg_27
     pkg_28
     pkg_29
     pkg_30
     pkg_31
     pkg_32
     pkg_33
     pkg_34
  - package)
(:init
     (connected city_1 city_2)
     (connected city_2 city_1)
     (objAt truck_1 city_1)
     (objAt truck_2 city_2)
     (objAt truck_3 city_1)
     (objAt truck_4 city_1)
     (objAt truck_5 city_1)
     (objAt truck_6 city_2)
     (objAt truck_7 city_1)
     (objAt truck_8 city_1)
     (objAt truck_9 city_2)
     (objAt truck_10 city_2)
     (objAt pkg_1 city_1)
     (objAt pkg_2 city_2)
     (objAt pkg_3 city_2)
     (objAt pkg_4 city_2)
     (objAt pkg_5 city_2)
     (objAt pkg_6 city_2)
     (objAt pkg_7 city_1)
     (objAt pkg_8 city_2)
     (objAt pkg_9 city_1)
     (objAt pkg_10 city_2)
     (objAt pkg_11 city_2)
     (objAt pkg_12 city_1)
     (objAt pkg_13 city_1)
     (objAt pkg_14 city_2)
     (objAt pkg_15 city_2)
     (objAt pkg_16 city_2)
     (objAt pkg_17 city_2)
     (objAt pkg_18 city_1)
     (objAt pkg_19 city_1)
     (objAt pkg_20 city_2)
     (objAt pkg_21 city_1)
     (objAt pkg_22 city_1)
     (objAt pkg_23 city_2)
     (objAt pkg_24 city_1)
     (objAt pkg_25 city_2)
     (objAt pkg_26 city_1)
     (objAt pkg_27 city_1)
     (objAt pkg_28 city_2)
     (objAt pkg_29 city_2)
     (objAt pkg_30 city_2)
     (objAt pkg_31 city_2)
     (objAt pkg_32 city_2)
     (objAt pkg_33 city_1)
     (objAt pkg_34 city_1)
)
(:goal (and
     (objAt pkg_1 city_2)
     (objAt pkg_2 city_1)
     (objAt pkg_3 city_1)
     (objAt pkg_4 city_1)
     (objAt pkg_5 city_1)
     (objAt pkg_6 city_1)
     (objAt pkg_7 city_2)
     (objAt pkg_8 city_1)
     (objAt pkg_9 city_2)
     (objAt pkg_10 city_1)
     (objAt pkg_11 city_1)
     (objAt pkg_12 city_2)
     (objAt pkg_13 city_2)
     (objAt pkg_14 city_1)
     (objAt pkg_15 city_1)
     (objAt pkg_16 city_1)
     (objAt pkg_17 city_1)
     (objAt pkg_18 city_2)
     (objAt pkg_19 city_2)
     (objAt pkg_20 city_1)
     (objAt pkg_21 city_2)
     (objAt pkg_22 city_2)
     (objAt pkg_23 city_1)
     (objAt pkg_24 city_2)
     (objAt pkg_25 city_1)
     (objAt pkg_26 city_2)
     (objAt pkg_27 city_2)
     (objAt pkg_28 city_1)
     (objAt pkg_29 city_1)
     (objAt pkg_30 city_1)
     (objAt pkg_31 city_1)
     (objAt pkg_32 city_1)
     (objAt pkg_33 city_2)
     (objAt pkg_34 city_2)
)
)
)
