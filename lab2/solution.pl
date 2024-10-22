% список богов
gods([truth, dipl, lie]).

% высказывания богов
speak(left, [_, truth, _]).
speak(center, [_, dipl, _]).
speak(right, [_, lie, _]).

% присваеваем Богу на заданной позиции определенную характеристику (правда, ложь, дипломатия)
choice(Position, V, [H1, H2, H3]) :-
    (Position = left, H1 = V);
    (Position = center, H2 = V);
    (Position = right, H3 = V).

% проверка на ревенство вторых элементов списка
compare_second([_, Y | _], [_, Y1 | _]) :- Y == Y1.

% предположим, что в центре Бог Правды
center_conditions_truth(truth, L, L1) :-
    choice(center, truth, L),
    choice(center, truth, L1),
    speak(center, Ans),
    (compare_second(Ans, L), 
        (choice(left, lie, L),
        choice(right, dipl, L),
        choice(left, dipl, L1),
        choice(right, lie, L1)
        )
    ),
    writeln(L1),
    writeln(L).

% предположим, что в центре Бог Дипломатии
center_conditions_dipl(dipl, L) :-
    choice(center, dipl, L),
    speak(center, Ans),
    (not(compare_second(Ans, [_, truth, _])), 
        (speak(T, L),
        choice(T, truth, L),
        choice(center, truth, Ost),
        speak(Li, Ost),
        choice(Li, lie, L)
        )
    ),
    writeln(L).

% предположим, что в центре Бог Лжи
center_conditions_lie(lie, L) :-
    choice(center, lie, L),
    speak(center, Ans),
    (not(compare_second(Ans, L)),
        (speak(T, L),
        choice(T, truth, L),
        choice(center, truth, Ost),
        speak(Li, Ost),
        choice(Li, dipl, L)
        )
    ),
    writeln(L).


task :-
    center_conditions_truth(truth, _, _);
    center_conditions_dipl(dipl, _);
    center_conditions_lie(lie, _).
