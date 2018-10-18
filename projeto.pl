% retract assert
% board(T), display_game(T, player1).

:- dynamic board/1.
:- dynamic piece/2.

board( [[p1, p2, p3, p4, p5, p6],
       [e, e, e, e, e, e],
       [e, e, e, e, e, e],
       [e, e, e, e, e, e],
       [e, e, e, e, e, e],
       [pA, pB, pC, pD, pE, pF]]).

piece(pA, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 'A', ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(pB, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 'B', ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(pC, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 'C', ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(pD, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 'D', ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(pE, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 'E', ., .],
	    [., ., ., ., .],
            [., ., ., ., .] ]).
piece(pF, [ [., ., ., ., .],
            [., ., o, ., .],
            [., ., 'F', ., .],
            [., ., ., ., .],
            [., ., ., ., .] ]).
piece(p1, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 1, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(p2, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 2, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(p3, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 3, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(p4, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 4, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
piece(p5, [ [., ., ., ., .],
            [., ., ., ., .],
            [., ., 5, ., .],
	    [., ., x, ., .],
            [., ., ., ., .] ]).
 piece(p6, [ [., ., ., ., .],
             [., ., ., ., .],
             [., ., 6, ., .],
	     [., ., x, ., .],
             [., ., ., ., .] ]).
piece(e, [ [., ., ., ., .],
           [., ., ., ., .],
           [., ., ., ., .],
           [., ., ., ., .],
           [., ., ., ., .] ]). 

display_horizontal:-        
        write('-------------------------------------'), nl,
	write('|  a  |  b  |  c  |  d  |  e  |  f  |'), nl.

display_game([Head|Tail],player1) :-
	display_horizontal,
	display_board([Head|Tail], player1, 6).

display_board([], _, _) :-
        write('---------------------------------------'), nl.

display_board([Head|Tail], _, X_val) :-
        write('---------------------------------------'), nl,
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