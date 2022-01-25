start(R,X,Y)  :- init(object(robot,R), value(at,(X,Y))).
goal(S,X,Y)   :- init(object(shelf,S), value(at,(X,Y))).

manhattan_distance(R,L) :-  L = (|X - X'|) + (|Y - Y'|), start(R,X,Y), goal(R,X',Y').
priority(R,P)    :- manhattan_distance(R,-P).

#show init/2.
#show priority/2.
