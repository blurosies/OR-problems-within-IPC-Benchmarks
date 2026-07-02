;; logistics domain without the routing problem (solved aside)
;;

(define (domain logistics)
  (:requirements :strips :typing) 
  (:types truck
          airplane - vehicle
          package
          vehicle - physobj
          airport
          location - place
          city
          place 
          physobj - object)
  
(:predicates (in-city ?loc - place ?city - city)
		(at ?obj - physobj ?loc - place)
		(in ?pkg - package ?veh - vehicle)
)

(:action move
    :parameters (?pkg - package ?from - place ?to - place)
    :precondition (at ?pkg ?from)
    :effect (and (not(at ?pkg ?from)) (at ?pkg ?to))
)

)
