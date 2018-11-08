:- use_module(library(lists)).

if_then_else(Condition, Action1, _) :- Condition, !, Action1.  
if_then_else(_, _, Action2) :- Action2.

has_element_matrix(X, [A|_]) :-
    has_element(X,A).
has_element_matrix(X, [A|As]) :- 
    \+(has_element(X,A)),
    has_element_matrix(X, As).

has_element(X, [X|_]).
has_element(X, [_|Ys]) :-
    has_element(X, Ys).

index(Matrix, Row, Col, Value):-
  nth1(Row, Matrix, MatrixRow),
  nth1(Col, MatrixRow, Value).

setElemMatrix(1, 1, Val, [ [_ | Tail1] | Tail2], [ [Val | Tail1] | Tail2]).
setElemMatrix(1, Ncol, Val, [ [Elem | Tail1] | Tail2], [[Elem | Head] | Tail2]) :- 
	Next is Ncol-1,
	setElemMatrix(1, Next, Val, [ Tail1 | Tail2], [Head | Tail2]).
setElemMatrix(Nrow, Ncol, Val, [Elem | Tail1], [Elem | Out]) :- 
	Next is Nrow-1,
	setElemMatrix(Next, Ncol, Val, Tail1, Out).

countElem([],_,0).
countElem([X|T],X,Y):- !, countElem(T,X,Z), Y is 1+Z.
countElem([_|T],X,Z):- countElem(T,X,Z).

countElemMatrix([], _, Cnt, Cnt).
countElemMatrix([Row|M], Elem, Cnt, Return) :-
    countElem(Row, Elem, RowCnt),
    NewCnt is Cnt + RowCnt,
    countElemMatrix(M, Elem, NewCnt, Return).