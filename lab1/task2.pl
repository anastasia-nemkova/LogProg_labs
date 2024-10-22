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
