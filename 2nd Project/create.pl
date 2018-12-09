:- use_module(library(random)).
:- use_module(library(lists)).

/*
    For each line of Sol (N lines), it maps it with values 1 or 0.
*/
createSolution(Sol, N) :-
    NewN is N - 1,
    length(Sol, N),
    maplist(createLine(NewN), Sol).

/*
    Fills a certain line of the solution with 1's (closed doors) and 0's (open doors)
*/
createLine(N, Elem) :-
    length(Elem, N),
    maplist(random(0,2), Elem).

/*
    Creates a solution of only open doors (for puzzle drawing purposes)
*/
createEmptySolution(Sol, N) :-
    NewN is N - 1,
    length(Sol, N),
    maplist(createEmptyLine(NewN), Sol).

/*
    Fills a certain line of the solution with 0's (open doors)
*/
createEmptyLine(N, Elem) :-
    length(Elem, N),
    maplist(random(0,1), Elem).

/*
    Creates a random solution for the puzzle
*/
createGrid(Lines,Columns, N):-
    createSolution(Lines,N),
    createSolution(Columns,N).

/*
    Creates an empty solution for the puzzle (for drawing purposes)
*/
createEmptyGrid(Lines,Columns, N):-
    createEmptySolution(Lines,N),
    createEmptySolution(Columns,N).

/*
    Iterates over puzzle (an empty puzzle) to calculate the value of each room
*/
fillPuzzle(Puzzle, _, _, _, Size, Size, Puzzle):- !.
fillPuzzle(Puzzle, Lines, Columns, Size, Y, Size, Return):- !,
    NewY is Y + 1,
    fillPuzzle(Puzzle, Lines, Columns, 0, NewY, Size, Return).
fillPuzzle(Puzzle, Lines, Columns, X, Y, Size, Return):-
    calculateValue(Lines, Columns, X, Y, Value),
    replace(Puzzle, X, Y, Value, NewPuzzle),
    NewX is X + 1,
    fillPuzzle(NewPuzzle, Lines, Columns, NewX, Y, Size, Return).

/*
    Calculates the value of a certain room, by finding the first closed door in each direction
*/
calculateValue(Lines, Columns, X, Y, Value):-
    nth0(X, Lines, Line),
    nth0(Y, Columns, Column),
    divide(Line, LeftAux, Right, Y),
    divide(Column, UpAux, Down, X),
    reverse(LeftAux,Left),
    reverse(UpAux, Up),
    if_then_else( nth0(ValLeft, Left, 1), true, length(Left,ValLeft)),
    if_then_else( nth0(ValRight, Right, 1), true, length(Right,ValRight)),
    if_then_else( nth0(ValUp, Up, 1), true, length(Up,ValUp)),
    if_then_else( nth0(ValDown, Down, 1), true, length(Down,ValDown)),
    Value is ValLeft + ValRight + ValUp + ValDown + 1.

/*
    Creates a puzzle with size Size and all values = 0, so that it can be latter filled with a solution
*/
createEmptyPuzzle(Size,Puzzle):-
    length(Puzzle,Size),
    maplist(createEmptyLine(Size), Puzzle).

/*
    Creates a puzzle with size Size, returning it in Puzzle and its solution in Lines (matrix of horizontal
    doors) and Columns (matrix of vertival doors)
*/
createPuzzle(Size, Puzzle, Lines, Columns):-
    createGrid(Lines,Columns, Size),
    createEmptyPuzzle(Size,EmptyPuzzle),
    fillPuzzle(EmptyPuzzle, Lines, Columns, 0, 0, Size, Puzzle).