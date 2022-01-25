robot(R)      :- init(object(robot,R), value(at,(X,Y))).
priority(R,R) :- robot(R).

#show init/2.
#show priority/2.
