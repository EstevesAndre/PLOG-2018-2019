:- use_module(library(random)).

/* Gets computer move info if is the first player */
p1computer(Depth) :-
    random_permutation([pA, pB, pC, pD, pE, pF], Pieces), 
    board(T),
    valid_moves(T, Pieces, [], Moves),
    chooseBestMove(T, Moves, _, BestMove, -1000, _, Pieces, Depth),
    makeAIMove(BestMove).

/* Gets computer move info if is the sencond player */
p2computer(Depth) :-
    random_permutation([p1, p2, p3, p4, p5, p6], Pieces), 
    board(T),
    valid_moves(T, Pieces, [], Moves),
    chooseBestMove(T, Moves, _, BestMove, -1000, _, Pieces, Depth),
    makeAIMove(BestMove).

makeAIMove([Piece, TrgRow, TrgCol]) :-
    board(T),
    index(T, Row, Col, Piece),
    move(Piece, Row, Col, TrgRow, TrgCol).