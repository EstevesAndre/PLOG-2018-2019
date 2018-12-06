if_then_else(Condition, Action1, _):- Condition, !, Action1.
if_then_else(_,_,Action2):- Action2.

applyToList([], _, _, []).
applyToList([L1|L], Pred, Arg, [R1|R]) :-
    O =.. [Pred, Arg, L1, R1],
    O,
    applyToList(L, Pred, Arg, R).

matrix(Matrix, I, J, Value) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Value).

divide(List, L1, L2, Index):-
    length(List, Length),
    AuxLength is Length - Index,
    append(L1, L2, List),
    length(L1, Index),
    length(L2, AuxLength).

fixMatrixColumns([], _).

fixMatrixColumns([Line|Matrix], Size) :-
    length(Line, Size),
    domain(Line, 0, 1),
    fixMatrixColumns(Matrix, Size).

matrixToList([], []).
matrixToList([[] | Matrix], List) :-
    matrixToList(Matrix, List).
matrixToList([[L|L1] | Matrix], [L|List]) :-
    matrixToList([L1|Matrix], List).

listToMatrix(List, Matrix, NRows, NCols) :-
    listToMatrix(List, Matrix, 0, 0, NRows, NCols).

listToMatrix([], [], NRows, _, NRows, _).
listToMatrix(List, [[]|Matrix], Row, NCols, NRows, NCols) :-
    NextRow is Row + 1,
    listToMatrix(List, Matrix, NextRow, 0, NRows, NCols).
listToMatrix([L|List], [[L|L1]|Matrix], Row, Col, NRows, NCols) :-
    NextCol is Col + 1,
    listToMatrix(List, [L1|Matrix], Row, NextCol, NRows, NCols).