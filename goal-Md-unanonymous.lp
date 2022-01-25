goal_reached(R) :- position(robot(R),C,_), goal(R,C).

:- not goal_reached(R), robot(R).
