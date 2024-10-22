% Преобразование инфиксного выражения в префиксную форму
calculate(Expr) :- 
    reverse(Expr, Expr1),
    a_expr(Expr1, Val),
    write('Res = ['), write_expr(Val), writeln(']').

% Проверка, является ли элемент числом
a_number([NS], NS) :- number(NS).

% Обработка умножения и деления
a_term(T, V) :- a_number(T, V).
a_term(T, V) :- 
    append(X, ['*'|Y], T),
    a_number(X, Vx),
    a_term(Y, Vy),
    V = ['*', Vy , Vx].

a_term(T, V) :- 
    append(X, ['/'|Y], T),
    a_number(X, Vx),
    a_term(Y, Vy),
    V = ['/', Vy, Vx].

% Обработка сложения и вычитания
a_expr(T, V) :- a_term(T, V).
a_expr(T, V) :- 
    append(X, ['+'|Y], T),
    a_term(X, Vx),
    a_expr(Y, Vy),
    V = ['+', Vy, Vx].
a_expr(T, V) :- 
    append(X, ['-'|Y], T),
    a_term(X, Vx),
    a_expr(Y, Vy),
    V = ['-', Vy, Vx].

% Вывод префиксного выражения
write_expr(Num) :- 
    number(Num),
    write(Num).
write_expr([Operator, Left, Right]) :- 
    write(Operator),
    write(', '),
    write_expr(Left),
    write(', '),
    write_expr(Right).