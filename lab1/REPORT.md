# Отчет по лабораторной работе №1
## Работа со списками и реляционным представлением данных
## по курсу "Логическое программирование"

### студент: Немкова А. Р.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение

Списки в Прологе представляют собой рекурсивную структуру, которая состоит из двух элементов: головы(первого элемента списка) и хвостовой части(оставшаяся часть списка). Список завершается пустым списком, который обозначает его конец.

Разница между списками в Прологе и подходами к хранению данных в императивных языках весьма существенная:
1) В Прологе используется рекурсивное определениеи списка, вместо определения элементов по индексам или указателям, что отличает их от императивных данных.
2) Для работы со списками в Пролге используются рекурсивные правила и факты. Это отличается от императивных языков, где для обработки данных обычно используются циклы или итераторы.
3) Элементы списков в Прологе могут быть разных типов - константы, переменные, структры(те же самые списки). В то время как во многих императивных языках списки могут содержать элементы только одного типа.
4) Списки в языке Пролог являются неизменяемыми структурами данных, то есть их содержимое невозможно поменять. Вместо этого при выполнении операций создается новый список.
5) В императивных языках необходимо явно определить структуру данных и операции для создания, изменения и их обработки. В Прологе же можно просто описать свойства или отношения, которвми обладает список.

Списки похожи на такие традиционные структуры данных, как массив, вектор, стек и, соответственно, связные списки, реализованные в императивных языках программирования.Однако списки в Прологе обладают своей уникальной семантикой и обработкой данных, которые отличаются от традиционных структур данных в императивных языках. 

## Задание 1.1: Предикат обработки списка

Стандартные предикаты для работы со списками:

```prolog
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
```

`replace` - замена N-ого элемента списка на указанный без стандартных предикатов.

`replace_1(I, L, N, R)` - замена N-ого элемента списка на указанный с использованием стандартных предикатов.

Примеры использования:
```prolog
% без использования стандартных предикатов
?- replace(2, [1, 2, 3, 4], 9, Res).
Res = [1, 2, 9, 4] .

?- replace(3, ['A', 8, -3, 'DRF'], 9, Res).
Res = ['A', 8, -3, 9] .

% с использованием стандартных предикатов
?- replace_1(1, ['LN', 4, -3, 0], 7, Res).
Res = ['LN', 7, -3, 0] .

?- replace_1(1, ['LN', -5, 3], 7, Res).
Res = ['LN', 7, 3] .
```

Реализация:
```prolog
% (индекс заменяемого элемента, исходный список, новое значение, измененный список)

% без использования стандартных предикатов
replace(_, [], _, []).
replace(0, [_|L], N, [N|L]).
replace(I, [H|L], N, [H|R]) :- I1 is I - 1 , replace(I1, L, N, R).

% с использованием стандартных предикатов
replace_1(I, L, N, R) :- list_length(Pref, I), append_list(Pref, [_|Suff], L), append_list(Pref, [N|Suff], R).
```
Предикат `replace` работает рекурсивно для замены элемента в списке. Если заданный индекс равен 0, он заменяет головной элемент списка требуемым значением и строит новый список с остальными элементами из исходного. Если индекс больше 0, то предикат записывает головной элемент исходного списка в результирующий список и уменьшает исходный индекс на 1, далее он рекурсивно вызывает себя для для хвостовой части списка. Процесс продолжается, пока не будет достигнут заданный индекс, и возвращается новый список с заменой элемента на этом индексе.

Предикат `replace_1` с помощью стандартного предиката `list_length` создает список `Pref`, который содержит первые элементы исходного списка до заданного индекса. Затем, с помощью стандартного предиката `append_list`, он разбивает исходный список на две части: `Pref` и `Suff`, где `Suff` содержит остальные элементы после заданного индекса. После этого, с помощью предиката `append_list`, добавляет требуемый элемент между `Pref` и `Suff`, создавая результирующий список, в котором требуемый элемент заменяет элемент, который находился на позиции с заданным индексом в исходном списке.

## Задание 1.2: Предикат обработки числового списка

`separator` - разделение списка на два относительно первого элемента (по принципу "больше-меньше") без использования стандартных предикатов.

`separator_1` - разделение списка на два относительно первого элемента (по принципу "больше-меньше") с использованием стандартных предикатов.

Примеры использования: 
```prolog
% без использования стандартных предикатов
?- separator([3, 2, 4, 6, 1, 2, 7], Less, Bigger).
Less = [2, 1, 2],
Bigger = [4, 6, 7] .

?- separator([6, 1, 9, 3, 3, 6, 4, 2, 8, 6, 5], Less, Bigger).
Less = [1, 3, 3, 4, 2, 5],
Bigger = [9, 8] .

% с использованием стандартных предикатов
?- separator_1([9, 4, 1, 5, 2, 8, 3, 5], Less, Bigger).
Less = [4, 1, 5, 2, 8, 3, 5],
Bigger = [] .

?- separator_1([6, 4, 6, 7, 9, 3, 4, 8, 8, 1, 2], Less, Bigger).
Less = [4, 3, 4, 1, 2],
Bigger = [7, 9, 8, 8] .
```

Реализация:
```prolog
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
```

Предикат `separator` отделяет головной элемент и отправляет хвост исходного списка в предикат `comp`, рекурсивно сравнивает этот головной с остальными элементами. Если он меньше элемента в списке, то этот элемент добавляется в результирующий список с большими значениями. Если головной элемент больше элемента в списке, то этот элемент добавляется в результирующий список с меньшими значениями. Если головной элемент равен элементу в списке, то этот элемент не добавляется ни в один из конечных списков. `comp` рекурсивно обрабатывает оставшиеся элементы в исходном списке, формируя два результирующих списка, которые разделяют исходный список на элементы меньше и больше первого элемента.

Предикат `separator_1` сравнивает первые два элемента (`X` и `Y`) исходного списка. Если `X` больше `Y`, то `Y` добавляется в список с меньшими элементами, а если `X` меньше `Y`, то `Y` добавляется в список с большими элементами. В случае, если `X` и `Y` равны, то `Y` не добавляется ни в один из результирующих списков. После этого, с помощью стандартного предиката `my_remove`, происходит удаление элемента  `Y` из начального списка, и процесс рекурсивно повторяется.

## Задание 1.3: Пример совместного использования предикатов

`mix` - разделение списка на два и замена N-ого элемента в каждом из списков.

Пример использования:
```prolog
?- mix([4, 6, 7, 1, 3, 8, 3, 4, 2, 1], 2, 0, Bigger, Less).
Bigger = [1, 3, 0, 2, 1],
Less = [6, 7, 0] .

?- mix([12, 1, 4, 13, 4, 7, 15, 11, 9, 2, 8, 5, 17], 1, 100, Bigger, Less).
Bigger = [1, 100, 4, 7, 11, 9, 2, 8, 5],
Less = [13, 100, 17] .
```

Реализация:
```prolog
% (список, индекс, новый элемент, измененй список)
mix(L, I, N, Rb, Rs) :- separator(L, G, Ls), replace(I, G, N, Rb), replace(I, Ls, N, Rs).
```

Предикат `mix` при помощи предиката `separator` производит разделения исходного списка относительно первого элемента по принципу больше/меньше на два списка, и затем при помощи предиката `replace` мы заменяем элемент под заданным индесом на требуемое значение в списке с элементами, больше первого в исходном списке, далее тоже самое проделываем со списком, в котором находятся элементы, меньшие первого в исходном списке.

## Задание 2: Реляционное представление данных

Исходный код:
```prolog
:-['two.pl'].

% вариант 2
% 1) Напечатать средний балл для каждого предмета

% сумма оценок
sum_mark([], 0).
sum_mark([H|T], S) :- sum_mark(T, S1), S is S1 + H.


% средний балл для предмета
average_mark(Subject, Mark) :- 
    findall(X, grade(_, _, Subject, X), Marks), 
    sum_mark(Marks, Sum), 
    length(Marks, Len), 
    Mark is Sum / Len.

% печать среднего балла по каждому предмету
print_average_mark :- 
    findall(Subject, grade(_, _, Subject, _), Sub), 
    list_average_mark(Sub, []).

list_average_mark([], _).
list_average_mark([Subject|Res], PrintSub) :- 
    \+ member(Subject, PrintSub),
    average_mark(Subject, Sum),
    write('Средний балл для '), write(Subject), write(': '), write(Sum), nl,
    list_average_mark(Res, [Subject|PrintSub]).
list_average_mark([_|Res], PrintSub) :- list_average_mark(Res, PrintSub).

% 2) Для каждой группы, найти количество не сдавших студентов

not_pass_gr(Group, Count) :-
    findall(Group, (grade(Group, _, _, Mark), Mark < 3), Groups), length(Groups, Count).

print_not_pass_gr :-
    findall(Group, grade(Group, _, _, _), Groups),
    list_not_pass_gr(Groups,[]).

list_not_pass_gr([], _).
list_not_pass_gr([Group|Res], PrintGr) :-
    \+ member(Group, PrintGr),
    not_pass_gr(Group, Count),
    write('Количество не сдавших студентов в группе '), write(Group), write(': '), write(Count), nl,
    list_not_pass_gr(Res, [Group|PrintGr]).
list_not_pass_gr([_|Res], PrintGr) :- list_not_pass_gr(Res, PrintGr).

% 3) Найти количество не сдавших студентов для каждого из предметов

not_pass_sub(Subject, Count) :-
    findall(Subject, (grade(_, _, Subject, Mark), Mark < 3), Subjects), length(Subjects, Count).

print_not_pass_sub :-
    findall(Subject, grade(_, _, Subject, _), Subjects),
    list_not_pass_sub(Subjects,[]).

list_not_pass_sub([], _).
list_not_pass_sub([Subject|Res], PrintSb) :-
    \+ member(Subject, PrintSb),
    not_pass_sub(Subject, Count),
    write('Количество не сдавших студентов по предмету '), write(Subject), write(': '), write(Count), nl,
    list_not_pass_sub(Res, [Subject|PrintSb]).
list_not_pass_sub([_|Res], PrintSb) :- list_not_pass_sub(Res, PrintSb).
```

Список реализованных предикатов:

* `sum_mark` - подсчет суммы оценок списка.
* `average_mark` - вычисление среднего балла для заданного предмета.
* `print_average_mark` - печать среднего балла для каждого предмета.
* `list_average_mark` - обход списка предметов и вывод среднего балла для каждого из них.
* `not_pass_gr` - вычисление количества студентов, не сдавших экзамен в заданной группе.
* `print_not_pass_gr` - печать количества несдавших студентов для каждой группы.
* `list_not_pass_gr` - обход списка групп и вывод количества несдавших студентов в каждой из них.
* `not_pass_sub` - вычисление количества студентов, не сдавших экзамен по заданному предмету.
* `print_not_pass_sub` - печать количество несдавших студентов для каждого предмета.
* `list_not_pass_sub` - обход списка предметов и вывод количества несдавших студентов по каждому из них.

Результат работы предикатов:
```prolog
?- print_average_mark.
Средний балл для Логическое программирование: 3.9642857142857144
Средний балл для Математический анализ: 3.892857142857143
Средний балл для Функциональное программирование: 3.9642857142857144
Средний балл для Информатика: 3.9285714285714284
Средний балл для Английский язык: 3.75
Средний балл для Психология: 3.9285714285714284
true .

?- print_not_pass_gr.
Количество не сдавших студентов в группе 102: 5
Количество не сдавших студентов в группе 101: 2
Количество не сдавших студентов в группе 104: 2
Количество не сдавших студентов в группе 103: 4
true .

?- print_not_pass_sub.
Количество не сдавших студентов по предмету Логическое программирование: 2
Количество не сдавших студентов по предмету Математический анализ: 3
Количество не сдавших студентов по предмету Функциональное программирование: 1
Количество не сдавших студентов по предмету Информатика: 2
Количество не сдавших студентов по предмету Английский язык: 4
Количество не сдавших студентов по предмету Психология: 1
true .
```
Реляционное представление данных имеет свои преимущества, такие как структурированность и четкая организация данных в таблицы, что упрощает их анализ. Это обеспечивает целостность данных и возможность применения сложных запросов для извлечения информации.  Однако реляционная модель может быть неэффективной для хранения и извлечения иерархических или связанных данных, а также может столкнуться с проблемами производительности при больших объемах данных.

Мое представление данных (`two.pl`) имеет ряд преимуществ таких, как легкость воприятия, данные организованны в виде фактов с четкой структурой, что позволяет легко читать и понимать данные; простой доступ, данные в таком формате позволяют легко производить запросы и производить их фильтрацию. Однако есть и недостатки: такое представление данных не является оптимальным для больших объемов информации; также в таком формате дублируется информация о группах, студентах и предметах, так как это описывается в каждом факте, что приводит к избыточности данных и усложняет их анализ.

Принцип реализации предикатов, осуществляющих запросы к данным:
 - Предикат `sum_mark` рекурсивно вызывает себя для хвоста списка оценок и суммирует текущую оценку в головном элементе списка с суммой хвоста.

 - Предикат `average_mark` использует `findall` для нахождения всех оценок для данного предмета. Затем он вызывает `sum_mark` для вычисления суммы оценок и `length` для получения количества оценок. Затем вычисляет средний балл как отношение суммы оценок к их количеству.

 - Предикат `print_average_mark` использует `findall`, чтобы получить список всех уникальных предметов, после чего вызывает `list_average_mark`, который рекурсивно перебирает список предметов. При помощи \+`member` он проверяет, что текущий предмет еще не был выведен. Если предмет не выведен, то он вызывает `average_mark` для вычисления среднего балла и выводит информацию о предмете и его среднем балле. Затем он рекурсивно вызывает себя для оставшихся предметов.

 - Предикат `not_pass_gr` использует `findall` для поиска всех студентов в данной группе, у которых оценка менее 3, и затем, при помощи стандартного предиката `length`, вычисляет длину списка найденных студентов.

 - Предикат `print_not_pass_gr` использует `findall`, чтобы получить список всех уникальных групп, а затем вызывает `list_not_pass_gr`, который рекурсивно перебирает список групп, проверяя, при помощи \+`member`, что текущая группа еще не была обработана. Если группа не была обработана, то он вызывает `not_pass_gr` для вычисления количества не сдавших студентов и выводит информацию о группе и количестве не сдавших студентов. Затем он рекурсивно вызывает себя для оставшихся групп.

 - Предикат `not_pass_sub` использует `findall` для поиска всех студентов, у которых оценка по данному предмету менее 3, и затем, при помощи стандартного предиката `length`, вычисляет длину списка найденных студентов.

 - Предикат `print_not_pass_sub` использует`findall`, чтобы получить список всех уникальных предметов, а затем вызывает `list_not_pass_sub`, который рекурсивно перебирает список предметов, проверяя, при помощи \+`member`, что текущий предмет еще не был обработан. Если предмет не был обработан, то он вызывает `not_pass_sub` для вычисления количества не сдавших студентов и выводит информацию о предмете и количестве не сдавших студентов. Затем он рекурсивно вызывает себя для оставшихся предметов.

## Выводы

В процессе выполнения лабораторной работы я познакомилась с основами логического программирования на языке Пролог. Я изучила стандартные предикаты, научилась реализовывать собственные простейшие предикаты для решения задач, изучила структуру данных "список", научилась работать с ней и применять для обработки данных в реляционном представлении. Эта лабораторная работа дала мне понимание декларативного программирования.

Основной принцип работы в Прологе, основанный на рекурсии, позволяет строить структуры данных в виде деревьев, что часто оказывается самым подхожящим для поиска решений в различных задачах. Это действительно заставляет задуматься о разнице между декларативным и императивным программированием. В декларативном подходе мы описываем, что нужно получить, вместо того, чтобы детально инструктировать, как это сделать. Это подходит для задач, где важно выразить суть проблемы и ожидаемый результат, не вдаваясь в детали реализации.
Однако, оба стиля программирования имеют свои преимущества и недостатки, и выбор между ними зависит от конкретной задачи. Императивные языки могут быть более простыми для изучения и понимания. С другой стороны, декларативный код может быть более чистым, понятным и предлагать более эффективные решения для определенных задач.

Таким образом, Пролог является представителем парадигмы логического программмирования, а эти знания будут очень полезны в дальнейшем.




