robot(R) :- init(object(robot,R),value(at,_)).

arrival_time(R,T) :- T = #max{  L: occurs(object(robot,R),_,L)}, robot(R).

sum_of_costs(S) :- S = #sum{  T: arrival_time(R,T)   }.
#show sum_of_costs/1.
