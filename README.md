# Decomp-Ordering-Encodings-MAPF
This repo will include the encodings -- written or altered by me -- that I intend to use for my Bachelor Thesis about "Decomposition and Ordering Strategies for the Multi-Agent Pathfinding Problem" 

---

To illustrate the usage of these encodings here an examplary workflow:

  The file ```action-m.lp``` is an extended version of the **ASPRILO** encoding which uses heuristical values to support the pathfinding process. \
  For that an input of the form: ```priority(R,P)``` where P is a priority-score for robot R. To obtain this score, I wrote (this far) two encodings which will calculate the score. One is based on the *Manhattan-Distance*, while the other first calculates the *optimal single-agent plan (OSAP)* and returns its *length*. An exemplary call could look like this: \
\
```clingo get_manhattan_distance.lp instance.lp --outf=1 > output.lp``` \
or  \
```clingo get_osap_length.lp instance.lp -c horizon=20 --outf=1 > output.lp``` respectively. \
\
As of now these calls will not directly return a statement that looks like the desired output but rather the statements: ```manhattan_distance(R,L)``` or ```osap_length(R,L)``` where R and L are of course the robot identifier and the respective length. A conversion then is as easy as pie.

---

The ```analyze_instance.lp``` encoding provides some information about the instance that is to be solved. As of now the following attributes are extracted: (crossed points are not yet implemented but very much planned)
* amount of robots
* amount of goals
* percentage of driveable spaces (amount of activated nodes / total grid-size) in the range of (0..100)
* optimal single agent plan lengths and with them:
  - the longest OSAP
  - ~the shortest OSAP~
  - ~median~
  - ~the average connectivity of nodes along the paths~
