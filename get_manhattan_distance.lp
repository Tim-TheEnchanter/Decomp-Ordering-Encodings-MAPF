start(R,X,Y)  :- init(object(robot,R), value(at,(X,Y))).
goal(S,X,Y)   :- init(object(shelf,S), value(at,(X,Y))).

manhattan_distance(R,L) :-  L = (|X - X'|) + (|Y - Y'|), start(R,X,Y), goal(R,X',Y').

#show manhattan_distance/2.
