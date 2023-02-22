-module(lab1).
-compile(export_all).

%% Задание 7.
%% 7. Задайте функцию is_date(DayOfMonth, MonthOfYear, Year), определяющуе номер дня недели по числу месяца, номеру месяца и году. 
%% Напомню, что год является високосным, если он либо делится на 4, но не на 100, либо делится на 400.
%% В качестве точки отсчёта возьмите 1 января 2000 года (суббота). Не используйте каких-то формул для нахождения дня недели, это задание на рекурсию!
%% is_date(1, 1, 2000) => 6
%% is_date(1, 2, 2013) => 5

contains([],_) -> false;
contains([El|Li], X) ->
    if
        El == X -> true;
        true -> contains(Li, X)
    end.

is_date(D, M, Y, TmpD, TmpM, TmpY, DW) when DW > 7 -> is_date(D, M, Y, TmpD, TmpM, TmpY, 1);
is_date(D, M, Y, TmpD, TmpM, TmpY, DW) when (D == TmpD), (TmpM == M), (TmpY == Y) -> DW;

is_date(D, M, Y, TmpD, TmpM, TmpY, DW) when TmpD == 28 ->
    case TmpM == 2 of
        true ->
            if
                (TmpY rem 4 == 0), (TmpY rem 100 /= 0) ; (TmpY rem 400 == 0) ->
                    is_date(D, M, Y, (TmpD + 1), TmpM, TmpY, (DW + 1));
                true ->
                    is_date(D, M, Y, 1, (TmpM + 1), TmpY, (DW + 1))
            end;
        false ->
            is_date(D, M, Y, (TmpD + 1), TmpM, TmpY, (DW + 1))
    end;

is_date(D, M, Y, TmpD, TmpM, TmpY, DW) when TmpD == 29 ->
    case TmpM == 2 of
        true -> is_date(D, M, Y, 1, (TmpM + 1), TmpY, (DW + 1));
        false -> is_date(D, M, Y, (TmpD + 1), TmpM, TmpY, (DW + 1))
    end;

is_date(D, M, Y, TmpD, TmpM, TmpY, DW) when TmpD == 30 ->
    case contains([1, 3, 5, 7, 8, 10, 12], TmpM) of
        true -> is_date(D, M, Y, (TmpD + 1), TmpM, TmpY, (DW + 1));
        false -> is_date(D, M, Y, 1, (TmpM + 1), TmpY, (DW + 1))
    end;

is_date(D, M, Y, TmpD, TmpM, TmpY, DW) when (TmpM == 12), (TmpD == 31) -> is_date(D, M, Y, 1, 1, (TmpY + 1), (DW + 1));
is_date(D, M, Y, TmpD, TmpM, TmpY, DW) when TmpD == 31 -> is_date(D, M, Y, 1, (TmpM + 1), TmpY, (DW + 1));
is_date(D, M, Y, TmpD, TmpM, TmpY, DW) -> is_date(D, M, Y, (TmpD + 1), TmpM, TmpY, (DW + 1)).

is_date(D, M, Y) -> is_date(D, M, Y, 1, 1, 2000, 6).

%% Вариант 1

%% Задание 1.
ball_volume(R) -> R * R * R * 4 / 3 * math:pi().

%% Задание 2.
from_t(N, M, L) when M == N -> [ M | L ];
from_t(N, M, L) when M > N ->
    from_t(N, M - 1, [ M | L ]);
from_t(N, M, _) when M < N ->
    exit({youPullBullshit, N, M}).
from_to(N, M) -> 
    from_t(N, M, []).

%% Задание 3.
delta([_ | L], L1) when L == [] -> L1;
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
insert([], X, ResLi) -> reverse([X|ResLi]);
insert([F|List], X, ResLi) when X > F -> insert(List, X, [F|ResLi]);
insert([F|List], X, ResLi) when X =< F -> reverse(ResLi) ++ [X|[F|List]].

%% Задание 3.

drop_every([], _, _, ResLi) -> reverse(ResLi);
drop_every([_|List], N, M, ResLi) when M == N -> drop_every(List, N, 1, ResLi);
drop_every([F|List], N, M, ResLi) -> drop_every(List , N, M+1, [F|ResLi]).

drop_every(List, N) -> drop_every(List, N, 1, []).

%% Задание 4.

%% decode([{a,3},b,{c,2},{a,2}]) => [a,a,a,b,c,c,a,a]

rle_decode([], _, ResLi) -> reverse(ResLi); 
rle_decode([{_, Cnt}|Li], Curr, ResLi) when Curr == Cnt -> rle_decode(Li, 0, ResLi);
rle_decode([{Sym, Cnt}|Li], Curr, ResLi) when Curr < Cnt -> rle_decode([{Sym, Cnt}|Li], (Curr + 1), [Sym|ResLi]);
rle_decode([Sym|Li], _, ResLi) -> rle_decode(Li, 0, [Sym|ResLi]).

rle_decode(List) -> rle_decode(List, 0, []).
