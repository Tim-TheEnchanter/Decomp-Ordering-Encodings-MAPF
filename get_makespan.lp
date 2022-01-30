makespan(L) :- L = #max{ T : occurs(object(robot,R),_,T)}.
#show makespan/1.
