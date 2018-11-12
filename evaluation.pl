/* Gets the best move in the position, evaluationg using the determined depth */

chooseBestMove(_, [], MoveRet, MoveRet, EvalRet, EvalRet, _, _).

chooseBestMove(Board, [M|Moves], BestMove, MoveRet, BestMoveEval, EvalRet, Pieces, 1) :-
    makeEvalMove(Board, NewBoard, M),
    value(NewBoard, Pieces, Eval),
    if_then_else(Eval > BestMoveEval,
                chooseBestMove(Board, Moves, M, MoveRet, Eval, EvalRet, Pieces, 1),
                chooseBestMove(Board, Moves, BestMove, MoveRet, BestMoveEval, EvalRet, Pieces, 1)).

chooseBestMove(Board, [M|Moves], BestMove, MoveRet, BestMoveEval, EvalRet, Pieces, Depth) :-
    Depth \= 1, 
    opPieces(Pieces, OpPieces),
    NewDepth is Depth - 1,
    makeEvalMove(Board, NewBoard, M),
    valid_moves(NewBoard, OpPieces, [], OpMoves),
    chooseBestMove(NewBoard, OpMoves, _, BestOpMove, -1000, _, OpPieces, NewDepth),
    makeEvalMove(NewBoard, DepthBoard, BestOpMove),
    valid_moves(DepthBoard, Pieces, [], DepthMoves),
    chooseBestMove(DepthBoard, DepthMoves, _, _, -1000, Eval, Pieces, NewDepth),
    if_then_else(Eval > BestMoveEval,
                chooseBestMove(Board, Moves, M, MoveRet, Eval, EvalRet, Pieces, Depth),
                chooseBestMove(Board, Moves, BestMove, MoveRet, BestMoveEval, EvalRet, Pieces, Depth)).

/* Makes an evaluation move on a depth board */
makeEvalMove(Board, NewBoard, [Piece, TrgRow, TrgCol]) :-
    index(Board, Row, Col, Piece),
    setElemMatrix(Row, Col, 'e', Board, AuxBoard),
    setElemMatrix(TrgRow, TrgCol, Piece, AuxBoard, NewBoard).

/* Makes all valid moves for all pieces under evaluation */
valid_moves(_, [], Moves, Moves).
valid_moves(Board, [P|Pieces], Moves, Return) :-  
    if_then_else(has_element_matrix(P, Board),
                getAvailableEvalMoves(Board, P, [], PieceMoves, 5, 5),
                black(PieceMoves)),
    append(Moves, PieceMoves, NextMoves),
    valid_moves(Board, Pieces, NextMoves, Return).

black([]).

getAvailableEvalMoves(_, _, Return, Return, 0, 1).
getAvailableEvalMoves(Board, Piece, Moves, Return, 0, PinY) :-
    NewY is PinY - 1,
    getAvailableEvalMoves(Board, Piece, Moves, Return, 5, NewY).
getAvailableEvalMoves(Board, Piece, Moves, Return, PinX, PinY) :-
    NewX is PinX - 1,
    index(Board, PieceX, PieceY, Piece),
    Xdiff is PinX-3,
    Ydiff is 3-PinY,
    Xpos is PieceX+Xdiff,
    Ypos is PieceY-Ydiff,
    append(Moves, [[Piece, Xpos, Ypos]], NewMoves),
    if_then_else(checkPinEval(Board, Piece, PinX, PinY),
                 getAvailableEvalMoves(Board, Piece, NewMoves, Return, NewX, PinY),
                 getAvailableEvalMoves(Board, Piece, Moves, Return, NewX, PinY)) , !.

checkPinEval(Board, Piece, PinX, PinY) :-
    piece(Piece, Mat),
    index(Mat, PinX, PinY, 'o'),
    index(Board, PieceX, PieceY, Piece),
    Xdiff is PinX-3,
    Ydiff is PinY-3,
    PieceX+Xdiff > 0,
    PieceX+Xdiff < 7,
    PieceY+Ydiff > 0,
    PieceY+Ydiff < 7.

checkPinEval(Board, Piece, PinX, PinY) :-
    piece(Piece, Mat),
    index(Mat, PinX, PinY, 'x'),
    index(Board, PieceX, PieceY, Piece),
    Xdiff is PinX-3,
    Ydiff is PinY-3,
    PieceX+Xdiff > 0,
    PieceX+Xdiff < 7,
    PieceY+Ydiff > 0,
    PieceY+Ydiff < 7.

/* Evaluates the position from the POV of the player with Pieces */
value(Board, Pieces, Eval) :-
    opPieces(Pieces, OpPieces),
    calculatePieceVal(Board, Pieces, OpPieces, 0, Val1),
    calculatePinVal(Board, Pieces, OpPieces, 0, Val2),
    calculateTotalMovesVal(Board, Pieces, OpPieces, Val3),
    calculatePieceCaptureVal(Board, Pieces, OpPieces, Val4),
    Eval is Val1 + Val2 + Val3 + Val4.

/* Calculates value of the position using number of pieces
    - +10 for every piece player has on the board
    - -10 for every piece opponent has on the board */

calculatePieceVal(_, [], [], Val, Val).

calculatePieceVal(Board, [], [P|OpPieces], Val, Return) :-
    NextVal is Val - 10,
    if_then_else(has_element_matrix(P, Board),
                calculatePieceVal(Board, [], OpPieces, NextVal, Return),
                calculatePieceVal(Board, [], OpPieces, Val, Return)).

calculatePieceVal(Board, [P|Pieces], OpPieces, Val, Return) :-
    NextVal is Val + 10,
    if_then_else(has_element_matrix(P, Board),
                calculatePieceVal(Board, Pieces, OpPieces, NextVal, Return),
                calculatePieceVal(Board, Pieces, OpPieces, Val, Return)).

/* Calculates value of the position using number of pins
    - +1 for every pin on a piece player has on the board
    - -1 for every pin on a piece opponent has on the board */

calculatePinVal(_, [], [], Val, Val).

calculatePinVal(Board, [], [P|OpPieces], Val, Return) :-
    piece(P, Mat),
    countElemMatrix(Mat, 'o', 0, Cnt1),
    countElemMatrix(Mat, 'x', 0, Cnt2),
    TotalCnt is Cnt1 + Cnt2,
    NextVal is Val - TotalCnt,
    if_then_else(has_element_matrix(P, Board),
                calculatePinVal(Board, [], OpPieces, NextVal, Return),
                calculatePinVal(Board, [], OpPieces, Val, Return)).

calculatePinVal(Board, [P|Pieces], OpPieces, Val, Return) :-
    piece(P, Mat),
    countElemMatrix(Mat, 'o', 0, Cnt1),
    countElemMatrix(Mat, 'x', 0, Cnt2),
    TotalCnt is Cnt1 + Cnt2,
    NextVal is Val + TotalCnt,
    if_then_else(has_element_matrix(P, Board),
                calculatePinVal(Board, Pieces, OpPieces, NextVal, Return),
                calculatePinVal(Board, Pieces, OpPieces, Val, Return)).

/* Calculates value of the position using number of moves available
    - +1 for every move player has available
    - -1 for every move opponent has available */

calculateTotalMovesVal(Board, Pieces, OpPieces, Val) :-
    valid_moves(Board, Pieces, [], PlayerMoves),
    length(PlayerMoves, Val1),
    valid_moves(Board, OpPieces, [], OppMoves),
    length(OppMoves, Val2),
    Val is Val1 - Val2.
/* Calculates value of the position using number of pieces available for capture
    - +3 for every move player has available
    - -8 for every move opponent has available */

calculatePieceCaptureVal(Board, Pieces, OpPieces, Val) :-
    valid_moves(Board, Pieces, [], PlayerMoves),
    valid_moves(Board, OpPieces, [], OpMoves),
    moves_into_op_piece(Board, PlayerMoves, OpPieces, 0, Val1),
    moves_into_op_piece(Board, OpMoves, Pieces, 0, Val2),
    Val is (3 * Val1) - (8 * Val2).

moves_into_op_piece(_, [], _, Val, Val).
moves_into_op_piece(Board, [[_, TrgRow, TrgCol]|Moves], OpPieces, Val, Return) :-
       NextVal is Val + 1,
       index(Board, TrgRow, TrgCol, Elem),
       if_then_else(has_element(Elem, OpPieces),
                    moves_into_op_piece(Board, Moves, OpPieces, NextVal, Return),
                    moves_into_op_piece(Board, Moves, OpPieces, Val, Return)).