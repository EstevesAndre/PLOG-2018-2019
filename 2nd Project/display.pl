:- use_module(library(lists)).

drawPuzzle(Puzzle, Lines, _, X, X) :- !, 
    nth1(X, Puzzle, Number),
    nth1(X, Lines, Line),
    drawNumber(Number, Line, X, 1).

drawPuzzle(Puzzle, Lines, Columns, Size, X) :-
    nth1(X, Puzzle, Number),
    nth1(X, Lines, Line),
    drawNumber(Number, Line, Size, 1),
    getLine(Columns, X, Column),
    drawLine(Column),
    NextX is X + 1,
    drawPuzzle(Puzzle, Lines, Columns, Size, NextX).

drawPuzzle(Puzzle, Lines, Columns, Size) :-
    drawPuzzle(Puzzle, Lines, Columns, Size, 1),
    nl, nl.

drawNumber(Number, _, Y, Y) :-
    nth1(Y, Number, N),
    write(' '), write(N), write(' '),
    nl.

drawNumber(Number, Line, Size, Y) :-
    nth1(Y, Number, N),
    write(' '), write(N), write(' '),
    nth1(Y, Line, Door),
    if_then_else(Door =:= 1, write('|'), write(' ')),
    NewY is Y + 1,
    drawNumber(Number, Line, Size, NewY).

applyToList([], _, _, []).

applyToList([L1|L], Pred, Arg, [R1|R]) :-
    O =.. [Pred, Arg, L1, R1],
    O,
    applyToList(L, Pred, Arg, R).

getLine(Columns, X, Column) :-
    applyToList(Columns, nth1, X, Column).

drawLine([]) :- nl.

drawLine([C|Column]) :-
    if_then_else(C =:= 1, write('---'), write('   ')),
    write(' '),
    drawLine(Column).