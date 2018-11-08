play :- 
    prompt(_, ''),
    restartData,
    printMainMenu,
    write('--> Insert your option: '),
    read(Input),
    parseInput(Input),
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
    !, startGame('Player 1', 'Player 2').

parseInput(2) :-
    !, startGame('Player', 'Computer').

parseInput(3) :-
    !, startGame('Computer 1', 'Computer 2').

parseInput(0) :-
    !, write('Exiting...\n'), fail.

parseInput(_Other) :-
    write('\nERROR: invalid option, choose one of the options.\n'),    
    write('--> Insert your option:'),
    read(Input),
    parseInput(Input).