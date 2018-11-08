getAvailablePinSpaces(_, Return, Return, 0, 1).
getAvailablePinSpaces(Piece, Spaces, Return, 0, PinY) :-
    NewY is PinY - 1,
    getAvailablePinSpaces(Piece, Spaces, Return, 5, NewY).
getAvailablePinSpaces(Piece, Spaces, Return, PinX, PinY) :-
    piece(Piece, Mat),
    NewX is PinX - 1,
    index(Mat, PinX, PinY, Val),
    append(Spaces, [[PinX, PinY]], NewSpaces),
    if_then_else(Val = '.',
                getAvailablePinSpaces(Piece, NewSpaces, Return, NewX, PinY),
                getAvailablePinSpaces(Piece, Spaces, Return, NewX, PinY)).

getAvailableMoves(_, Return, Return, 0, 1).
getAvailableMoves(Piece, Moves, Return, 0, PinY) :-
    NewY is PinY - 1,
    getAvailableMoves(Piece, Moves, Return, 5, NewY).
getAvailableMoves(Piece, Moves, Return, PinX, PinY) :-
    NewX is PinX - 1,
    board(T),
    index(T, PieceX, PieceY, Piece),
    Xdiff is PinX-3,
    Ydiff is 3-PinY,
    Xpos is PieceX+Xdiff,
    Ypos is PieceY-Ydiff,
    append(Moves, [[Xpos, Ypos]], NewMoves),
    if_then_else(checkPin(Piece, PinX, PinY),
                 getAvailableMoves(Piece, NewMoves, Return, NewX, PinY),
                 getAvailableMoves(Piece, Moves, Return, NewX, PinY)) , !.
    
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

move(Piece, Row, Col, TrgRow, TrgCol) :-
    board(T),
    setElemMatrix(Row, Col, 'e', T, NewBoard),
    setElemMatrix(TrgRow, TrgCol, Piece, NewBoard, FinalBoard),
    retract(board(T)),
    assert(board(FinalBoard)).

pin(Piece, TrgRow, TrgCol) :-
    piece(Piece, Mat),
    index(Mat, 3, 3, Val),
    if_then_else(has_element(Val, ['A', 'B', 'C', 'D', 'E', 'F']),
                setElemMatrix(TrgRow, TrgCol, 'o', Mat, NewMat),
                setElemMatrix(TrgRow, TrgCol, 'x', Mat, NewMat)),
    retract(piece(Piece, Mat)),
    assert(piece(Piece, NewMat)).

/* Player and computer turns */
p1Turn('Player') :- 
    !, nl, write('Player - your turn:'), nl,
    p1player.

p1Turn('Player 1') :-
    !, nl, write('Player 1 - your turn:'), nl,
    p1player.

p1Turn('Computer 1') :-
    !, nl, write('Computer 1 - your turn:'), nl,
    p1computer.

p2Turn('Player 2') :-
    !, nl, write('Player 2 - your turn:'), nl,
    p2player.

p2Turn('Computer') :- 
    !, nl, write('Computer - your turn:'), nl,
    p2computer.

p2Turn('Computer 2') :-
    !, nl, write('Computer 2 - your turn:'), nl,
    p2computer.


/* Loop do jogo */
gameloop(Player1, Player2) :-
    p1Turn(Player1),
    game_over(Player1, Player2),
    board(T),
    display_board(T,Player1),
    p2Turn(Player2), 
    game_over(Player1, Player2),
    board(NewT),
    display_board(NewT, Player2),
    gameloop(Player1, Player2).
    
startGame(Player1, Player2) :-
    board(T),
    display_board(T,Player1),
    gameloop(Player1, Player2).
