      
swap_person([], []).
swap_person([X|Xs], [Y|Ys]) :- swap_word(X,Y), !, swap_person(Xs,Ys).

swap_word(X,Y) :- me_you(X,Y).
swap_word(X,Y) :- me_you(Y,X).
swap_word(W,W).

form_response(In,Out) :- append(In, [?], Out).

convert(Phrase, L) :- atomic_list_concat(L, ' ', Phrase).

% pronoun reversals 
me_you(i,you).
me_you(me,you).
me_you(my,your).
me_you(am,are).