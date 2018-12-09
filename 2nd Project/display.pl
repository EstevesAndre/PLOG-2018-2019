:- use_module(library(lists)).

/*
    Iterates over puzzle, drawing at the same time closed doors and puzzle numbers

    If the puzzle is to be shown unsolved, a solution of only opens doors (0) should be passed
    as argument (i.e. in Lines and Columns)
*/
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

/*
    Draws a line of the puzzle, alternating puzzle numbers an possible closed doors
*/
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

/*
    Finds the Xth line of doors in Columns
*/
getLine(Columns, X, Column) :-
    applyToList(Columns, nth1, X, Column).

/*
    Draws a line of vertical doors between lines
*/
drawLine([]) :- nl.
drawLine([C|Column]) :-
    if_then_else(C =:= 1, write('---'), write('   ')),
    write(' '),
    drawLine(Column).