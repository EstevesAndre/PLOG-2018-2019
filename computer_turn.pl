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

%TODO
p1computer.
p2computer.