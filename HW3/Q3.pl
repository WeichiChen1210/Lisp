traverse(A,B) :-
  A == B -> write('Yes'), !;
  edge(A,B) -> write('Yes'), !;
  edge(A,X),
  not(vis(X)),
  asserta((vis(X) :- true,!)),
  traverse(X,B),
  retract((vis(X) :- true,!))
  .

traverse(A,B) :-
  write('No').

loopInput(0).
loopInput(N) :-
  N > 0,
  read(X1), read(X2),
  asserta(edge(X1,X2)),
  asserta(edge(X2,X1)),
  M is N - 1,
  loopInput(M)
  . 

loopCall(0, N).
loopCall(N, Nodes) :-
  N > 0,
  read(X1), read(X2),
  traverse(X1,X2), nl,
  M is N - 1,
  loopCall(M, Nodes)
  . 
 
initializeNodes(0).
initializeNodes(N) :-
  N > 0,
  assertz((vis(N) :- false)),
  M is N - 1,
  initializeNodes(M)
  .

main :-
  read(Nodes), read(Edges),
  initializeNodes(Nodes),
  loopInput(Edges),
  read(Num),
  loopCall(Num, Nodes),
  halt
  . 

:- initialization(main).