(define (problem PDP_pbRANDOM1)
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
  - city
     truck_1
     truck_2
     truck_3
     truck_4
     truck_5
     truck_6
     truck_7
     truck_8
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
     pkg_40
     pkg_41
     pkg_42
     pkg_43
     pkg_44
  - package)
(:init
     (connected city_4 city_8)
     (connected city_8 city_4)
     (connected city_8 city_5)
     (connected city_5 city_8)
     (connected city_5 city_2)
     (connected city_2 city_5)
     (connected city_2 city_9)
     (connected city_9 city_2)
     (connected city_9 city_6)
     (connected city_6 city_9)
     (connected city_6 city_7)
     (connected city_7 city_6)
     (connected city_7 city_1)
     (connected city_1 city_7)
     (connected city_1 city_3)
     (connected city_3 city_1)
     (connected city_9 city_1)
     (connected city_1 city_9)
     (connected city_5 city_2)
     (connected city_2 city_5)
     (connected city_9 city_2)
     (connected city_2 city_9)
     (objAt truck_1 city_3)
     (objAt truck_2 city_2)
     (objAt truck_3 city_5)
     (objAt truck_4 city_4)
     (objAt truck_5 city_2)
     (objAt truck_6 city_8)
     (objAt truck_7 city_2)
     (objAt truck_8 city_5)
     (objAt pkg_1 city_6)
     (objAt pkg_2 city_2)
     (objAt pkg_3 city_8)
     (objAt pkg_4 city_9)
     (objAt pkg_5 city_6)
     (objAt pkg_6 city_2)
     (objAt pkg_7 city_9)
     (objAt pkg_8 city_7)
     (objAt pkg_9 city_7)
     (objAt pkg_10 city_1)
     (objAt pkg_11 city_5)
     (objAt pkg_12 city_2)
     (objAt pkg_13 city_8)
     (objAt pkg_14 city_1)
     (objAt pkg_15 city_1)
     (objAt pkg_16 city_1)
     (objAt pkg_17 city_9)
     (objAt pkg_18 city_3)
     (objAt pkg_19 city_1)
     (objAt pkg_20 city_8)
     (objAt pkg_21 city_7)
     (objAt pkg_22 city_9)
     (objAt pkg_23 city_2)
     (objAt pkg_24 city_2)
     (objAt pkg_25 city_2)
     (objAt pkg_26 city_6)
     (objAt pkg_27 city_5)
     (objAt pkg_28 city_6)
     (objAt pkg_29 city_8)
     (objAt pkg_30 city_2)
     (objAt pkg_31 city_5)
     (objAt pkg_32 city_6)
     (objAt pkg_33 city_7)
     (objAt pkg_34 city_8)
     (objAt pkg_35 city_9)
     (objAt pkg_36 city_5)
     (objAt pkg_37 city_3)
     (objAt pkg_38 city_2)
     (objAt pkg_39 city_9)
     (objAt pkg_40 city_6)
     (objAt pkg_41 city_2)
     (objAt pkg_42 city_3)
     (objAt pkg_43 city_5)
     (objAt pkg_44 city_5)
)
(:goal (and
     (objAt pkg_1 city_8)
     (objAt pkg_2 city_4)
     (objAt pkg_3 city_4)
     (objAt pkg_4 city_6)
     (objAt pkg_5 city_2)
     (objAt pkg_6 city_6)
     (objAt pkg_7 city_3)
     (objAt pkg_8 city_1)
     (objAt pkg_9 city_3)
     (objAt pkg_10 city_8)
     (objAt pkg_11 city_7)
     (objAt pkg_12 city_6)
     (objAt pkg_13 city_2)
     (objAt pkg_14 city_7)
     (objAt pkg_15 city_2)
     (objAt pkg_16 city_8)
     (objAt pkg_17 city_6)
     (objAt pkg_18 city_9)
     (objAt pkg_19 city_8)
     (objAt pkg_20 city_7)
     (objAt pkg_21 city_5)
     (objAt pkg_22 city_1)
     (objAt pkg_23 city_1)
     (objAt pkg_24 city_5)
     (objAt pkg_25 city_8)
     (objAt pkg_26 city_2)
     (objAt pkg_27 city_3)
     (objAt pkg_28 city_4)
     (objAt pkg_29 city_3)
     (objAt pkg_30 city_6)
     (objAt pkg_31 city_8)
     (objAt pkg_32 city_1)
     (objAt pkg_33 city_4)
     (objAt pkg_34 city_2)
     (objAt pkg_35 city_5)
     (objAt pkg_36 city_8)
     (objAt pkg_37 city_1)
     (objAt pkg_38 city_1)
     (objAt pkg_39 city_4)
     (objAt pkg_40 city_5)
     (objAt pkg_41 city_9)
     (objAt pkg_42 city_7)
     (objAt pkg_43 city_4)
     (objAt pkg_44 city_9)
)
)
)
