/* Gets computer move info if is the first player */
p1computer :-
    chooseMovePiece([pA, pB, pC, pD, pE, pF]),
    \+choosePinPiece([pA, pB, pC, pD, pE, pF]),
    \+choosePinPiece([pA, pB, pC, pD, pE, pF]).

/* Gets computer move info if is the sencond player */
p2coumputer :-
    chooseMovePiece([p1, p2, p3, p4, p5, p6]),
    \+choosePinPiece([p1, p2, p3, p4, p5, p6]),
    \+choosePinPiece([p1, p2, p3, p4, p5, p6]).