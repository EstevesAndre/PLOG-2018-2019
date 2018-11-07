if_then_else(Condition, Action1, _) :- Condition, !, Action1.  
if_then_else(_, _, Action2) :- Action2.

/* Checks for game over conditions. If fail, game is over */

game_over(Player1, Player2) :-
    winnerP1(Player1),
    winnerP2(Player2).

winnerP1(_) :-
    checkPlayerPieces([p1, p2, p3, p4, p5, p6], 0),
    checkP1Pins, !.

winnerP1(Player1) :-
    write(Player1),
    write(' wins!'),
    fail.

winnerP2(_) :-
    checkPlayerPieces([pA, pB, pC, pD, pE, pF], 0),
    checkP2Pins, !.

winnerP2(Player2) :-
    write(Player2),
    write(' wins!'),
    fali.

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

has_element_matrix(X, [A|_]) :-
    has_element(X,A).
has_element_matrix(X, [A|As]) :- 
    \+(has_element(X,A)),
    has_element_matrix(X, As).

has_element(X, [X|_]).
has_element(X, [_|Ys]) :-
    has_element(X, Ys).

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
    choseMovePiece([pA, pB, pC, pD, pE, pF]),
    chosePinPiece([pA, pB, pC, pD, pE, pF]),
    chosePinPiece([pA, pB, pC, pD, pE, pF]).

/* Gets player move info if is the sencond player */
p2player :-
    choseMovePiece([p1, p2, p3, p4, p5, p6]),
    chosePinPiece([p1, p2, p3, p4, p5, p6]),
    chosePinPiece([p1, p2, p3, p4, p5, p6]).

choseMovePiece(Pieces) :-
    write('Choose piece to move: (ex. pX)'),
    read(Piece), nl,
    \+(checkValidPiece(Piece, Pieces)).
    
/* Loop to receive valid piece */
checkValidPiece(Piece, Pieces) :-
    \+((has_element(Piece, Pieces),
         board(T),
         has_element_matrix(Piece, T))),
    write('Invalid Piece. Choose piece to move: (ex. pX)'),
    read(NewPiece), nl,
    checkValidPiece(NewPiece, Pieces).
    

p1computer.
p2computer.

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
                display_board(T, Player2),
                gameloop(Player1, Player2)    
            )
        )
    ).
    
startGame(Player1, Player2) :-
    board(T),
    display_board(T,Player1),
    gameloop(Player1, Player2).
