:- consult('display.pl').
:- consult('utility.pl').
:- consult('create.pl').
:- consult('solve.pl').

doors(N) :-
    prompt(_, ''),
    nl, write('Puzzle:'), nl, nl,
    createPuzzle(N, Puzzle),
    createEmptyGrid(EmptyLines, EmptyCols, N),
    drawPuzzle(Puzzle, EmptyLines, EmptyCols, N),
    write('Press ENTER to show solution.'),
    get_code(C),
    if_then_else(C =:= 10, true, skip_line),
    solvePuzzle(Puzzle, Lines, Cols, N),
    nl, write('Solution:'), nl, nl,
    drawPuzzle(Puzzle, Lines, Cols, N).