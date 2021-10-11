/*
Christian Henry, Christopher Tullier
05/11/21
CSC 330-001
Spring '21
Project 2
*/

/* Main Function */
lex(Filename, R) :- see(Filename), get0(X), process(X, [], R), seen.
/* (Henry) Displays R in the correct order */
process(-1, T, R) :- myReverse(T, R).

/* (Tullier) Process function to append all read values into a list */
process(X, T, R) :- X\= -1, check(X, S), R2 = [S|T], get(X2), process(X2, R2, R).

/* (Tullier) Space */
process(32, T, R) :- get0(X), process(X, T, R).

/* (Tullier) Return */
process(10, T, R) :- get0(X), process(X, T, R).
/* (Tullier) Times */
check(42, ['*,TI']).
/* (Tullier) Plus */
check(43, ['+,PL']).
/* (Tullier) Minus */
check(45, ['-,MI']).
/* (Tullier) Divide */
check(47, ['/,DI']).
/* (Tullier) Equals */
check(61, ['=,EQ']).
/* (Henry) If number is in Text File, return error. */
check(X, _) :- X > 0, X < 9, write("Compilation Error"), nl, write('R = []'), nl, halt.

/* (Henry) Words */
check(X, [(W),'ID']) :- X > 64, X < 123, word(X, '', P), flipWord(P, W).

/* (Tullier) Function that concats letters into a string */
word(X, Temp, P) :- X > 64, X < 123, char_code(C, X), atom_concat(C, Temp, W2), atom_concat('.', W2, W3), get0(X2), word(X2, W3, P).
word(X, Temp, Temp) :- (X = 61; X = 43; X = 42; X = 45; X = 47; X = -1; X = 10; X = 32).

/* (Henry) Function that splits the word into a list, flips it, and puts it back together. */
flipWord(P, W) :- split_string(P, '.', '', O), myReverse(O, O2), atomics_to_string(O2, W).

/* (Henry) Reverse Function so the order is correct */
myReverse([A,B],[B,A]).
myReverse([H|T],L) :- myReverse(T,Z),myAppend(Z,[H],L).

/* (Henry) Append Function so the reverse function works */
myAppend([],L,L).
myAppend([X|XS],L,[X|T]) :- myAppend(XS,L,T).
