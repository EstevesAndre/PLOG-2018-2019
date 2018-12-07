:- consult('display.pl').
:- consult('utility.pl').
:- consult('create.pl').
:- consult('solve.pl').

doors(N) :-
    prompt(_, ''),
    nl, write('Puzzle:'), nl, nl,
    createPuzzle(N, Puzzle, _, _),
    createEmptyGrid(EmptyLines, EmptyCols, N),
    drawPuzzle(Puzzle, EmptyLines, EmptyCols, N),
    write('Press ENTER to show solution.'),
    get_code(C),
    if_then_else(C =:= 10, true, skip_line),
    solvePuzzle(Puzzle, Sol, N),
    length(Sol, L),
    Length is L div 2,
    length(AuxLines, Length),
    length(AuxCols, Length),
    append(AuxLines, AuxCols, Sol),
    AuxLength is N - 1,
    listToMatrix(AuxLines, Lines, N, AuxLength),
    listToMatrix(AuxCols, Cols, N, AuxLength),
    nl, write('Solution:'), nl, nl,
    drawPuzzle(Puzzle, Lines, Cols, N).