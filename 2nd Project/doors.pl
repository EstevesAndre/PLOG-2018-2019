:- consult('display.pl').
:- consult('utility.pl').
:- consult('create.pl').

doors(N) :-
    prompt(_, ''),
    nl, write('Puzzle:'), nl, nl,
    createPuzzle(N, Puzzle),
    createEmptyGrid(Lines, Cols, N),
    drawPuzzle(Puzzle, Lines, Cols, N),
    write('Press ENTER to show solution.'),
    get_code(C),
    if_then_else(C =:= 10, true, skip_line).