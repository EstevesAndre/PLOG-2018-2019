:- consult('display.pl').
:- consult('utility.pl').
:- consult('create.pl').
:- consult('solve.pl').

doors(N) :-
    prompt(_, ''),
    % creates and displays a puzzle with N lines and columns
    nl, write('Puzzle:'), nl, nl,
    createPuzzle(N, Puzzle, _, _),
    createEmptyGrid(EmptyLines, EmptyCols, N),
    drawPuzzle(Puzzle, EmptyLines, EmptyCols, N),
    write('Press ENTER to show solution.'),
    % reads ENTER from input
    get_code(C),
    if_then_else(C =:= 10, true, skip_line),
    % solves puzzle
    solvePuzzle(Puzzle, Sol, N),
    % parses solution
    length(Sol, L),
    Length is L div 2,
    length(AuxLines, Length),
    length(AuxCols, Length),
    append(AuxLines, AuxCols, Sol),
    AuxLength is N - 1,
    listToMatrix(AuxLines, Lines, N, AuxLength),
    listToMatrix(AuxCols, Cols, N, AuxLength),
    % displays solution
    nl, write('Solution:'), nl, nl,
    drawPuzzle(Puzzle, Lines, Cols, N).