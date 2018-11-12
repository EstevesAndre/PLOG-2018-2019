:- use_module(library(random)).

/* Gets computer move info if is the first player */
p1computer(Depth) :-
    random_permutation([pA, pB, pC, pD, pE, pF], Pieces), 
    board(T),
    valid_moves(T, Pieces, [], Moves),
    chooseBestMove(T, Moves, _, BestMove, -1000, _, Pieces, Depth),
    moveAI(BestMove),
    pinAI(Pieces),
    pinAI(Pieces).

/* Gets computer move info if is the sencond player */
p2computer(Depth) :-
    random_permutation([p1, p2, p3, p4, p5, p6], Pieces), 
    board(T),
    valid_moves(T, Pieces, [], Moves),
    chooseBestMove(T, Moves, _, BestMove, -1000, _, Pieces, Depth),
    moveAI(BestMove),
    pinAI(Pieces),
    pinAI(Pieces).

/* Makes a computer piece move */
moveAI([Piece, TrgRow, TrgCol]) :-
    board(T),
    index(T, Row, Col, Piece),
    move(Piece, Row, Col, TrgRow, TrgCol).

/* Gets best pin for computer */
pinAI(Pieces) :-
    choosePinPiece(Pieces, _, Piece, 1000),
    chooseBestPin(Piece, Col, Row),
    pin(Piece, Row, Col).

/* Gets the piece with the least moves available */
choosePinPiece([], PieceRet, PieceRet, _).

choosePinPiece([P|Pieces], Piece, PieceRet, PieceMoves) :-
    getAvailableMoves(P, [], Moves, 5, 5),
    length(Moves, NMoves),
    if_then_else(NMoves < PieceMoves,
                choosePinPiece(Pieces, P, PieceRet, NMoves),
                choosePinPiece(Pieces, Piece, PieceRet, PieceMoves)).

/* Gets best pin for piece */
chooseBestPin(Piece, Row, Col) :-
    getUnvailableMoves(Piece, [], [[Row, Col]|_], 5, 5).  

getUnvailableMoves(_, Return, Return, 0, 1).
getUnvailableMoves(Piece, Moves, Return, 0, PinY) :-
    NewY is PinY - 1,
    getUnvailableMoves(Piece, Moves, Return, 5, NewY).
getUnvailableMoves(Piece, Moves, Return, PinX, PinY) :-
    NewX is PinX - 1,
    append(Moves, [[PinX, PinY]], NewMoves),
    if_then_else(checkEmptyPin(Piece, PinX, PinY),
                 getUnvailableMoves(Piece, NewMoves, Return, NewX, PinY),
                 getUnvailableMoves(Piece, Moves, Return, NewX, PinY)) , !.
    
checkEmptyPin(Piece, PinX, PinY) :-
    piece(Piece, Mat),
    index(Mat, PinX, PinY, '.'),
    board(T),
    index(T, PieceX, PieceY, Piece),
    Xdiff is PinX-3,
    Ydiff is PinY-3,
    PieceX+Xdiff > 0,
    PieceX+Xdiff < 7,
    PieceY+Ydiff > 0,
    PieceY+Ydiff < 7.
