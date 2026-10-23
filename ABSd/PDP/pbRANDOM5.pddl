(define (problem PDP_pbRANDOM5)
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
  - city
     truck_1
     truck_2
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
     pkg_35
     pkg_36
     pkg_37
     pkg_38
     pkg_39
  - package)
(:init
     (connected city_12 city_4)
     (connected city_4 city_12)
     (connected city_4 city_3)
     (connected city_3 city_4)
     (connected city_3 city_2)
     (connected city_2 city_3)
     (connected city_2 city_9)
     (connected city_9 city_2)
     (connected city_9 city_5)
     (connected city_5 city_9)
     (connected city_5 city_7)
     (connected city_7 city_5)
     (connected city_7 city_10)
     (connected city_10 city_7)
     (connected city_10 city_13)
     (connected city_13 city_10)
     (connected city_13 city_1)
     (connected city_1 city_13)
     (connected city_1 city_8)
     (connected city_8 city_1)
     (connected city_8 city_6)
     (connected city_6 city_8)
     (connected city_6 city_14)
     (connected city_14 city_6)
     (connected city_14 city_11)
     (connected city_11 city_14)
     (connected city_5 city_9)
     (connected city_9 city_5)
     (connected city_8 city_12)
     (connected city_12 city_8)
     (connected city_8 city_6)
     (connected city_6 city_8)
     (connected city_13 city_1)
     (connected city_1 city_13)
     (objAt truck_1 city_5)
     (objAt truck_2 city_1)
     (objAt pkg_1 city_10)
     (objAt pkg_2 city_1)
     (objAt pkg_3 city_3)
     (objAt pkg_4 city_2)
     (objAt pkg_5 city_10)
     (objAt pkg_6 city_14)
     (objAt pkg_7 city_1)
     (objAt pkg_8 city_10)
     (objAt pkg_9 city_13)
     (objAt pkg_10 city_9)
     (objAt pkg_11 city_10)
     (objAt pkg_12 city_5)
     (objAt pkg_13 city_3)
     (objAt pkg_14 city_12)
     (objAt pkg_15 city_13)
     (objAt pkg_16 city_14)
     (objAt pkg_17 city_7)
     (objAt pkg_18 city_10)
     (objAt pkg_19 city_7)
     (objAt pkg_20 city_6)
     (objAt pkg_21 city_7)
     (objAt pkg_22 city_14)
     (objAt pkg_23 city_6)
     (objAt pkg_24 city_12)
     (objAt pkg_25 city_2)
     (objAt pkg_26 city_6)
     (objAt pkg_27 city_7)
     (objAt pkg_28 city_5)
     (objAt pkg_29 city_13)
     (objAt pkg_30 city_3)
     (objAt pkg_31 city_12)
     (objAt pkg_32 city_9)
     (objAt pkg_33 city_13)
     (objAt pkg_34 city_11)
     (objAt pkg_35 city_10)
     (objAt pkg_36 city_10)
     (objAt pkg_37 city_3)
     (objAt pkg_38 city_12)
     (objAt pkg_39 city_10)
)
(:goal (and
     (objAt pkg_1 city_7)
     (objAt pkg_2 city_4)
     (objAt pkg_3 city_12)
     (objAt pkg_4 city_13)
     (objAt pkg_5 city_1)
     (objAt pkg_6 city_6)
     (objAt pkg_7 city_14)
     (objAt pkg_8 city_6)
     (objAt pkg_9 city_7)
     (objAt pkg_10 city_3)
     (objAt pkg_11 city_9)
     (objAt pkg_12 city_14)
     (objAt pkg_13 city_7)
     (objAt pkg_14 city_13)
     (objAt pkg_15 city_1)
     (objAt pkg_16 city_9)
     (objAt pkg_17 city_3)
     (objAt pkg_18 city_12)
     (objAt pkg_19 city_2)
     (objAt pkg_20 city_12)
     (objAt pkg_21 city_10)
     (objAt pkg_22 city_1)
     (objAt pkg_23 city_1)
     (objAt pkg_24 city_10)
     (objAt pkg_25 city_1)
     (objAt pkg_26 city_1)
     (objAt pkg_27 city_12)
     (objAt pkg_28 city_9)
     (objAt pkg_29 city_1)
     (objAt pkg_30 city_9)
     (objAt pkg_31 city_9)
     (objAt pkg_32 city_11)
     (objAt pkg_33 city_9)
     (objAt pkg_34 city_8)
     (objAt pkg_35 city_8)
     (objAt pkg_36 city_7)
     (objAt pkg_37 city_7)
     (objAt pkg_38 city_13)
     (objAt pkg_39 city_11)
)
)
)
