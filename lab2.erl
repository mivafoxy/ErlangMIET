-module(lab2).
-compile(export_all).

%% Вариант 1.

%% 1. Реализуйте функцию sum_neg_squares(List), которая возвращает сумму квадратов всех 
%% отрицательных чисел в списке List.

%% sum_pos_squares([-3,a,false,-3,1]) => 18

get_result([], Accum) -> Accum;
get_result([El|Li], Accum) -> get_result(Li, Accum + (El * El)).

get_result(Li) -> get_result(Li, 0).

sum_pos_squares([], ResLi) -> get_result(ResLi);
sum_pos_squares([El|Li], ResLi) ->
    if 
        El < 0 -> sum_pos_squares(Li, [El|ResLi]);
        true -> sum_pos_squares(Li, ResLi)
    end.

    

sum_pos_squares(Li) -> sum_pos_squares(Li, []).

%% 2. Не смотря на определение в модуле lists стандартной библиотеки, 
%% реализуйте функцию dropwhile(Pred, List). 
%% Она возвращает то, что остаётся от списка List 
%% после отбрасывания начальных элементов, на которых Pred возвращает true.

%% dropwhile(fun(X) -> X < 10 end, [1,3,9,11,6]) => [11, 6]

dropwhile(_, [], ResLi) -> ResLi;
dropwhile(Fun, [X|Li], ResLi) ->
    case Fun(X) of
        true -> dropwhile(Fun, Li, [X|ResLi]);
        false -> dropwhile(Fun, Li, ResLi)
    end.

dropwhile(Fun, Li) -> dropwhile(Fun, Li, []).

%% 3. Реализуйте функцию antimap(ListF, X), 
%% которая принимает список функций одного аргумента ListF и значение X, 
%% и возвращает список результатов применения всех функций из ListF к X.
%% antimap([fun(X) -> X + 2 end, fun(X) -> X*3 end], 4) => [6, 12]

antimap([],_,ResLi) -> ResLi;
antimap([Fun|Funs], X, ResLi) -> antimap(Funs, X, [Fun(X)|ResLi]).

antimap(Funs, X) -> antimap(Funs, X, []).

%% 4. Реализуйте функцию solve(Fun, A, B, Eps), 
%% которая находит приближённо (с ошибкой не больше Eps) 
%% корень уравнения Fun(X) = 0 на отрезке [A, B] или точку разрыва, 
%% в которой Fun меняет знак. 
%% Можно считать, что F(A) <= 0 <= F(B) 
%% (как известно, в таком случае  корень заведомо существует). 
%% Проще всего это сделать, деля отрезок пополам и смотря, 
%% на концах какой половины различаются знаки Fun.

%% solve(fun(X) -> X*X - 2 end, 0, 2, 0.001) => 1.414 (приближенно)

