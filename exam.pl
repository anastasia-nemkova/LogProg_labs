solve_rebus :-
    member(T, [1,2,3,4,5,6,7,8,9]), 
    member(R, [0,1,2,3,4,5,6,7,8,9]), R \= T,
    member(I, [0,1,2,3,4,5,6,7,8,9]), I \= T, I \= R,
    member(D, [1,2,3,4,5,6,7,8,9]), D \= T, D \= R, D \= I,
    member(V, [0,1,2,3,4,5,6,7,8,9]), V \= T, V \= R, V \= I, V \= D,
    member(A, [0,1,2,3,4,5,6,7,8,9]), A \= T, A \= R, A \= I, A \= D, A \= V,
    member(Y, [1,2,3,4,5,6,7,8,9]), Y \= A, Y \= T, Y \= R, Y \= I, Y \= D, Y \= V,

    TRI is T * 100 + R * 10 + I,
    DVA is D * 100 + V * 10 + A,
    YRD is Y * 100 + R * 10 + D,
    TRI - DVA =:= YRD,

    write('T = '), write(T), nl,
    write('R = '), write(R), nl,
    write('I = '), write(I), nl,
    write('D = '), write(D), nl,
    write('V = '), write(V), nl,
    write('A = '), write(A), nl,
    write('Y = '), write(Y), nl.
