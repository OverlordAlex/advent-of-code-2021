/* given a Pair as a "X,Y" string, turn it into a number pair */
to_numbers(Pair, (X,Y)) :-
    split_string(Pair, ",", ",", [Xstring,Ystring]),
    number_string(X, Xstring),
    number_string(Y, Ystring).

/* distribute a number into a list  */
zip([], [], []).
zip(X, [], []) :- number(X).
zip([], Y, []) :- number(Y).
zip(X, Y, [(X,Y)]) :- number(X), number(Y).
zip(X, [Y|Ys], [(X,Y)|Zs]) :- number(X), zip(X, Ys, Zs).
zip([X|Xs], Y, [(X,Y)|Zs]) :- number(Y), zip(Xs, Y, Zs).
zip([X|Xs], [Y|Ys], [(X,Y)|Zs]) :- zip(Xs, Ys, Zs).

/* interpolate the values from start -> end (both inclusive) */
fill(Start, End, Result) :- 
    Start < End,
    findall(X, between(Start, End, X), Result).
fill(Start, End, Result) :-
    Start > End,
    findall(X, between(End, Start, X), Forward),
    reverse(Forward, Result).
fill(Start, End, [Start]) :-
    Start = End.

/* create all pairs of points from (a,b) to (c,d)  */
interpolate((X1, Y1), (X2, Y2), [(X1, Y1)]) :-
    X1 = X2,
    Y1 = Y2.
interpolate((X1, Y1), (X2, Y2), Result) :-
    X1 \= X2,
    Y1 \= Y2,
    fill(X1, X2, Xs),
    fill(Y1, Y2, Ys),
    zip(Xs, Ys, Result).
interpolate((X1, Y1), (X1, Y2), Result) :-
    fill(Y1, Y2, Ys),
    zip(X1, Ys, Result).
interpolate((X1, Y1), (X2, Y1), Result) :-
    fill(X1, X2, Xs),
    zip(Xs, Y1, Result).

/* helper methods for debugging */
printt(Term) :-
    write_term(Term, [ portray(true),
                       numbervars(true),
                       quoted(false)
                     ]).
printa([]).
printa([X|Xs]) :- printt(X), printt(', '), printa(Xs).
println(X) :- printa(X), nl.

/* given a string a,b -> c,d turn it into all points as a line  */
parse(Line, Result) :-
    split_string(Line, " -> ", " -> ", [A,B]),
    to_numbers(A, First),
    to_numbers(B, Second),
    interpolate(First, Second, Result).

/* turn a list of lines in strings into a list of coordinates */
parse_lines([], []).
parse_lines([Line|Lines], [Result|Coords]) :-
    parse(Line, Result),    
    parse_lines(Lines, Coords).

:- use_module(library(readutil)).
main :-
    read_file_to_string('day5.in', AllLines, []),
    split_string(AllLines, '\n', '\n', Lines),
    parse_lines(Lines, Coords),
    flatten(Coords, Flat),
    length(Flat, L),
    print(L), nl,
    dups(Flat, Result),
    sort(Result, Set),
    length(Set, Length),
    print(Length), nl.

/* This works, but takes about 20 minutes on part2. Wtf Prolog? */
dups([], []).
dups([Item|List], [Item|Result]) :-
    member(Item, List),
    dups(List, Result).
dups([Item|List], Result) :-
    not(member(Item, List)),
    dups(List, Result).

