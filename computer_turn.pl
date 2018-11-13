:- use_module(library(random)).

/* Gets computer move info if is the first player */
p1computer(Depth) :-
    random_permutation([pA, pB, pC, pD, pE, pF], Pieces), 
    removeExtraPieces(Pieces, [], NewPieces),
    board(T),
    valid_moves(T, NewPieces, [], Moves),
    chooseBestMove(T, Moves, _, BestMove, -1000, _, NewPieces, Depth),
    moveAI(BestMove),
    pinAI(NewPieces),
    pinAI(NewPieces).

/* Gets computer move info if is the sencond player */
p2computer(Depth) :-
    random_permutation([p1, p2, p3, p4, p5, p6], Pieces), 
    removeExtraPieces(Pieces, [], NewPieces),
    board(T),
    valid_moves(T, NewPieces, [], Moves),
    chooseBestMove(T, Moves, _, BestMove, -1000, _, NewPieces, Depth),
    moveAI(BestMove),
    pinAI(NewPieces),
    pinAI(NewPieces).

/* Removes pieces that are no longer on the board */
removeExtraPieces([], Ret, Ret).
removeExtraPieces([P|Pieces], NewPieces, Ret) :-
    board(T),
    if_then_else(has_element_matrix(P, T),
                removeExtraPieces(Pieces, [P|NewPieces], Ret),
                removeExtraPieces(Pieces, NewPieces, Ret)).


/* Makes a computer piece move */
moveAI([Piece, TrgRow, TrgCol]) :-
    board(T),
    index(T, Row, Col, Piece),
    move(Piece, Row, Col, TrgRow, TrgCol).

/* Gets best pin for computer */
pinAI(Pieces) :-
    choosePinPiece(Pieces, _, Piece, 1000),
    chooseBestPin(Piece, Row, Col),
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
    getUnvailableMoves(Piece, [], UnMoves, 5, 5),
    getAvailableMoves(Piece, [], Moves, 5, 5),
    length(Moves, NMoves),
    testBestPin(Piece, UnMoves, NMoves, _, [Row|Col], 0).

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

testBestPin(_, _, _, Ret, Ret, 1).
testBestPin(Piece, [[Row|[Col|_]]|Pins], NMoves, Move, Ret, 0) :-
    pin(Piece, Row, Col),
    getAvailableMoves(Piece, [], Moves, 5, 5),
    unpin(Piece, Row, Col),
    length(Moves, N),
    if_then_else(N > NMoves,
                testBestPin(_, _, _, [Row|Col], Ret, 1),
                testBestPin(Piece, Pins, NMoves, Move, Ret, 0)).
