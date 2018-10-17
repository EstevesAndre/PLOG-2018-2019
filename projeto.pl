% retract assert
% board(T), display_game(T, player1).

:- dynamic board/1.
:- dynamic piece/2.

board( [[p0, p9, p8, p7, p6],
       [e, e, e, e, e],
       [e, e, e, e, e],
       [e, e, e, e, e],
       [p1, p2, p3, p4, p5]]).

piece(p1, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 1, ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(p2, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 2, ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(p3, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 3, ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(p4, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 4, ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(p5, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 5, ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(p6, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 6, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(p7, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 7, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(p8, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 8, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(p9, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 9, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(p0, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 0, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(e, [ [., ., ., ., .],
           [., ., ., ., .],
           [., ., ., ., .],
           [., ., ., ., .],
           [., ., ., ., .] ]). 

display_horizontal:-        
        write('-------------------------------'), nl,
	write('|  a  |  b  |  c  |  d  |  e  |'), nl.

display_game([Head|Tail],player1) :-
	display_horizontal,
	display_board([Head|Tail], player1, 5).

display_board([], _, _) :-
        write('---------------------------------'), nl.

display_board([Head|Tail], _, X_val) :-
        write('---------------------------------'), nl,
        display_line(Head, Head, 5, X_val), nl,
        X_next is X_val - 1,
        display_board(Tail, _, X_next).

display_line([], _, 1, _) :- write('| |').  %ultimo | colocado por linha

display_line([Head|Tail], Original, N_line, X_val) :-
        write('|'),
        piece(Head, Piece_Rep),
        display_piece_line(N_line, Piece_Rep, 5),
        display_line(Tail, Original, N_line, X_val).

display_line([], Original, 3, X_val) :-
        write('|'),
        write(X_val),
        write('|'),
        nl,
        display_line(Original, Original, 2, X_val).

display_line([], Original, N_line, X_val) :-
        Next is N_line - 1,
        N_line > 0,
        N_line =\= 3,
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