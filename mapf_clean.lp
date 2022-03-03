% ------------------------------------------------------------------------------
% REPRESENTATION

robot(R) :- init(object(robot,R),_).
goal(S,C):- init(object(destination,S), value(at,C)).
node((X,Y)) :- init(object(node,_), value(at,(X,Y))).

position(robot(R),(X,Y),0)       :- init(object(robot,R), value(at,(X,Y))).

time(1..horizon).

% ------------------------------------------------------------------------------

%#heuristic action(R,move(C,C'),T): edge(C,C'),time(T),priority(R,P). [P,level]

direction(( 1, 0)).
direction(( 0, 1)).
direction((-1, 0)).
direction(( 0,-1)).

edge((X,Y),(X+DX,Y+DY)) :- node((X,Y)), node((X+DX,Y+DY)), direction((DX,DY)).

{ action(R,move(C,C'),T); action(R,wait(C),T) }=1 :- position(R,C,T),edge(C,C'). %THERE HAS TO BE SOMETHING WRONG HERE!

% - moving ---------------------------------------------------------------------
action(R,move(C,C'),T-1) :- position(R,C,T-1), edge(C,C'), time(T).

% - waiting --------------------------------------------------------------------
action(R,wait(C),T-1) :- position(R,C,T-1), time(T).

position(R,C,T) :- position(R,C',T-1), action(R,move(C',C),T-1), time(T).
position(R,C,T) :- position(R,C ,T-1), action(R,wait(C),T-1), time(T).


% - swapping conflict ----------------------------------------------------------
:- position(R,C,T-1), position(R,C',T), position(R',C',T-1), position(R',C,T), C!=C'.

% - vertex conflict ------------------------------------------------------------
:- position(R,C,T), position(R',C,T), R != R'.

% - auxilaries -----------------------------------------------------------------
:- action(R,move(C,_),T), position(R,C,T), not edge(C ,_).

% ------------------------------------------------------------------------------

goal_reached(R) :- position(robot(R),C,horizon), goal(R,C).

:- not goal_reached(R), robot(R).

% ------------------------------------------------------------------------------

#show.
#show init/2.



%#show occurs(object(robot,R), action(move,D),     T) :    move(robot(R),D,T).
#show action/3.
