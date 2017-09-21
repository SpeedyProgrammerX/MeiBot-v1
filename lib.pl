/*
 * Reference: https://github.com/jlsalmon/chatbot/blob/master/src/assignment/lib.pl
 * 
 * Description:
 * General functions required for the rest of the program to run.
 */
 
 
% intersect(Set1, Set2, Subset)
% Checks to see if SubSet is an intersection of Set1 and Set2
intersect([], _, []).
intersect([H|T1], L2, [H|T3]) :-
    member(H, L2), !,               % member/2 -> is H a member of list L2
    intersect(T1, L2, T3).
intersect([_|T1], L2, L3) :-
    intersect(T1, L2, L3).

% write_list(List)
% Prints a list without brackets and without separating commas
write_list([]) :- nl.
write_list([H|T]) :-
    write(H), write(' '), write_list(T).

% subset(SubSet, Set)
% True if SubSet is a subset of Set
subset([],_).
subset([H|T], L2) :-
    member(H, L2),
    subset(T, L2).
    
% nth_item(List, N, Item)
% Holds true if the N-th item in the List is Item.
nth_item([H|_], 1, H).
nth_item([_|T], N, X) :-
    nth_item(T, N1, X),
    N is N1 + 1.
    
    
/* ========================================================================= */
/* Need to figure out these still */

% contains(String, SubString)
% True if the substring exists in String.
contains(A, B) :-
    atom(A),
    atom(B),
    name(A, AA), 
    name(B, BB),
    contains(AA, BB).
contains(A, B) :-
    atom(A),
    name(A, AA),
    contains(AA, B).
contains(A, B) :-
    sublist(B, A),
    B \= [].
    
sublist(S,L) :-
    append(_, L2, L),
    append(S, _, L2).
    
%------ 
join2(A, B, X) :- name(A, L1), name(B,L2),
                append(L1,L2,Newlist), name(X, Newlist).

/* The predicate join3/4 defined below uses join2 twice to join three strings
   together. */
   /* Join three strings using the join2 predicate */
join3(String1, String2, String3, Newstring) :-
    join2(String1, String2, S),
    join2(S, String3, Newstring).

/* Now make a prolog program to join four strings. */
   /* Join four strings using the join3 and join2 predicates */
join4(String1, String2, String3, String4, Newstring) :-
    join3(String1, String2, String3, S),
    join2(S, String4, Newstring).
