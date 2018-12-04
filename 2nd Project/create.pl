:- use_module(library(random)).
:- use_module(library(lists)).

createSolution(Sol, N) :-
    NewN is N - 1,
    length(Sol, NewN),
    maplist(createLine(NewN), Sol).

createLine(N, Elem) :-
    length(Elem, N),
    maplist(random(0,2), Elem).

createEmptySolution(Sol, N) :-
    NewN is N - 1,
    length(Sol, NewN),
    maplist(createEmptyLine(NewN), Sol).

createEmptyLine(N, Elem) :-
    length(Elem, N),
    maplist(random(0,1), Elem).
