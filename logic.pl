/* Checks the game state at P1 move */
checkGameState('P1', actualBoard).

/* Checks the game state at P2 move */
checkGameState('P2', actualBoard).

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
    write('asdsd'),
    p1Turn(Board, NewBoard, Player1),
    (
        write('x'),
        (checkGameState('P1', NewBoard), write('\nNice Move!\n'));
        display_board(T,Player1),
        (p2Turn(NewBoard,NewNewBoard,Player2), 
            (
                (checkGameState('P2', NewNewBoard), write('\nNice Move!\n'));
                display_board(T,Player2),
                (gameLoop(NewNewBoard, Player1, Player2))    
            )
        )
    ).
    
startGame(Player1, Player2) :-
    initialBoard(T),
    display_board(T,Player1),
    gameloop(T,Player1, Player2).
