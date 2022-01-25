#include "./get_osap.lp".

osap_length(R,L) :- finish(R,L,_,_).
priority(R,P)    :- osap_length(R,-P).


#show init/2.
#show priority/2.
