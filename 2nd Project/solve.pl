:- use_module(library(clpfd)).

/*
    Solves the puzzle Puzzle with size N, placing the solution in Sol

    Sol is not in the same format as he solutions used for display

    Example:
    Size = 4.

    Lines = [[A, B, C],
             [D, E, F],
             [G, H, I],
             [J, K, L]].
    Cols  = [[M, N, O],
             [P, Q, R],
             [S, T, U],
             [V, W, X]].
    
    Sol = [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X].
*/
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
    labeling([bisect], Sol),
    fd_statistics(backtracks, Stats), write(Stats).


/*
    Forces all lines of matrix to be of size Size
*/
fixMatrixColumns([], _).
fixMatrixColumns([Line|Matrix], Size) :-
    length(Line, Size),
    domain(Line, 0, 1),
    fixMatrixColumns(Matrix, Size).


/*
    Iterates over puzzle, adding the necessary restrictions to the solution depending on the value
    of the room
*/
solveNumbers(_, _, _, _, Size, Size):- !.
solveNumbers(Puzzle, Lines, Columns, Size, Y, Size):- !,
    NewY is Y + 1,
    solveNumbers(Puzzle, Lines, Columns, 0, NewY, Size).
    solveNumbers(Puzzle, Lines, Columns, X, Y, Size):-
    calculateDoors(Puzzle, Lines, Columns, X, Y, Size),
    NewX is X + 1,
    solveNumbers(Puzzle, Lines, Columns, NewX, Y, Size).

/*
    Adds restrictions to the solution using the value of a certain room, by searching in all for directions
    for possible places for doors
*/
calculateDoors(Puzzle, Lines, Columns, X, Y, N) :-
    nth0(X, Lines, Line),
    nth0(Y, Columns, Column),
    matrix(Puzzle, X, Y, Value),
    Length is N - 1,
    searchLeft(Line, Y, ValLeft),
    searchLeft(Column, X, ValUp),
    searchRight(Line, Length, Y, ValRight),
    searchRight(Column, Length, X, ValDown),
    ValLeft + ValRight + ValUp + ValDown #= Value - 1.

/*
    Search for a door left of N in List
    (i.e. search for a door left in Lines and up in Columns)
*/
searchLeft(_, 0, Val) :- !, Val #= 0.
searchLeft(List, N, Val) :-
    NextN is N - 1,
    searchLeft(List, NextN, NewVal),
    element(N, List, Elem),
    (Elem #= 1 #/\
    Val #= 0) #\/
    (Elem #= 0 #/\
    Val #= 1 + NewVal).

/*
    Search for a door right of N in List
    (i.e. search for a door right in Lines and down in Columns)
*/
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