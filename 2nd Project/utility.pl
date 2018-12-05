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