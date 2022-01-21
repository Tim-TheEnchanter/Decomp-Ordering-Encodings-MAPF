# Decomp-Ordering-Encodings-MAPF
This repo will include the encodings -- written or altered by me -- that I intend to use for my Bachelor Thesis about "Decomposition and Ordering Strategies for the Multi-Agent Pathfinding Problem" 

---
The file ```action-M.lp``` is an extended version of the **ASPRILO** encoding which uses heuristical values to support the pathfinding process. \
For that an input of the form ```priority(R,P)``` is needed, where ```P``` is a priority-score for robot ```R```. To obtain this score, I wrote (this far) two encodings which will calculate the score. One is based on the *Manhattan-Distance*, while the other first calculates the *optimal single-agent plan (OSAP)* and then returns its *length*. An exemplary call could look like this: \
\
```clingo get_manhattan_distance.lp instance.lp --outf=1 > output.lp``` \
or  \
```clingo get_osap_length.lp instance.lp -c horizon=20 --outf=1 > output.lp``` respectively. \
\
As of now these calls will not directly return a statement that looks like the desired output but rather the statements: ```manhattan_distance(R,L)``` or ```osap_length(R,L)``` where ```R``` and ```L``` are of course the robot identifier and the respective length. A conversion then is as easy as pie.

---

The ```analyze_instance.lp``` encoding provides some information about the instance that is to be solved. As of now the following attributes are extracted: (crossed points are not yet implemented but very much planned)
* amount of robots
* amount of goals
* percentage of driveable spaces (amount of activated nodes / total grid-size) in the range from ```0``` to ```100```
* optimal single agent plan lengths and with them:
  - length of the longest OSAP
  - ~length of the shortest OSAP~
  - mean length
  - ~median~
  - ~the average connectivity of nodes along the paths~
  - ~the amount of times a node is crossed along all OSAPs~

These metrics may come in handy when it comes to evaluating decomposition and ordering strategies as it (hopefully) gives insights on when and why strategies work/don't work well. \
\
POSSIBLE OBSERVATION (needs to be researched): 
> THESIS: In maze-like structures the OSAP-length may better represent the actual path length needed than the Manhattan-Distance. 

Although this should be the case in all scenarios (bold-statement), in open structures and warehouse-scenarios this may become less relevant: In a completely empty grid, the OSAP is equal to the Manhattan-Distance. Thus it makes sense that the Manhattan-Distance gives better results the more open a space is. The attributes ```percentage_driveable``` and ```avrg_connectivity_along_osap``` may give a deeper understanding.
