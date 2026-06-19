; domaine qui représente le PDP (Pick up and delivery problem) générale, où il y a un ensemble de colis dans les localisations différentes
; qui doivent être collectés et déposés à leurs destinations


(define (domain PDP)
    (:requirements :strips :typing )

    (:types locatable
            place - object

            package
            truck - locatable

            city  - place
    )

    (:predicates (connected ?c1 ?c2 - city)
                 (objAt ?obj - locatable ?loc - place)
                 (in ?pkg - package ?trk - truck)
    )
    
    (:action DRIVE
        :parameters (?t - truck ?c1 - city ?c2 - city)
        :precondition (and (objAt ?t ?c1) (connected ?c1 ?c2) )
        :effect (and (not (objAt ?t ?c1)) (objAt ?t ?c2) )
    )

    (:action LOAD
        :parameters (?pkg - package ?t - truck ?loc - place)
        :precondition (and (objAt ?pkg ?loc) (objAt ?t ?loc))
        :effect (and (not (objAt ?pkg ?loc)) (in ?pkg ?t))
    )
    
    (:action UNLOAD
        :parameters (?pkg - package ?t - truck ?loc - place)
        :precondition (and (objAt ?t ?loc) (in ?pkg ?t))
        :effect (and (not (in ?pkg ?t)) (objAt ?pkg ?loc))
    )

    )