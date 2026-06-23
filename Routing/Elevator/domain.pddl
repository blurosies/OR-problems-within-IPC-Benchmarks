;miconic domain without the routing problem (solved aside)

(define (domain miconic)
(:requirements :strips :typing)

(:types passenger - object
          floor - object
)


(:predicates 
            (origin ?person - passenger ?floor - floor)
            (destin ?person - passenger ?floor - floor)
            (boarded ?person - passenger)
            (served ?person - passenger)
            (lift-at ?floor - floor)
            (next-step ?f1 - floor ?f2 - floor)
)

(:action board
  :parameters (?f - floor ?p - passenger)
  :precondition (and (lift-at ?f) (origin ?p ?f))
  :effect (boarded ?p))

(:action depart
  :parameters (?f - floor ?p - passenger)
  :precondition (and (lift-at ?f) (destin ?p ?f)
		     (boarded ?p))
  :effect (and (not (boarded ?p))
	       (served ?p)))

(:action move
    :parameters (?f1 - floor ?f2 - floor)
    :precondition (and (lift-at ?f1) (next-step ?f1 ?f2) )
    :effect (and (lift-at ?f2) (not(lift-at ?f1)))
)


)