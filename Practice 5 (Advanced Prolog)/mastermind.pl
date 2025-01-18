%% C1. "Construeix un predicat resposta(Codi,Intent,E,D) que, donat un Codi i un Intent calculi els els n´umeros E, D de la"
%%     "resposta."

resposta(L,L1,E,D):-    findall(I, encertatPosition(L,L1, I),  Lits), length(Lits,  E), length(L,N), listIndexs(N, LV),
                        subtract(LV, Lits, LI),
                        findall(E1, ( member(I,LI), filter(I, L , E1 ) ), Lits1),
                        findall(E2, ( member(I,LI), filter(I, L1, E2 ) ), Lits2),
                        intersection(Lits1,Lits2, TL), length(TL,Aux), T is Aux + E, D is T - E.

encertatPosition(L,L1, Index):- nth1(Index, L, Value), nth1(Index, L1, Value). 

filter(I,L, E):- nth1(I, L, E). 
listIndexs(N, LV):- length(LV, N), findall(I, nth1(I, LV, I), LV).
%% C2. "Volem ara ajudar l’atacant a guanyar el joc, suggerint-li intents. Assumeix que ens donen una clausula de la forma:"

intents([ [ [v,b,g,l], [1,1] ], [ [m,t,g,l], [1,0] ], [ [g,l,g,l], [0,0] ], [ [v,b,m,m], [1,1] ], [ [v,t,b,t], [2,2] ]]).
colors([v,b,g,l,t,m]).

nouIntent(A):-  intents(L), colors(C), generaIntent(4, C, A), esConsistent(A, L),!.
               
%%  Es cierto, si el intento A es "consistente" con todos los intentos del historial          
esConsistent(_,[]).
esConsistent(A,[[H, [E,D]]|L]):- resposta(A,H,E,D), esConsistent(A, L).

%% Es cierto, si genera todas las posibles variaciones con repeticion (genera el intento A) 
generaIntent(0, _, []).
generaIntent(N, L, [H|L1]) :- N > 0, N1 is N - 1, member(H, L), generaIntent(N1, L, L1).


                