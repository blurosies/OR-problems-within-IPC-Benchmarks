;miconic domain without the routing problem (solved aside)

(define (domain miconic)
  (:requirements :strips :typing)
  (:types passenger - object
          floor - object
  )

(:predicates
(origin ?person - passenger ?floor - floor)
(destin ?person - passenger ?floor - floor)
(above ?floor1 - floor  ?floor2 - floor)
(boarded ?person - passenger)
(served ?person - passenger)
(lift-at ?floor - floor)
)


(:action move
  :parameters (?p - passenger ?o - floor ?d - floor)
  :precondition (and (origin ?p ?o) (destin ?p ?d))
  :effect (served ?p))
  
)


