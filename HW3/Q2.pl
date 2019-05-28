% LCA(x, y) =
% { x                   , if x = y or x = parent(y)
% { LCA(parent(x), y)   , otherwise

ancestor(A,B) :- parent(A,B). % if A is B's parent then A is B's ancestor
ancestor(A,B) :- parent(X,B),ancestor(A,X). % if X is B's parent and A is X's ancestor then A is B's ancesor

lca(A,B) :- 
  A==B -> write(A);
  ancestor(A,B) -> write(A);
  parent(X,A),lca(X,B).

loopInput(0).
loopInput(N) :-
  N > 0,
  read(X1), read(X2),
  asserta(parent(X1,X2)),
  M is N - 1,
  loopInput(M)
  . 

loopCall(0).
loopCall(N) :-
  N > 0,
  %write(N), nl,
  read(X1), read(X2),
  write('Ans: '), lca(X1,X2), nl,
  M is N - 1,
  loopCall(M)
  . 

main :-
  read(Num),
  Num1 is Num - 1,
  loopInput(Num1),
  read(Num2),
  loopCall(Num2),
  halt
  . 

:- initialization(main).
