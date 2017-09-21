/* 
 * Reference : https://github.com/jlsalmon/chatbot/blob/master/src/assignment/chat.pl 
 * 
 * Description:
 * This holds all the code required for user-interactions:
 * getting user input and generating responses.
 *
 * What we've learned so far from working on this:
 *      1. I really liked the commenting style. - A
 *      2. I didn't know how to connect different .pl files previously. - A
 *
 * Terms and/or commands learned:
 *      flush_output ->  is actually an output goal, which ensures that any output 
                         which has been requested but not yet performed, is performed right 
                         now. Output might not be completed until there is enough to make it 
                         worthwhile, or until an operation like flush_output forces it.
 */
 
% I suppose this is to load in the other .pl files
:- [database, lib, names, foods, readin, eliza].
:- use_module(library(random)). % I'm assuming this is to use the random num generator thing ??
:- dynamic usr_name/1.

/* ========================================================================= */

% chat/0
% allows user to start the conversation
chat :-
    print_welcome, askName,
    conversations.
    
% conversations/0
% "Main chatbot backtrackingn loop. Repeats until user enters 'bye'"
conversations :- 
    repeat, % repeat through backtracking
    print_prompt(you), % show that it is the user's turn to type
    readin(S), % read in the user's input
    gen_reply(S,R), % generate a response
    print_prompt(me), % show that it is the chatbot speaking next
    write_list(R), % display the chatbot's response (found using gen_reply/2)
    is_quit(S), !. 


/* ========================================================================= */
/* All of these are to generate a response. */

% gen_reply/2
% generates a response based on the user input

gen_reply(S, R) :- % check for "bye"
    is_quit(S), !, retract(usr_name(X)),
    responses_db(bye, Res), % finds the related list of responses from database.pl
    random_pick(Res, R).

gen_reply(S,R) :- % check for greeting
    is_greeting(S), !,
    responses_db(greeting, Res),
    random_pick(Res, R).
    
gen_reply(S,R) :- % check for thanks
    is_thanks(S), !,
    responses_db(thanked, Res),
    random_pick(Res, R).

gen_reply(S,R) :- % innovated laughter here 
    is_laughter(S), !,
    responses_db(laughter, Res),
    random_pick(Res, R).
    
/* Game related responses */
gen_reply(S,R) :- 
    is_game(S), !,
    responses_db(game, Res),
    random_pick(Res, R).

gen_reply(S,R) :- 
    is_league(S), !,
    responses_db(league, Res),
    random_pick(Res, R).

gen_reply(S,R) :- 
    is_top(S), !,
    responses_db(top, Res),
    random_pick(Res, R).

gen_reply(S,R) :- 
    is_mid(S), !,
    responses_db(mid, Res),
    random_pick(Res, R).
    
gen_reply(S,R) :- 
    is_adc(S), !,
    responses_db(adc, Res),
    random_pick(Res, R).

gen_reply(S,R) :- 
    is_supp(S), !,
    responses_db(supp, Res),
    random_pick(Res, R).

gen_reply(S,R) :- 
    is_jg(S), !,
    responses_db(jg, Res),
    random_pick(Res, R).
    
/* Likes and Dislikes */
gen_reply(S, R) :-
    is_liked(S), 
    nth_item(S,Y,N),food(N), !, 
    responses_db(liked_food, N, Res),
    random_pick(Res, R).

gen_reply(S, R) :-
    is_disliked(S),
    nth_item(S, _, N), food(N), !,
    responses_db(disliked_food, N, Res),
    random_pick(Res, R).

    
/* Answering Questions */

gen_reply(S, R) :-
    is_question(S), !,
    responses_db(random_answer, Res),
    random_pick(Res, R).
     
gen_reply(S, R) :-
    responses_db(pronoun_reversal, S, R), !.


/* Name Stuff */

askName() :- print_prompt(me), write('What is your name?'), nl, print_prompt(you), readin(X), setName(X).


setName(X) :- is_valid_name(X, N), print_prompt(me), write('Nice to meet you, '), write(N), nl, assert(usr_name(N)), !.
setName(X) :- write('I don\'t believe you, but okay!'), write('Nice to meet you, '), write(X), nl, assert(usr_name(X)), !.

is_valid_name(NL, N):-
        nth_item(NL, _, N),
        name(N), !.
       
  
/* ========================================================================= */

% print_welcome/0
% Outputs a random greeting message.
print_welcome :-
    responses_db(greeting, D),
    random_pick(D, W),
    print_prompt(me),
    write_list(W),
    flush_output. % I suppose this part is jus  t for some sort of output protection ?

% Shows the user who is currently speaking and/or
% who's turn it is to speak: the chatbot, or the user.
print_prompt(me) :-
    my_icon(X), write(X), write(': '), flush_output.
print_prompt(you) :-
    user_icon(X), write(X), write(': '), flush_output.
    
my_icon('MeiBot').
%user_icon(X):- X is user_name2(Y). /* and this to the user's name...? or just leave as 'User' */
user_icon(X):- usr_name(Y), X = Y, !.
user_icon('User').

% random_pick/2
% Picks a random response (Res) from a list (R)
random_pick(Res, R) :-
    length(Res, Length),
    Upper is Length + 1,
    random(1, Upper, Rand),
    nth_item(Res, Rand, R).


/* ========================================================================= */
/* Supporting Rules */

is_quit(S) :-
    subset([bye],S). % subset/2 is a method in the lib.pl */
is_quit(S) :- % added to try to incorporate more 'bye' options
    bye_db(D),
    intersect(S, D, A),
    A \== [].

is_greeting(S) :-
    greeting_db(D),
    intersect(S, D, A),
    A \== [].

is_thanks(S) :-
    thanks_db(D),
    intersect(S, D, A),
    A \== [].

/* question related*/

/*is_question(S) :-
    string_to_atom(S, S1),
    question_db(D),
    intersect(S, D, A),
    A \== [], !.
*/
    
is_question(S) :-
    member('?', S), !.

is_laughter(S) :-
    laughter_db(D),
    intersect(S, D, A),
    A \== [].

/* check likes and dislikes */
is_liked(S) :-
    likedfoods_db(D),
    intersect(S, D, A),
    A \== [].

is_disliked(S) :-
    dislikedfoods_db(D),
    intersect(S, D, A),
    A \== [].

is_game(S) :-
    games_db(D),
    intersect(S, D, A),
    A \== [].
    
is_league(S) :-
    league_db(D),
    intersect(S, D, A),
    A \== [].
    
is_top(S) :-
    top_db(D),
    intersect(S, D, A),
    A \== [].

is_mid(S) :-
    mid_db(D),
    intersect(S, D, A),
    A \== [].
    
is_adc(S) :-
    adc_db(D),
    intersect(S, D, A),
    A \== [].
    
is_supp(S) :-
    support_db(D),
    intersect(S, D, A),
    A \== [].

is_jg(S) :-
    jg_db(D),
    intersect(S, D, A),
    A \== [].