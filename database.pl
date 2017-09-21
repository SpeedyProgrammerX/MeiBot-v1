/* Reference : https://github.com/jlsalmon/chatbot/blob/master/src/assignment/database.pl
 * "Contains databases for general use throughout the chatbot program"
 */
 :- [lib, eliza].
 
responses_db(bye, [
    ['Bye!'],
    ['See ya!'], ['Cya!'], ['Later.'], 
    ['Have a nice day!'], ['Bye! Was nice meeting you.'],
    ['Trololol bye.']
    ]).

responses_db(greeting, [ 
    ['Hello!'],
    ['Hi.'], ['Heyy'], ['Heyyy'],['Sup :^)'],
    ['Hi! My name is MeiBot.'], ['I\'m MeiBot. Nice to meet you.']
    ]). % periods are important

responses_db(thanked, [
    ['You\'re welcome!'],
    ['No problem!'],
    ['Yep.'],
    ['Sure thing m8.'],
    ['Of course!'],
    ['It\'s all good!']
    ]). % and I did it again ;-;

responses_db(laughter, [
    ['hahahaha'],
    ['ohohoho'],
    ['huehuehu'],
    ['teehee'],
    ['ekekekeeke']
    ]).

responses_db(league, [
    ['League is fun'],
    ['I also play league lol. What role or champ do you play?'],
    ['League is one of my favorite game. What do you think about league?'],
    ['Oh .. my IGN is Milky Tea c:. What is yours? What champion do you play?']]).

responses_db(game, [
    ['I love video games'],
    ['Do you play league? '],
    ['Tell me more about the games you play.'],
    ['Oh .. which games do you play? I play League of Legends.']]).

responses_db(top, [
    ['I like to play Akali top c:'],
    ['What top champ do you play??'],
    ['Nerf Irelia and Riven!!! lol.. always broken'],
    ['hmmm .. i should try urgot top :^ ) Urgod.']]). 
    
responses_db(mid, [
    ['I love playing mid'],
    ['I used to play katarina mid before they reworked her c:'],
    ['I play kat mid and I recently got a cute skin from Devansh for Kat.'],
    ['Mid Blitz OP lol .. you should try it sometime']]).

responses_db(adc, [
    ['I hate CSing bot lane.. why can i just not mid instead'],
    ['I want to play ashe like Devansh.. he is OP >D'],
    ['jinx adc sounds fun but too much skill shots :c'],
    ['Oh .. what adc do you play?? you should try ad Ahri. It works lol']]).
    
responses_db(supp, [ 
    ['Aileen\'s Nami support is best support NA <33'],           % i copy pasted lol ehehe
    ['Devansh\'s lux support opop prob best NA. But I\'ll never tell him that. B)'],
    ['Support is fun ... teehee <3'], 
    ['I just start roaming if my adc starts trash talking D:<']]).
    
responses_db(jg, [
    ['I like to see Aileen jg.. she is duh best <33 '],
    ['I dont understand the jungle rework :c but i like plants :D'],
    ['The new plants are funny. I tossed Deva'],
    ['Aileen and her emumu OMG c\': .. Best Jg NA']]).
    
responses_db(liked_food, S, [[A], [B]]) :- 
    join3('I like eating ', S, '!', A), 
    join2(S, ' is delicious!', B).

responses_db(disliked_food, S, [['Ewwww..'], [A], [B]) :-
    join2(S, '... yuck.', A), 
    join3('You actually like ', S, 's??? :c', B).

responses_db(random_answer, [
    ['Sorry, what?'],
    ['Not sure what you\'re asking me!'],
    ['Can you repeat that question?'],
    ['Uhhhhhhhhhhhhh'],
    ['No idea!'],
    ['You figure it out :^)']
    ]).

/* Using pronoung reversal */
responses_db(pronoun_reversal, S, R):- 
                                swap_person(S, SwappedWordList),
                                form_response(SwappedWordList, R).

greeting_db([
    hello, 
    hi, 
    hey, 
    heyy, 
    heyyy, 
    sup, 
    hai, 
    nihao, 
    hola, 
    aloha]).
    
thanks_db([
    thanks, 
    thankyou, 
    thank, 
    cheers, 
    xiexie]).
    
% Added by Devansh. Beautiful.
laughter_db([
    haha, 
    hahaha,
    hahahahaha,
    hahahahahaha,
    lol,
    'LOL',
    funny,
    laughing]).

bye_db([
    bye,
    cya,
    later,
    seeya,
    bai]).

/* ==========================================================================*/

games_db([
    game,
    games,
    pc,
    videogame]).

/* ==========================================================================*/
/* League Stuff */

league_db([
    league,
    'League',
    'league of legends']).
    
support_db([
    blitz,
    janna, 
    morgana,
    veigar,
    braum,
    'supp']).
    
adc_db([
    ashe,
    jinx, 
    'MF',
    lucian,
    draven,
    bot,
    adc]).

mid_db([
    ahri,
    lux,
    katarina,
    veigar,
    zed,
    mid,
    'mid lane']).

top_db([
    akali,
    garen,
    darius,
    riven,
    top]).

jg_db([
    elise,
    'lee sin',
    fiddle,
    fiddlesticks,
    nocturne, 
    amumu, 
    emumu,
    'master yi',
    yi,
    jg]).
    
/* ==========================================================================*/

likedfoods_db([
    [[egg],[tart]],
    cookie,
    cake,
    cheesecake,
    sushi,
    'ice cream']).

dislikedfoods_db([
    help,
    'brussel sprouts'
    ]).
    
question_db([
    what,
    how,
    '?']).