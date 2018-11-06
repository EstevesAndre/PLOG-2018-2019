if_then_else(Condition, Action1, _) :- Condition, !, Action1.  
if_then_else(_, _, Action2) :- Action2.

/* Checks for game over conditions. If fail, game is over */

game_over(Board, _) :-
    checkPlayerPieces(Board, [pA, pB, pC, pD, pE, pF], 0),
    checkPlayerPieces(Board, [p1, p2, p3, p4, p5, p6], 0),
    checkP1Pins,
    checkP2Pins.

checkPlayerPieces(_, [], Cnt) :- Cnt \= 1. 

checkPlayerPieces(Board, [P|Ps], Cnt) :-
    Inc is Cnt+1,
    if_then_else(has_element_matrix(P, Board), checkPlayerPieces(Board, Ps, Inc), checkPlayerPieces(Board, Ps, Cnt)).

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

has_element_matrix(X, [A|_]) :-
    has_element(X,A).
has_element_matrix(X, [A|As]) :- 
    \+(has_element(X,A)),
    has_element_matrix(X, As).

has_element(X, [X|_]).
has_element(X, [_|Ys]) :-
    has_element(X, Ys).

/* Player 1 turn */
p1Turn(Board, NewBoard, 'Player') :-
    nl, write('--------------- PLAYER1 ---------------'), nl.   

/* Computer 1 turn */
p1Turn(Board, NewBoard, 'Computer') :-
    nl, write('-------------- COMPUTER1 --------------'), nl.

/* Player 2 turn */
p2Turn(Board, NewBoard, 'Player') :-
    nl, write('--------------- PLAYER2 ---------------'), nl.

/* Computer 2 turn */
p2Turn(Board, NewBoard, 'Computer') :-
    nl, write('-------------- COMPUTER2 --------------'), nl.

/* Loop do jogo */
gameloop(Board, Player1, Player2) :-
    p1Turn(Board, NewBoard, Player1),
    (
        game_over(Board, _),
        display_board(Board,Player1),
        (p2Turn(NewBoard,NewNewBoard,Player2), 
            (
                game_over(Board, _),
                display_board(Board,Player2),
                gameloop(Board, Player1, Player2)    
            )
        )
    ).
    
startGame(Player1, Player2) :-
    board(T),
    display_board(T,Player1),
    gameloop(T,Player1, Player2).
