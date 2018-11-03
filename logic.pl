/* Checks the game state at P1 move */
checkGameState('P1', ActualBoard).

/* Checks the game state at P1 move */
checkGameState('P1', ActualBoard).

/* Player 1 turn */
p1Turn(Board, NewBoard, 'Player').

/* Computer 1 turn */
p1Turn(Board, NewBoard, 'computer').

/* Player 2 turn */
p2Turn(Board, NewBoard, 'Player').

/* Computer 2 turn */
p2Turn(Board, NewBoard, 'computer').

/* Loop do jogo */
gameloop(Board, Player1, Player2) :-
    p1Turn(Board, NewBoard, Player1),
    (
        (checkGameState('P1', NewBoard), write('\nNice Move!\n'));
        (p2Turn(NewBoard,NewNewBoard,Player2), 
            (
                (checkGameState('P2', NewNewBoard), write('\nNice Move!\n'));
                (gameLoop(NewNewBoard, Player1, Player2))    
            )
        )
    ).
    

startGame(Player1, Player2) :-
    display_game(InitialBoard,Player1),
    playing(InitialBoard, Player1, Player2),
    gameloop(Player1,Player2).
