-module(lab1).
-compile(export_all).

%% Вариант 1

%% Задание 1.
ball_volume(R) -> R * R * R * 4 / 3 * math:pi().

%% Задание 2.
from_t(N, M, L) when M == N -> [ M | L ];
from_t(N, M, L) when M > N ->
    from_t(N, M - 1, [ M | L ]);
from_t(N, M, L) when M < N ->
    exit({youPullBullshit, N, M}).
from_to(N, M) -> 
    from_t(N, M, []).

%% Задание 3.
delta([P | L], L1) when L == [] -> L1;
delta([P | L], L1) when L1 == [] -> 
    delta([ P | L ], [P | L1]);
delta([ FirstElem | [ SecondElem | SourceList ] ], ResultList) -> 
    delta([ SecondElem | SourceList ], ResultList ++ [SecondElem - FirstElem]).

%% Задание 4.
list_to_str(Lst, Str) when Lst == [] ->
    Str;

list_to_str([Fst | Lst], Str) when [Fst | Lst] /= [] ->
    if
        Fst == 1 ->
            list_to_str(Lst, Str ++ "1");
        true ->
            list_to_str(Lst, Str ++ "0")
    end.

int_to_binary(Num, Lst) when Num == 0, Lst /= [] -> list_to_str(Lst, "");
int_to_binary(Num, Lst) when Num == 0, Lst == [] -> list_to_str([0], "");
int_to_binary(Num, Lst) when Num < 0 -> "-" ++ list_to_str(int_to_binary(-1 * Num, Lst), "");
int_to_binary(Num, Lst) when Num /= 0 ->
    int_to_binary(Num div 2, [Num rem 2 | Lst]).

%% Задание 5.



%% Вариант 2

%% Задание 1.
seconds(H, M, S) when (H > 24) or (M > 59) or (S > 59) -> {incorrectInput};
seconds(H, M, S) -> H * 3600 + M * 60 + S.

%% Задание 2.
find_minimum([H | L], T) when L == [] ->
    if
        T > H ->
            H;
        true ->
            T
        end;
find_minimum([H | L], T) when L /= [] ->
    if
        T > H ->
            find_minimum(L, H);
        true ->
            find_minimum(L, T)
        end.

%% Задание 3.
dist(_,[],[]) -> true;
dist(Num, [F | Li], TmpLi) when Li == [] ->
    if
        Num == F -> false;
        true -> dist(F, TmpLi, []) 
    end;
dist(F, [S | Li], TmpLi) ->
    if
        F == S ->
            false;
        true ->
            dist(F, Li, [S | TmpLi])
        end.


distinct([F | [S | Li]]) ->
    if
        F == S ->
            false;
        true ->
            dist(F, Li, [])
        end.

%% Задание 4.
length([], N) -> N;
length([_ | Li], N) -> length(Li, (N + 1)).

len(Li) -> length(Li, 0).

split(_,_,_,N) when N == 0 -> {neNadoTak};
split([], TmpLi, ResLi, _) ->
        [TmpLi | ResLi];
split([F | Li], TmpLi, ResLi, N) ->
    case len(TmpLi) of
        M when M == N -> split([F | Li], [], [TmpLi | ResLi], N);
        _ -> split(Li, [F | TmpLi], ResLi, N)
    end.

split_all(List, N) -> 
    split(List, [], [], N).

%% Вариант 3.

reverse(L) -> reverse(L,[]).

reverse([],R) -> R;
reverse([H|T],R) -> reverse(T,[H|R]).

%% Задание 1.

distance({X1, Y1}, {X2, Y2}) -> 
    math:sqrt((X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2)).


%% Задание 2.
insert([F| List], X, Tail) when F > X -> insert(List, X, [Tail|F]);
insert([F| List], X, Tail) when X =< F -> [Tail | [X | [F | List]]].
        