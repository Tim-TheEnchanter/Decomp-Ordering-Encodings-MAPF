% --------------------------------------------------------------------------------
% REPRESENTATION

robot(R)                     :- init(object(robot,R),          _).
goal(S,C)                    :- init(object(destination,S), value(at,C)).

    isRobot(robot(R)) :- robot(R).
    isGoal(goal(S,C)) :- goal(S,C).

position(           (X,Y))   :- init(object(node,_),           value(at,(X,Y))).

position(  robot(R),(X,Y),0) :- init(object(robot,R),          value(at,(X,Y))).
position(  destination(S),(X,Y),0) :- init(object(destination,S),          value(at,(X,Y))).
