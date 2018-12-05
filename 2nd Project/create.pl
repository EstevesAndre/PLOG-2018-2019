:- use_module(library(random)).
:- use_module(library(lists)).

createSolution(Sol, N) :-
    NewN is N - 1,
    length(Sol, N),
    maplist(createLine(NewN), Sol).

createLine(N, Elem) :-
    length(Elem, N),
    maplist(random(0,2), Elem).

createEmptySolution(Sol, N) :-
    NewN is N - 1,
    length(Sol, N),
    maplist(createEmptyLine(NewN), Sol).

createEmptyLine(N, Elem) :-
    length(Elem, N),
    maplist(random(0,1), Elem).

createGrid(Lines,Columns, N):-
    createSolution(Lines,N),
    createSolution(Columns,N).

createEmptyGrid(Lines,Columns, N):-
    createEmptySolution(Lines,N),
    createEmptySolution(Columns,N).

createEmptyPuzzle(Size,Puzzle):-
    length(Puzzle,Size),
    maplist(createEmptyLine(Size), Puzzle).

matrix(Matrix, I, J, Value) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Value).

replace( Matrix , X , Y , NewVal , NewMatrix ) :-
    append(RowPfx,[Row|RowSfx],Matrix),
    length(RowPfx,X),
    append(ColPfx,[_|ColSfx],Row),
    length(ColPfx,Y),
    append(ColPfx,[NewVal|ColSfx],RowNew),
    append(RowPfx,[RowNew|RowSfx],NewMatrix).

createPuzzle(Lines,Columns, Size, Puzzle):-
    createGrid(Lines,Columns, Size),
    createEmptyGrid(EmptyLines, EmptyColumns, Size),
    createEmptyPuzzle(Size,EmptyPuzzle),
    fillPuzzle(EmptyPuzzle, Lines, Columns, 0, 0, Size, Puzzle),
    drawPuzzle(Puzzle, EmptyLines, EmptyColumns, Size),
    drawPuzzle(Puzzle, Lines, Columns, Size).

fillPuzzle(Puzzle, _, _, _, Size, Size, Puzzle):- !.

fillPuzzle(Puzzle, Lines, Columns, Size, Y, Size, Return):- !,
    NewY is Y + 1,
    fillPuzzle(Puzzle, Lines, Columns, 0, NewY, Size, Return).

fillPuzzle(Puzzle, Lines, Columns, X, Y, Size, Return):-
    calculateValue(Lines, Columns, X, Y, Value),
    replace(Puzzle, X, Y, Value, NewPuzzle),
    NewX is X + 1,
    fillPuzzle(NewPuzzle, Lines, Columns, NewX, Y, Size, Return).

divide(List, L1, L2, Index):-
    length(List, Length),
    AuxLength is Length - Index,
    append(L1, L2, List),
    length(L1, Index),
    length(L2, AuxLength).    

if_then_else(Condition, Action1, _):- Condition, !, Action1.
if_then_else(_,_,Action2):- Action2.

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
    nl,
    drawPuzzle(Puzzle, Lines, Columns, Size, 1).

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

applyToList([], _, _, []).

applyToList([L1|L], Pred, Arg, [R1|R]) :-
    O =.. [Pred, Arg, L1, R1],
    O,
    applyToList(L, Pred, Arg, R).

getLine(Columns, X, Column) :-
    applyToList(Columns, nth1, X, Column).

drawLine([]) :- nl.

drawLine([C|Column]) :-
    if_then_else(C =:= 1, write('---'), write('   ')),
    write(' '),
    drawLine(Column).