


(define (problem mixed-f60-p30-u0-v0-g0-a0-n0-A0-B0-N0-F0-r4)
   (:domain miconic)
   (:objects p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 
             p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 
             p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 - passenger
             f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 
             f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 
             f20 f21 f22 f23 f24 f25 f26 f27 f28 f29 
             f30 f31 f32 f33 f34 f35 f36 f37 f38 f39 
             f40 f41 f42 f43 f44 f45 f46 f47 f48 f49 
             f50 f51 f52 f53 f54 f55 f56 f57 f58 f59 - floor)


(:init


(origin p0 f15)
(destin p0 f51)

(origin p1 f42)
(destin p1 f2)

(origin p2 f0)
(destin p2 f42)

(origin p3 f58)
(destin p3 f47)

(origin p4 f45)
(destin p4 f9)

(origin p5 f44)
(destin p5 f50)

(origin p6 f49)
(destin p6 f2)

(origin p7 f39)
(destin p7 f18)

(origin p8 f33)
(destin p8 f20)

(origin p9 f13)
(destin p9 f43)

(origin p10 f49)
(destin p10 f18)

(origin p11 f13)
(destin p11 f28)

(origin p12 f42)
(destin p12 f27)

(origin p13 f40)
(destin p13 f27)

(origin p14 f19)
(destin p14 f38)

(origin p15 f30)
(destin p15 f27)

(origin p16 f29)
(destin p16 f12)

(origin p17 f29)
(destin p17 f21)

(origin p18 f47)
(destin p18 f20)

(origin p19 f0)
(destin p19 f32)

(origin p20 f21)
(destin p20 f44)

(origin p21 f14)
(destin p21 f10)

(origin p22 f38)
(destin p22 f53)

(origin p23 f20)
(destin p23 f3)

(origin p24 f14)
(destin p24 f25)

(origin p25 f46)
(destin p25 f55)

(origin p26 f35)
(destin p26 f59)

(origin p27 f16)
(destin p27 f9)

(origin p28 f27)
(destin p28 f56)

(origin p29 f36)
(destin p29 f38)






(lift-at f0)

    ;; les paths ajoutés par le solver
    (next-step f0 f13)
    (next-step f13 f14)
    (next-step f14 f15)
    (next-step f15 f16)
    (next-step f16 f19)
    (next-step f19 f20)
    (next-step f20 f21)
    (next-step f21 f25)
    (next-step f25 f27)
    (next-step f27 f28)
    (next-step f28 f29)
    (next-step f29 f30)
    (next-step f30 f32)
    (next-step f32 f33)
    (next-step f33 f35)
    (next-step f35 f36)
    (next-step f36 f38)
    (next-step f38 f39)
    (next-step f39 f40)
    (next-step f40 f42)
    (next-step f42 f43)
    (next-step f43 f44)
    (next-step f44 f45)
    (next-step f45 f46)
    (next-step f46 f47)
    (next-step f47 f49)
    (next-step f49 f50)
    (next-step f50 f51)
    (next-step f51 f53)
    (next-step f53 f55)
    (next-step f55 f56)
    (next-step f56 f58)
    (next-step f58 f59)
    (next-step f59 f47)
    (next-step f47 f27)
    (next-step f27 f21)
    (next-step f21 f20)
    (next-step f20 f18)
    (next-step f18 f12)
    (next-step f12 f10)
    (next-step f10 f9)
    (next-step f9 f3)
    (next-step f3 f2)

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
(served p10)
(served p11)
(served p12)
(served p13)
(served p14)
(served p15)
(served p16)
(served p17)
(served p18)
(served p19)
(served p20)
(served p21)
(served p22)
(served p23)
(served p24)
(served p25)
(served p26)
(served p27)
(served p28)
(served p29)
))
)


