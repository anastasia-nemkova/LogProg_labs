% стандартные предикаты

% длина списка
% (список,длина)
list_length([], 0).
list_length([_|L], N) :- list_length(L, N1), N is N1 + 1.

% принадлежность списку
% (элемент, список)
is_member(X, [X|_]).
is_member(X, [_|N]) :- is_member(X, N).

% конкатенация списков
% (список1, список2, список1+2)
append_list([], L, L).
append_list([X|L1], L2, [X|L3]) :- append_list(L1, L2, L3).

% удаление элемента из списка
% (элемент, список, список без элемента)
%my_remove(_, [], []).
my_remove(X, [X|N], N).
my_remove(X, [Y|N], [Y|Z]) :- my_remove(X, N, Z).

% перестановки элементов в списке
% (список, перестановка)
my_permute([], []).
my_permute(L, [X|T]):- my_remove(X, L, Y), my_permute(Y, T).

% проверка подсписков списка
% (подсписок, список)
sublist(S, L) :- append_list(_, L1, L), append_list(S, _, L1).


% специальный предикат обработки списка
% замена N-ого элемента на указанный
% (индекс заменяемого элемента, исходный список, новое значение, измененный список)

% без использования стандартных предикатов
replace(_, [], _, []).
replace(0, [_|L], N, [N|L]).
replace(I, [H|L], N, [H|R]) :- I1 is I - 1 , replace(I1, L, N, R).

% с использованием стандартных предикатов
replace_1(I, L, N, R) :- list_length(Pref, I), append_list(Pref, [_|Suff], L), append_list(Pref, [N|Suff], R).


% предикат обработки числового списка
% разделение списка на два относительно первого элемента (по принципу "больше-меньше")
% (исходный список, список с элементами больше первого, список с элементами меньше первого)

% без использования стандартных предикатов
separator([], [], []).
separator([X|T], Ls, G) :- comp(T, X, G, Ls).

comp([], _, [], []).
comp([X|T], F, [X|G], Ls) :- F < X, comp(T, F, G, Ls).
comp([X|T], F, G, [X|Ls]) :- F > X, comp(T, F, G, Ls).
comp([X|T], F, G, Ls) :- F == X, comp(T, F, G, Ls).


% с использованием стандартных предикатов
separator_1([], [], []).
separator_1([_], [], []).
separator_1([X, Y|T], [Y|L], G) :-
    X > Y,
    my_remove(Y, [X, Y|T], NewXs),
    separator_1(NewXs, L, G).
separator_1([X, Y|T], L, [Y|G]) :-
    X < Y,
    my_remove(Y, [X, Y|T], NewXs),
    separator_1(NewXs, L, G).
separator_1([X, Y|T], L, G) :-
    X == Y,
    my_remove(Y, [X, Y|T], NewXs),
    separator_1(NewXs, L, G).


% совместное использование предикатов
% разделение списка на два и замена N-ого элемента в каждом из списков
% (список, индекс, новый элемент, измененй список)
mix(L, I, N, Rb, Rs) :- separator(L, G, Ls), replace(I, G, N, Rb), replace(I, Ls, N, Rs).
