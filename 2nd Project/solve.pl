:- use_module(library(clpfd)).

solvePuzzle(Puzzle, Sol,  N) :-
    length(Lines, N),
    length(Cols, N),
    NDoors is N - 1,
    fixMatrixColumns(Lines, NDoors),
    fixMatrixColumns(Cols, NDoors),
    solveNumbers(Puzzle, Lines, Cols, 0, 0, N),
    matrixToList(Lines, L),
    matrixToList(Cols, C),
    append(L, C, Sol),
    domain(Sol, 0, 1),
    labeling([], Sol).

solveNumbers(_, _, _, _, Size, Size):- !.

solveNumbers(Puzzle, Lines, Columns, Size, Y, Size):- !,
    NewY is Y + 1,
    solveNumbers(Puzzle, Lines, Columns, 0, NewY, Size).

solveNumbers(Puzzle, Lines, Columns, X, Y, Size):-
    calculateDoors(Puzzle, Lines, Columns, X, Y, Size),
    NewX is X + 1,
    solveNumbers(Puzzle, Lines, Columns, NewX, Y, Size).

% calculateDoors(Puzzle, Lines, Columns, X, Y):-
%     nth0(X, Lines, Line),
%     nth0(Y, Columns, Column),
%     divide(Line, LeftAux, Right, Y),
%     divide(Column, UpAux, Down, X),
%     reverse(LeftAux,Left),
%     reverse(UpAux, Up),
%     (element(ValLeftAux, Left, 1) #/\ ValLeft #= ValLeftAux - 1) #\/ length(Left,ValLeft),
%     (element(ValRightAux, Right, 1) #/\ ValRight #= ValRightAux - 1) #\/ length(Right,ValRight),
%     (element(ValUpAux, Up, 1) #/\ ValUp #= ValUpAux - 1) #\/ length(Up,ValUp),
%     (element(ValDownAux, Down, 1) #/\ ValDown #= ValDownAux - 1) #\/ length(Down,ValDown),
%     matrix(Puzzle, X, Y, Value),
%     ValLeft + ValRight + ValUp + ValDown #= Value - 1.

calculateDoors(Puzzle, Lines, Columns, X, Y, N) :-
    nth0(X, Lines, Line),
    nth0(Y, Columns, Column),
    matrix(Puzzle, X, Y, Value),
    CalcValue is Value - 1,
    Length is N - 1,
    searchLeft(Line, Y, ValLeft),
    searchLeft(Column, X, ValUp),
    searchRight(Line, Length, Y, ValRight),
    searchRight(Column, Length, X, ValDown),
    ValLeft + ValRight + ValUp + ValDown #= CalcValue.

searchLeft(_, 0, Val) :- !, Val #= 0.
searchLeft(List, N, Val) :-
    NextN is N - 1,
    searchLeft(List, NextN, NewVal),
    element(N, List, Elem),
    (Elem #= 1 #/\
    Val #= 0) #\/
    (Elem #= 0 #/\
    Val #= 1 + NewVal).

searchRight(_, N, N, Val) :- !, Val #= 0.
searchRight(List, Length, N, Val) :-
    NextN is N + 1,
    searchRight(List, Length, NextN, NewVal),
    Index is N + 1,
    element(Index, List, Elem),
    (Elem #= 1 #/\
    Val #= 0) #\/
    (Elem #= 0 #/\
    Val #= 1 + NewVal). 