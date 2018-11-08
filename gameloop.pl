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

/* Computer turn */
p2Turn('Computer') :- 
    nl, write('Computer - your turn:'), nl,
    p2computer.

p1Turn('Computer 1') :-
    nl, write('Computer 1 - your turn:'), nl,
    p1computer.

p2Turn('Computer 2') :-
    nl, write('Computer 2 - your turn:'), nl,
    p2computer.

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
    write('Choose piece to move: (ex. pX) '),
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

getAvailableMoves(_, _, _, Return, Return, 0, 1).
getAvailableMoves(Piece, Row, Column, Moves, Return, 0, PinY) :-
    NewY is PinY - 1,
    getAvailableMoves(Piece, Row, Column, Moves, Return, 5, NewY).
getAvailableMoves(Piece, Row, Column, Moves, Return, PinX, PinY) :-
    NewX is PinX - 1,
    board(T),
    index(T, PieceX, PieceY, Piece),
    Xdiff is PinX-3,
    Ydiff is 3-PinY,
    Xpos is PieceX+Xdiff,
    Ypos is PieceY-Ydiff,
    append(Moves, [[Xpos, Ypos]], NewMoves),
    if_then_else(checkPin(Piece, PinX, PinY),
                 getAvailableMoves(Piece, Row, Column, NewMoves, Return, NewX, PinY),
                 getAvailableMoves(Piece, Row, Column, Moves, Return, NewX, PinY)).
    
checkPin(Piece, PinX, PinY) :-
    piece(Piece, Mat),
    index(Mat, PinX, PinY, 'o'),
    board(T),
    index(T, PieceX, PieceY, Piece),
    Xdiff is PinX-3,
    Ydiff is PinY-3,
    PieceX+Xdiff > 0,
    PieceX+Xdiff < 7,
    PieceY+Ydiff > 0,
    PieceY+Ydiff < 7.

checkPin(Piece, PinX, PinY) :-
    piece(Piece, Mat),
    index(Mat, PinX, PinY, 'x'),
    board(T),
    index(T, PieceX, PieceY, Piece),
    Xdiff is PinX-3,
    Ydiff is PinY-3,
    PieceX+Xdiff > 0,
    PieceX+Xdiff < 7,
    PieceY+Ydiff > 0,
    PieceY+Ydiff < 7.

/* Loop to receive valid move target */
validMoveLoop(Moves, TrgRow, TrgCol) :-
    has_element([TrgRow, TrgCol], Moves).

callback_chooseMove(Piece) :-
    write('\nInvalid target. '),
    chooseMove(Piece).

move(Piece, Row, Col, TrgRow, TrgCol) :-
    board(T),
    setElemMatrix(Row, Col, 'e', T, NewBoard),
    setElemMatrix(TrgRow, TrgCol, Piece, NewBoard, FinalBoard),
    retract(board(T)),
    assert(board(FinalBoard)).

p1computer.
p2computer.
choosePinPiece(_).

/* Loop do jogo */
gameloop(Player1, Player2) :-
    p1Turn(Player1),
    (
        game_over(Player1, Player2),
        board(T),
        display_board(T,Player1),
        (p2Turn(Player2), 
            (
                game_over(Player1, Player2),
                board(NewT),
                display_board(NewT, Player2),
                gameloop(Player1, Player2)    
            )
        )
    ).
    
startGame(Player1, Player2) :-
    board(T),
    display_board(T,Player1),
    gameloop(Player1, Player2).
