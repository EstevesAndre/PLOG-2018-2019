:- use_module(library(random)).
:- use_module(library(lists)).

createSolution(Sol, N) :-
    NewN is N - 1,
    length(Sol, N),
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

createGrid(Lines,Columns, N):-
    createSolution(Lines,N),
    createSolution(Columns,N).

drawSolution:-
    createGrid(Lines,Columns, 4),
    draw(Lines,Columns).

draw(Lines,Columns):-
    write(',---,---,---,---,'),nl,
    drawGridSolution(Lines,Columns),
    write('|---,---,---,---|'),nl.

drawGridSolution([],[]).

drawGridSolution([HeadL|Tail1],[HeadC|Tail2]):-
    write('|'), drawLine(HeadL), nl,
    write('|'), drawColumn(HeadC), nl,
    drawGridSolution(Tail1,Tail2).

% drawLine([]):- write('|').

drawLine(_).
drawColumn(_).
