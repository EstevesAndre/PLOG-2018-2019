/* Implements an if-then-else-like decision stucture

    if(Condition)
    {
        Action1
    }
    else
    {
        Action2
    }
*/
if_then_else(Condition, Action1, _):- Condition, !, Action1.
if_then_else(_,_,Action2):- Action2.

/*
    For each element (L1) of the first list creates the element of the second list (R1), such that
        Pred(Arg, L1, R1) 
    is true.
*/
applyToList([], _, _, []).
applyToList([L1|L], Pred, Arg, [R1|R]) :-
    O =.. [Pred, Arg, L1, R1],
    O,
    applyToList(L, Pred, Arg, R).

/*
    True if the element with row I and column J of Matrix is Value
*/
matrix(Matrix, I, J, Value) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Value).

/*
    Divides a list into two lists using Index as a dividing point

    Example:
        divide([1, 2, 3, 4], L1, L2, 1).
        L1 = [1],
        L2 = [2, 3, 4] ?
*/
divide(List, L1, L2, Index):-
    length(List, Length),
    AuxLength is Length - Index,
    append(L1, L2, List),
    length(L1, Index),
    length(L2, AuxLength).

/*
    True if Matrix and NewMatrix are composed of equal elements, except for the element of row X and column
    Y, which has NewVal value

    i.e., replaces the element of row X and col Y in Matrix with NewVal
*/
replace( Matrix , X , Y , NewVal , NewMatrix ) :-
    append(RowPfx,[Row|RowSfx],Matrix),
    length(RowPfx,X),
    append(ColPfx,[_|ColSfx],Row),
    length(ColPfx,Y),
    append(ColPfx,[NewVal|ColSfx],RowNew),
    append(RowPfx,[RowNew|RowSfx],NewMatrix).

/*
    Converts a matrix to a list, appending each line to the next

    Example:
        matrixToList([[1, 2, 3], [4, 5, 6], [7, 8, 9]], M).
        M = [1, 2, 3, 4, 5, 6, 7, 8, 9] ?
*/
matrixToList([], []).
matrixToList([[] | Matrix], List) :-
    matrixToList(Matrix, List).
matrixToList([[L|L1] | Matrix], [L|List]) :-
    matrixToList([L1|Matrix], List).

/*
    Converts a list to a matrix with NRows rows and NCols columns, assuming each line is followed by
    the next one

    Example:
        listToMatrix([1, 2, 3, 4, 5, 6], L, 2, 3).
        M = [[1, 2, 3], [4, 5, 6]] ?
*/
listToMatrix(List, Matrix, NRows, NCols) :-
    listToMatrix(List, Matrix, 0, 0, NRows, NCols).

listToMatrix([], [], NRows, _, NRows, _).
listToMatrix(List, [[]|Matrix], Row, NCols, NRows, NCols) :-
    NextRow is Row + 1,
    listToMatrix(List, Matrix, NextRow, 0, NRows, NCols).
listToMatrix([L|List], [[L|L1]|Matrix], Row, Col, NRows, NCols) :-
    NextCol is Col + 1,
    listToMatrix(List, [L1|Matrix], Row, NextCol, NRows, NCols).