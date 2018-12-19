:- consult('display.pl').
:- consult('utility.pl').
:- consult('create.pl').
:- consult('solve.pl').

puzzle(4, Puzzle) :- append([], [ [7,4,4,4],
                            [4,1,2,2],
                            [4,3,4,4],
                            [5,2,2,2]], Puzzle).
puzzle(5, Puzzle) :- append([],[ [2,6,1,3,3],
                            [3,7,3,3,3],
                            [3,5,1,4,4],
                            [4,6,2,3,2],
                            [3,8,4,5,5]], Puzzle).
puzzle(6, Puzzle) :- append([],[ [3,3,2,6,4,4],
                            [3,3,2,5,3,2],
                            [4,2,5,5,2,2],
                            [4,3,6,6,4,3],
                            [6,5,7,5,2,3],
                            [1,1,5,3,2,4]], Puzzle).
puzzle(7,Puzzle) :- append([],[ [5,6,5,3,2,2,6],
                                [4,5,5,4,3,1,5],
                                [3,4,5,4,4,1,5],
                                [3,5,1,2,2,2,6],
                                [3,3,3,3,5,3,6],
                                [3,3,3,3,5,4,4],
                                [2,3,4,4,5,3,4]], Puzzle).

doors(N) :-
    prompt(_, ''),
    % creates and displays a puzzle with N lines and columns
    nl, write('Puzzle:'), nl, nl,
    puzzle(N, Puzzle),
    % createPuzzle(N, Puzzle, _, _),
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