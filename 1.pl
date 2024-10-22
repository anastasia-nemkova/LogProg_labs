% Немкова Анастасия М8О-208Б-22 (группа 3)
% Задача № 1
% Вариант № 0


% Генерируем матрицу 3 на 3, состоящую из чисел 1, 2 и 3
generate_matrix(Matrix) :-
    % Представим матрицу 3 на 3 с использованием трех списков длиной 3
    Matrix = [[A1, A2, A3],
            [B1, B2, B3],
            [C1, C2, C3]],
    % Определяем каждое из чисел матрицы как число 1, 2 или 3
    member(A1, [1, 2, 3]),
    member(A2, [1, 2, 3]),
    member(A3, [1, 2, 3]),
    member(B1, [1, 2, 3]),
    member(B2, [1, 2, 3]),
    member(B3, [1, 2, 3]),
    member(C1, [1, 2, 3]),
    member(C2, [1, 2, 3]),
    member(C3, [1, 2, 3]).

% Проверяем матрицу на валидность правилу для этого складываем элементы отдельно в каждой строке, столбце и диагонали
% и проверяем равенство каждого из них 6
check_matrix(Matrix) :-
    Matrix = [[A1, A2, A3],
            [B1, B2, B3],
            [C1, C2, C3]],

    Row1 is A1 + A2 + A3,
    Row2 is B1 + B2 + B3,
    Row3 is C1 + C2 + C3,

    Col1 is A1 + B1 + C1,
    Col2 is A2 + B2 + C2,
    Col3 is A3 + B3 + C3,

    Diag1 is A1 + B2 + C3,
    Diag2 is C1 + B2 + A3,

    Row1 =:= 6,
    Row2 =:= 6,
    Row3 =:= 6,
    Col1 =:= 6,
    Col2 =:= 6,
    Col3 =:= 6,
    Diag1 =:= 6,
    Diag2 =:= 6.

% Проводим поиск всевозможных решений, удовлетворяющих правилу
all_solution :-
    findall(Matrix, (generate_matrix(Matrix), check_matrix(Matrix)), Matrixs),
    print_matrix(Matrixs).

matrix_row([A1, A2, A3]) :-
    write([A1, A2, A3]), nl.

% Печатаем отдельно каждую матрицу в виде списка из трех списков  
print_matrix([]).
print_matrix([Matrix|Rest]) :-
    matrix_row(Matrix), nl,
    print_matrix(Rest).
