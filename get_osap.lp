% definition of all directions
dir(1,0). dir(-1,0). dir(0,1). dir(0,-1). dir(0,0).

goal(S,X,Y) :- init(object(destination,S), value(at,(X,Y))).
robot(R)    :- init(object(robot,R), _).

% define nodes
nd(N,X,Y) :- init(object(node,N),value(_,(X,Y))).
% define edges between two adjacent nodes
edge(X,Y, X+Dx,Y+Dy) :- nd(N,X,Y), nd(NN,X+Dx,Y+Dy), dir(Dx,Dy).
edge(X,Y,XX,YY) :- edge(XX,YY,X,Y).

path(R,X,Y,0) :- init(object(robot,R), value(at,(X,Y))), goal(R,_,_).

{path(R,XX,YY,T+1)}1 :- path(R,X,Y,T), edge(X,Y,XX,YY), T < horizon.

% robot cannot move in different directions at the same timestep
:- path(R,X,Y,T), path(R,XX,YY,T), (X,Y)!= (XX,YY).
%robot doesnt move after goal is reached
:- path(R,X,Y,T), goal(R,X,Y), path(R,_,_,T+1).

finish(R,T,X,Y) :- path(R,X,Y,T), goal(R,X,Y).
:- not finish(R,_,_,_), robot(R).
