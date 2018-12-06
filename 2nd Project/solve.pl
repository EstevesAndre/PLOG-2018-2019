:- use_module(library(clpfd)).

solvePuzzle(Puzzle, Lines, Cols, N) :-
    length(Lines, N),
    length(Cols, N),
    NDoors is N - 1,
    fixMatrixColumns(Lines, NDoors),
    fixMatrixColumns(Cols, NDoors),
    solveNumbers(Puzzle, Lines, Cols, 0, 0, N),
    labeling([], Lines),
    labeling([], Cols).

solveNumbers(_, _, _, _, Size, Size):- !.

solveNumbers(Puzzle, Lines, Columns, Size, Y, Size):- !,
    NewY is Y + 1,
    solveNumbers(Puzzle, Lines, Columns, 0, NewY, Size).

solveNumbers(Puzzle, Lines, Columns, X, Y, Size):-
    calculateDoors(Puzzle, Lines, Columns, X, Y),
    NewX is X + 1,
    solveNumbers(Puzzle, Lines, Columns, NewX, Y, Size).

calculateDoors(Puzzle, Lines, Columns, X, Y):-
    nth0(X, Lines, Line),
    nth0(Y, Columns, Column),
    divide(Line, LeftAux, Right, Y),
    divide(Column, UpAux, Down, X),
    reverse(LeftAux,Left),
    reverse(UpAux, Up),
    (element(ValLeftAux, Left, 1) #/\ ValLeft #= ValLeftAux - 1) #\/ length(Left,ValLeft),
    (element(ValRightAux, Right, 1) #/\ ValRight #= ValRightAux - 1) #\/ length(Right,ValRight),
    (element(ValUpAux, Up, 1) #/\ ValUp #= ValUpAux - 1) #\/ length(Up,ValUp),
    (element(ValDownAux, Down, 1) #/\ ValDown #= ValDownAux - 1) #\/ length(Down,ValDown),
    matrix(Puzzle, X, Y, Value),
    ValLeft + ValRight + ValUp + ValDown #= Value - 1.