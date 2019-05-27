divisible(X,Y) :- 0 is X mod Y, !.

divisible(X,Y) :- X >= (Y+1)*(Y+1), divisible(X, Y+1).

is_prime(2) :- true,!.
is_prime(X) :- X < 2,!,false.
is_prime(X) :- not(divisible(X, 2)).

next_prime(P,P1) :- P1 is P + 2, is_prime(P1), !.
next_prime(P,P1) :- P2 is P + 2, next_prime(P2,P1).

goldbach(4,[2,2]).
goldbach(N,L) :-
  N mod 2 =:= 0,
  N > 4,
  goldbach(N,L,3).

goldbach(N,[P,Q],P) :-
  Q is N - P,
  is_prime(Q), P < Q,
  write(P), write(' '), write(Q),nl,
  P is P + 2,
  goldbach(N,_,P)
  .

goldbach(N,L,P) :-
  P < N/2,
  next_prime(P,P1),
  goldbach(N,L,P1)
  .

goldbach(N,_,P) :-
  P >= N/2,
  halt.


read_input :-
  write('Enter an even number: '),
  read(Input),
  write('Output: '), nl,
  goldbach(Input,_),
  halt
  .
  
:- initialization(read_input).