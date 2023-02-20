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