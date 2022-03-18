robot(R)  :- init(object(robot,R),_).

prios(1..N) :- N = #count{ R : robot(R) }.

time(1..T) :- T = #max{ L : priority(robot(R),L) }, robot(R).

% - swapping conflict ----------------------------------------------------------
swapping_collision(robot(R),robot(R'),T) :- position(robot(R),C,T-1), position(robot(R),C',T), position(robot(R'),C',T-1), position(robot(R'),C,T), C!=C'.

% - vertex conflict ------------------------------------------------------------
vertex_collision(robot(R),robot(R'),T) :- position(robot(R),C,T), position(robot(R'),C,T), R!=R'.

% { priority(robot(R),P) : prios(P) }=1 :- robot(R).
number_collisions(robot(R),N) :- N = N1 + N2, N1 = #count{ R' : vertex_collision(robot(R),robot(R'),T) }, N2 = #count{ R' : swapping_collision(robot(R),robot(R'),T) }, robot(R).

priority(robot(R),P) :- number_collisions(robot(R),P).


#show priority/2.
