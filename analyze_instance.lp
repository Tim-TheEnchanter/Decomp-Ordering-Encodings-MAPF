% this encoding will provide some information about a MAPF instance, like:
%     the number of robots/goals
%     the percentage of drivable spaces compared to the whole grid
%     information about the optimal single agent plans (OSAPs):
%           mean length, shortest, longest, median, (25 percentile, 75 percentile)


% give information about amount of robots and goals

robot(R)    :- init(object(robot,R), value(at,(_,_))).
goal(S,X,Y) :- init(object(shelf,S), value(at,(X,Y))).

number_robots(N)  :- N = #count{  R: robot(R)     }.
number_goals(N)   :- N = #count{  S: goal(S,_,_)  }.


% give percentage of drivable spaces.

nd(N,X,Y) :- init(object(node,N),value(_,(X,Y))).

length_x(L) :- L = X_MAX - X_MIN, X_MAX = #max{  X: nd(N,X,Y)  }, X_MIN = #min{  X: nd(N,X,Y)  }.
length_y(L) :- L = Y_MAX - Y_MIN, Y_MAX = #max{  Y: nd(N,X,Y)  }, Y_MIN = #min{  Y: nd(N,X,Y)  }.
total_nodes(N)  :- N = X*Y, length_x(X), length_y(Y).

number_nodes(C) :- C = #count{  N: nd(N,_,_)  }.

percentage_driveable(P) :- P = C * 100 / N, number_nodes(C), total_nodes(N).

% give information about OSAPs

#include "./get_osap_length.lp".

max_osap_length(L)  :- L = #max{  T: osap_length(R,T)   }.
%min_osap_length(L)  :- L = #min{  T: osap_length(R,T)}.
mean_osap_length(L) :- L = S/N, S = #sum{  T: osap_length(R,T)   } , number_robots(N).


#show number_robots/1.
#show number_goals/1.
%   #show total_nodes/1.
%   #show number_nodes/1.
#show percentage_driveable/1.
#show osap_length/2.
#show max_osap_length/1.
#show min_osap_length/1.
#show mean_osap_length/1.
