/* Player turn */
p1Turn('Player') :- 
    nl, write('Player - your turn:'), nl,
    p1player.

p1Turn('Player 1') :-
    nl, write('Player 1 - your turn:'), nl,
    p1player.

p2Turn('Player 2') :-
    nl, write('Player 2 - your turn:'), nl,
    p2player.

/* Gets player move info if is the first player */
p1player :-
    chooseMovePiece([pA, pB, pC, pD, pE, pF]),
    choosePinPiece([pA, pB, pC, pD, pE, pF]),
    choosePinPiece([pA, pB, pC, pD, pE, pF]).

/* Gets player move info if is the sencond player */
p2player :-
    chooseMovePiece([p1, p2, p3, p4, p5, p6]),
    choosePinPiece([p1, p2, p3, p4, p5, p6]),
    choosePinPiece([p1, p2, p3, p4, p5, p6]).

chooseMovePiece(Pieces) :-
    write('Choose piece to move (ex. pX): '),
    read(Piece), nl,
    if_then_else(validPieceLoop(Piece, Pieces), chooseMove(Piece), callback_chooseMovePiece(Pieces)).

callback_chooseMovePiece(Pieces) :-
    write('Invalid Piece. '),
    chooseMovePiece(Pieces).
    
/* Loop to receive valid piece */
validPieceLoop(Piece, Pieces) :-
    has_element(Piece, Pieces),
    board(T),
    has_element_matrix(Piece, T).

/* Chooses target square for movement */
chooseMove(Piece) :-
    board(T),
    index(T, Row, Col, Piece),
    getAvailableMoves(Piece, Row, Column, [], Moves, 5, 5),
    write('Available moves [row, column]: '),
    write(Moves), nl,
    write('Choose target row: '),
    read(TrgRow),
    write('Choose target column: '),
    read(TrgCol),
    if_then_else(validMoveLoop(Moves, TrgRow, TrgCol), move(Piece, Row, Col, TrgRow, TrgCol), callback_chooseMove(Piece)).

/* Loop to receive valid move target */
validMoveLoop(Moves, TrgRow, TrgCol) :-
    has_element([TrgRow, TrgCol], Moves).

callback_chooseMove(Piece) :-
    write('\nInvalid target. '),
    chooseMove(Piece).

%TODO
choosePinPiece(_).