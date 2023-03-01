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

%% Вариант 2.

%% 1. Реализуйте функцию list_heads(List), 
%% которая возвращает список первых элементов непустых списков, 
%% входящих в List и игнорирует любые другие элементы List.

%% list_heads([[1,2,3], {true,3}, [4,5], []]) => [1,4]

extract_first([El|_]) -> El.
list_heads([], ResLi) -> lab1:reverse(ResLi);
list_heads([List|Lists], ResLi) -> 
    if 
        List > [] -> list_heads(Lists, [extract_first(List)| ResLi]);
        true -> list_heads(Lists, ResLi)
    end.    

list_heads(List) -> list_heads(List, []).

%% 2. Не смотря на определение в модуле lists стандартной библиотеки, 
%% реализуйте функцию takewhile(Pred, List). 
%% Она возвращает такой начальный отрезок списка List, 
%% для всех элементов которого Pred возвращает true. 
%% В отличие от filter, она заканчивает работу, 
%% как только найдёт элемент, на котором Pred вернёт false.

%% takewhile(fun(X) -> X < 10 end, [1,3,9,11,6]) => [1,3,9]

takewhile(_, [], ResLi) -> lab1:reverse(ResLi);
takewhile(Fun, [El|List], ResLi) -> 
    case Fun(El) of
        true -> takewhile(Fun, List, [El|ResLi]);
        false -> takewhile(Fun, [], ResLi)
    end.

takewhile(Fun, List) -> takewhile(Fun, List, []).

%% 3. Реализуйте функцию iterate(F, N), 
%% которая возвращает функцию, 
%% применяющую F к своему аргументу N раз 
%% (т.е., например, (iterate(F, 2))(X) == F(F(X)))

%% F1 = iterate(fun(X) -> {X} end, 2), F1(1) => {{1}}

iterate(F, 1) -> fun(X) -> F(X) end;
iterate(F, N) -> 
    fun(X) ->
        Foo = iterate(F, N-1), 
        F(Foo(X)) end.

%% Вариант 3.

%% 1. Реализуйте функцию list_lengths(List), которая возвращает список длин списков,
%% входящих в List и пропускает все остальные элементы.

%% list_lengths([[1,2,3], {true,3}, [4,5], []]) => [3,2,0]

list_lengths([], ResLi) -> lab1:reverse(ResLi);
list_lengths([Li|List], ResLi) when Li >= [] -> list_lengths(List, [lab1:len(Li)|ResLi]);
list_lengths([_|List], ResLi) -> list_lengths(List, ResLi).

list_lengths(List) -> list_lengths(List, []).

%% 2. Не смотря на определение в модуле lists стандартной библиотеки, реализуйте функцию all(Pred, List).
%% Она возвращает true, 
%% если Pred возвращает true для всех элементов List, 
%% и false, если это не так.

%% all(fun(X) -> X < 10 end, [1,3,9,11,6]) => false
%% all(fun(X) -> X < 10 end, [1,3,9,6]) => true

all(_, []) -> true;
all(Pred, [El|List]) ->
    case Pred(El) of
        true -> all(Pred, List);
        false -> false
    end.

%% 3. Реализуйте функцию min_value(F, N), 
%% которая возвращает минимальное значение
%% функции F на целых числах от 1 до N.

%% max_value(fun(X) -> X rem 5 end, 10) => 0

min_value(_, M, N, [El|ResLi]) when M > N -> lab1:find_minimum(ResLi, El);
min_value(F, M, N, ResLi) -> min_value(F, M + 1, N, [F(M)|ResLi]).

min_value(F, N) -> min_value(F, 1, N, []).

%% Вариант 4.

%% 1. Реализуйте функцию min_positive_number(List), 
%% которая возвращает минимальное положительное число, 
%% входящее в List. 
%% Если положительных чисел нет, 
%% функция должна вернуть атом error.

%% min_positive_number([3,a,false,-3,1]) => 1

min_positive_number([],[]) -> error;
min_positive_number([], [El|ResLi]) -> lab1:find_minimum(ResLi, El);
min_positive_number([El|Li], ResLi) -> 
    case is_integer(El) of
        true -> 
            case El > 0 of
                true -> min_positive_number(Li, [El|ResLi]);
                false -> min_positive_number(Li, ResLi)
            end;
        false -> min_positive_number(Li, ResLi)
    end.

min_positive_number(List) -> min_positive_number(List, []).

%% Дополнительные задания

%% 1. Реализуйте функцию for(Init, Cond, Step, Body), которая работает как цикл for (I = Init; Cond(I); I = Step(I)) { Body(I) } в C-подобных языках: 

%% # поддерживается "текущее значение" I. В начале это Init.
%% # на каждом шаге проверяется, выполняется ли условие Cond(I).
%%  # если да, то вызывается функция Body(I). Потом вычисляется новое значение как Step(I) и возвращаемся к проверке Cond.
%%  # если нет, то работа функции заканчивается.

for(I, Cond, Step, Body) ->
    case Cond(I) of
        true ->
            Body(I), 
            for(Step(I), Cond, Step, Body);
        false -> ok
    end.

%% 2. Реализуйте функцию sortBy(Comparator, List), 
%% которая сортирует список List, 
%% используя Comparator для сравнения элементов. 
%% Comparator(X, Y) 
%% возвращает один из атомов less (если X < Y), equal (X == Y), greater (X > Y) для любых элементов List. 
%% Можете использовать любой алгоритм сортировки, 
%% но укажите, какой именно. Сортировка слиянием очень хорошо подходит для связных списков.