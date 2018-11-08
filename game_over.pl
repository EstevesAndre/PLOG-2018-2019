/* Checks for game over conditions. If fail, game is over */

game_over(Player1, Player2) :-
    winnerP1(Player1),
    winnerP2(Player2).

winnerP1(_) :-
    checkPlayerPieces([p1, p2, p3, p4, p5, p6], 0),
    checkP1Pins, !.

winnerP1(Player1) :-
    write(Player1),
    write(' wins!'), nl, nl,
    fail.

winnerP2(_) :-
    checkPlayerPieces([pA, pB, pC, pD, pE, pF], 0),
    checkP2Pins, !.

winnerP2(Player2) :-
    write(Player2),
    write(' wins!'), nl, nl,
    fail.

checkPlayerPieces([], Cnt) :- Cnt \= 1. 

checkPlayerPieces([P|Ps], Cnt) :-
    Inc is Cnt+1,
    board(T),
    if_then_else(has_element_matrix(P, T), checkPlayerPieces(Ps, Inc), checkPlayerPieces(Ps, Cnt)).

checkP1Pins :-
    checkFullPins(pA),
    checkFullPins(pB),
    checkFullPins(pC),
    checkFullPins(pD),
    checkFullPins(pE),
    checkFullPins(pF).

checkP2Pins :-
    checkFullPins(p1),
    checkFullPins(p2),
    checkFullPins(p3),
    checkFullPins(p4),
    checkFullPins(p5),
    checkFullPins(p6).

checkFullPins(Piece) :-
    piece(Piece, Mat),
    has_element_matrix('.', Mat).
