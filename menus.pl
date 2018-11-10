play :- 
    prompt(_, ''),
    restartData,
    printMainMenu,
    write('--> Insert your option: '),
    read(Input),
    \+parseInput(Input),
    play.

printMainMenu :-
    write('___________________________________________________________________'),nl,
    write('|                                                                 |'),nl,
    write('|                                                                 |'),nl,
    write('|         __ ___  __   __         __  _____  ___  _____  __       |'),nl,
    write('|        |    |  |    |   |\\   | |      |   |   |   |   |         |'),nl,
    write('|        |_   |  | __ |_  | \\  | |__    |   |___|   |   |_        |'),nl,
    write('|        |    |  |  | |   |  \\ |    |   |   |   |   |   |         |'),nl,
    write('|        |__ _|_ |__| |__ |   \\| ___|   |   |   |   |   |__       |'),nl,
    write('|                                                                 |'),nl,
    write('|                                                                 |'),nl,
    write('|                   ___________________________                   |'),nl,
    write('|                   |                         |                   |'),nl,
    write('|                   |   1. Player vs Player   |                   |'),nl,
    write('|                   |_________________________|                   |'),nl,
    write('|                   |                         |                   |'),nl,
    write('|                   |  2. Player vs Computer  |                   |'),nl,
    write('|                   |_________________________|                   |'),nl,
    write('|                   |                         |                   |'),nl,
    write('|                   | 3. Computer vs Computer |                   |'),nl,
    write('|                   |_________________________|                   |'),nl,
    write('|                   |                         |                   |'),nl,
    write('|                   |         0. Exit         |                   |'),nl,
    write('|                   |_________________________|                   |'),nl,
    write('|                                                                 |'),nl,
    write('|                                                                 |'),nl,
    write('|        Developers:                                              |'),nl,
    write('|                                                                 |'),nl,
    write('|        Andre Esteves ------------------------- Luis Silva       |'),nl,
    write('|_________________________________________________________________|'),nl.

parseInput(1) :-    
    !, startGame('Player 1', 'Player 2', _).

parseInput(2) :-
    !, printDifficulty,
    read(Difficulty),
    parseDifficulty(Difficulty, 2),
    startGame('Player', 'Computer', Difficulty).

parseInput(3) :-
    !, printDifficulty,
    read(Difficulty),
    parseDifficulty(Difficulty, 3),
    startGame('Computer 1', 'Computer 2', Difficulty).

parseInput(0) :-
    !, write('Exiting...\n').

parseInput(_Other) :-
    write('\nERROR: invalid option, choose one of the options.\n'),    
    write('--> Insert your option: '),
    read(Input),
    parseInput(Input).

printDifficulty :-
    write('_____________________________________'),nl,
    write('|                                   |'),nl,
    write('|        Select Difficulty:         |'),nl,
    write('|                                   |'),nl,
    write('|           (1) Easy                |'),nl,
    write('|           (2) Medium              |'),nl,
    write('|           (3) Hard                |'),nl,
    write('|                                   |'),nl,
    write('_____________________________________'),nl,
    write('--> Insert your option: ').

parseDifficulty(1, 2) :-    
    !, startGame('Player', 'Computer', 1).

parseDifficulty(1, 3) :-    
    !, startGame('Computer 1', 'Computer 2', 1).

parseDifficulty(2, 2) :-    
    !, startGame('Player', 'Computer', 2).

parseDifficulty(2, 3) :-    
    !, startGame('Computer 1', 'Computer 2', 2).

parseDifficulty(3, 2) :-    
    !, startGame('Player', 'Computer', 3).

parseDifficulty(3, 3) :-    
    !, startGame('Computer 1', 'Computer 2', 3).

parseDifficulty(_Other, Op) :-
    write('\nERROR: invalid option, choose one of the options.\n'),    
    write('--> Insert your option: '),
    read(Difficulty),
    parseDifficulty(Difficulty, Op).