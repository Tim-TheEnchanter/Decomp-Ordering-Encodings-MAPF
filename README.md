# Decomp-Ordering-Encodings-MAPF
This repo will include the encodings -- written or altered by me -- that I intend to use for my Bachelor Thesis about "Decomposition and Ordering Strategies for the Multi-Agent Pathfinding Problem" 
---

To illustrate the usage of these encodings here an examplary workflow:

  The file ```action-m.lp``` is an extended version of the **ASPRILO** encoding which uses heuristical values to support the pathfinding process. \
  For that an input of the form: ```priority(R,P)``` where P is a priority-score for robot R. To obtain this score, I wrote (this far) two encodings which will calculate the score. One is based on the Manhattan-Distance, while the other first calculates the optimal single-agent plan (OSAP) and returns its length. An exemplary call could look like this: \
\
```clingo get_manhattan_distance.lp instance.lp --outf=1 > output.lp``` \
or  \
```clingo get_osap_length.lp instance.lp -c horizon=20 --outf=1 > output.lp``` respectively. \
\

