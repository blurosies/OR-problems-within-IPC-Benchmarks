


(define (problem mixed-f20-p10-u0-v0-g0-a0-n0-A0-B0-N0-F0-r2)
   (:domain miconic)
   (:objects p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 - passenger
             f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 
             f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 - floor)


(:init





















(origin p0 f3)
(destin p0 f0)

(origin p1 f4)
(destin p1 f2)

(origin p2 f13)
(destin p2 f14)

(origin p3 f10)
(destin p3 f14)

(origin p4 f19)
(destin p4 f10)

(origin p5 f3)
(destin p5 f11)

(origin p6 f2)
(destin p6 f6)

(origin p7 f14)
(destin p7 f5)

(origin p8 f15)
(destin p8 f4)

(origin p9 f0)
(destin p9 f5)






(lift-at f0)

    ;; les paths ajoutés par le solver
    (next-step f0 f2)
    (next-step f2 f3)
    (next-step f3 f4)
    (next-step f4 f5)
    (next-step f5 f6)
    (next-step f6 f10)
    (next-step f10 f11)
    (next-step f11 f13)
    (next-step f13 f14)
    (next-step f14 f15)
    (next-step f15 f19)
    (next-step f19 f10)
    (next-step f10 f5)
    (next-step f5 f4)
    (next-step f4 f2)
    (next-step f2 f0)

)


(:goal (and 
(served p0)
(served p1)
(served p2)
(served p3)
(served p4)
(served p5)
(served p6)
(served p7)
(served p8)
(served p9)
))
)


