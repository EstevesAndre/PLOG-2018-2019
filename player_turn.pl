/* Gets player move info if is the first player */
p1player :-
    chooseMovePiece([pA, pB, pC, pD, pE, pF]),
    \+choosePinPiece([pA, pB, pC, pD, pE, pF]),
    \+choosePinPiece([pA, pB, pC, pD, pE, pF]).

/* Gets player move info if is the sencond player */
p2player :-
    chooseMovePiece([p1, p2, p3, p4, p5, p6]),
    \+choosePinPiece([p1, p2, p3, p4, p5, p6]),
    \+choosePinPiece([p1, p2, p3, p4, p5, p6]).

/* Chooses piece to move*/
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
    getAvailableMoves(Piece, [], Moves, 5, 5),
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

/* Chooses piece to pin*/
choosePinPiece(Pieces) :-
    write('\nChoose piece to pin (ex. pX - p0 to skip): '),
    read(Piece),
    if_then_else(Piece = 'p0', fail, true),
    if_then_else(validPieceLoopPin(Piece, Pieces), choosePin(Piece), callback_choosePinPiece(Pieces)),
    fail.

validPieceLoopPin(Piece, Pieces) :-
    has_element(Piece, Pieces),
    board(T),
    has_element_matrix(Piece, T),
    piece(Piece, Mat),
    has_element_matrix('.', Mat).

callback_choosePinPiece(Pieces) :-
    write('Invalid Piece. '),
    choosePinPiece(Pieces).

/* Chooses target pin space for pin */
choosePin(Piece) :-
    getAvailablePinSpaces(Piece, [], Spaces, 5, 5),
    write('Available pins [row, column]: '),
    write(Spaces), nl,
    write('Choose target row: '),
    read(TrgRow),
    write('Choose target column: '),
    read(TrgCol),
    if_then_else(validMoveLoop(Spaces, TrgRow, TrgCol), pin(Piece, TrgRow, TrgCol), callback_choosePin(Piece)).

/* Loop to receive valid pin target */
validPinLoop(Spaces, TrgRow, TrgCol) :-
    has_element([TrgRow, TrgCol], Spaces).

callback_choosePin(Piece) :-
    write('\nInvalid target. '),
    choosePin(Piece).
