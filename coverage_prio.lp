direction(( 1, 0)).
direction(( 0, 1)).
direction((-1, 0)).
direction(( 0,-1)).

node((X,Y)) :- init(object(node,_), value(at,(X,Y))).
edge((X,Y),(DX,DY),(X+DX,Y+DY)) :- node((X,Y)), direction((DX,DY)), node((X+DX,Y+DY)).

robot(R)  :- init(object(robot,R),_).
goal(S,C) :- init(object(destination,S), value(at,C)).

prios(1..N) :- N = #count{ R : robot(R) }.

time(1..T) :- T = #max{ L : priority(robot(R),L) }, robot(R).

% position(robot(R),C,T)

colision(C,T) :- { position(robot(R),C,T) : robot(R) }  > 1, node(C), time(T).

visitors_node(C,V) :- V = #count{ R,T : position(robot(R),C,T)}, node(C).

visitors(robot(R),S) :- S = #sum{ V : visitors_node(C,V+1), position(robot(R),C,_)}, robot(R).

% { priority(robot(R),P) : prios(P) }=1 :- robot(R).

priority(robot(R),P) :- visitors(robot(R),P).


#show prios/1.
#show priority/2.
% #show colision/2.
% #show importance_node/2.
