% retract assert
% board(T), display_game(T, player1).

display_horizontal:-        
        write('|-------------------------------------|'), nl,
	write('|  1  |  2  |  3  |  4  |  5  |  6  | |'), nl.

display_head(Name) :-
        write('---------------------------------------'), nl,
        write('|               '),
        write(Name),
        nl.

display_board([Head|Tail],Player1) :-
        display_head(Player1),
	display_horizontal,
	display_board_aux([Head|Tail], Player1, 6).

display_board_aux([], _, _) :-
        write('---------------------------------------'), nl.

display_board_aux([Head|Tail], _, X_val) :-
        write('---------------------------------------'), nl,
        display_line(Head, Head, 5, X_val), nl,
        X_next is X_val - 1,
        display_board_aux(Tail, _, X_next).

display_line([], _, 1, _) :- write('| |').  %ultimo | colocado por linha

display_line([Head|Tail], Original, N_line, X_val) :-
        N_line \= 0,
        write('|'),
        piece(Head, Piece_Rep),
        display_piece_line(N_line, Piece_Rep, 5),
        display_line(Tail, Original, N_line, X_val).

display_line([], Original, 3, X_val) :-
        write('|'),
        PrintVal is 7 - X_val,
        write(PrintVal),
        write('|'),
        nl,
        display_line(Original, Original, 2, X_val).

display_line([], Original, N_line, X_val) :-
        N_line \= 3,
        N_line \= 1,
        Next is N_line - 1,
        N_line > 0,
        write('| |'),
        nl,
        display_line(Original, Original, Next, X_val).

display_piece_line(N_line, [_|Tail], Current_line) :-
        Next is Current_line - 1,
        Current_line > N_line,
        display_piece_line(N_line, Tail, Next).

display_piece_line(N_line, [Head|_], N_line) :-
       display_piece_element(Head).           
 
display_piece_element([]).
      
display_piece_element([Head|Tail]) :-
       write(Head),
       display_piece_element(Tail).
