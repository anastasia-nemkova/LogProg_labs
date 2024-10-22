% Правила перемещения шаров
move(In,Out):-
	append(S,['_','w'|T],In),
	append(S,['w','_'|T],Out).
move(In,Out):-
	append(S,['b','_'|T],In),
	append(S,['_','b'|T],Out).
move(In,Out):-
	append(S,['_','b','w'|T],In),
	append(S,['w','b','_'|T],Out).
move(In,Out):-
	append(S,['b','w','_'|T],In),
	append(S,['_','w','b'|T],Out).

% Продление пути с предотвращением петель
prolong([X|T], [Y, X|T]) :-
    move(X, Y),
    not(member(Y, [X|T])).

my_integer(1).
my_integer(M) :- my_integer(N), M is N + 1.

% Поиск в глубину
dfs([X|T], X, [X|T]).
dfs(P, Y, R) :-
    prolong(P, P1), dfs(P1, Y, R).

dfs_search(In, Out) :-
    writeln('DFS'),
    get_time(Start),
    dfs([In], Out, Res),
    get_time(End),
    Time is End - Start,
    print(Res), nl,
    length(Res, Len),write('DFS-search length: '),writeln(Len),
    write('Time: '), writeln(Time), nl.

% Поиск в ширину
bfs([[X|T]|_], X, [X|T]).
bfs([P|QI], X, R) :-
    findall(Z, prolong(P, Z), T),
    append(QI, T, QO), !,
    bfs(QO, X, R).
bfs([_|T], Y, L) :- bfs(T, Y, L).

bfs_search(In, Out) :-
    writeln('BFS'),
    get_time(Start),
    bfs([[In]], Out, Res),
    get_time(End),
    Time is End - Start,
    print(Res), nl,
    length(Res, Len),write('BFS-search length: '),writeln(Len),
    write('Time: '), writeln(Time), nl.

% Поиск с итерационным заглублением
search_id(Start, Finish, Path) :-
    my_integer(Level), 
    search_id(Start, Finish, Path, Level).

search_id(Start, Finish, Path, DepthLimit) :-
    depth_id([Start], Finish, Path, DepthLimit).

% Отсечение путей, которые не соответствуют заданной глубине
depth_id([Finish|T], Finish, [Finish|T], 0).
depth_id(Path, Finish, R, N) :-
    N > 0,
    prolong(Path, NewPath),
    N1 is N - 1,
    depth_id(NewPath, Finish, R, N1).

iter_search(In, Out) :-
    writeln('Iterative'),
    get_time(Start),
    search_id(In, Out, Res),
    get_time(End),
    Time is End - Start,
    print(Res), nl,
    length(Res, Len),write('Iter-search length: '),writeln(Len),
    write('Time: '), writeln(Time), nl.

% Вывод списка решений
print([]).
print([H|T]) :-
    print(T),
    writeln(H).

solve :-
    In = ['b', 'b', 'b', 'b', '_', 'w', 'w', 'w'],
    Out = ['w', 'w', 'w', '_', 'b', 'b', 'b', 'b'],
    dfs_search(In, Out),
    bfs_search(In, Out),
    iter_search(In, Out).
