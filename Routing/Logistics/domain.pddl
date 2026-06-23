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
  
(:predicates (at ?obj - physobj ?loc - place)
		     (in ?pkg - package ?veh - vehicle)
             (next-step ?veh - vehicle ?l1 - place ?l2 - place)
)
  
(:action LOAD-TRUCK
   :parameters    (?pkg - package ?truck - truck ?loc - place)
   :precondition  (and (at ?truck ?loc) (at ?pkg ?loc))
   :effect        (and (not (at ?pkg ?loc)) (in ?pkg ?truck)))

(:action LOAD-AIRPLANE
  :parameters   (?pkg - package ?airplane - airplane ?loc - place)
  :precondition (and (at ?pkg ?loc) (at ?airplane ?loc))
  :effect       (and (not (at ?pkg ?loc)) (in ?pkg ?airplane)))

(:action UNLOAD-TRUCK
  :parameters   (?pkg - package ?truck - truck ?loc - place)
  :precondition (and (at ?truck ?loc) (in ?pkg ?truck))
  :effect       (and (not (in ?pkg ?truck)) (at ?pkg ?loc)))

(:action UNLOAD-AIRPLANE
  :parameters    (?pkg - package ?airplane - airplane ?loc - place)
  :precondition  (and (in ?pkg ?airplane) (at ?airplane ?loc))
  :effect        (and (not (in ?pkg ?airplane)) (at ?pkg ?loc)))

(:action move
    :parameters (?veh - vehicle ?loc-from - place ?loc-to - place)
    :precondition (and (next-step ?veh ?loc-from ?loc-to) (at ?veh ?loc-from))
    :effect (and (not(at ?veh ?loc-from)) (at ?veh ?loc-to) )
)

)
