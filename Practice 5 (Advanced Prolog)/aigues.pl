
%% "B.1. Fer aigues: disposem d una aixeta d'aigua, una galleda de 5 litres i un altre de 8 litres."
%% "Es pot abocar el contingut d'una galleda en un altre (fins a buidar el primer, o fins a omplir"
%% "l altre), omplir una galleda, o buidar una galleda del tot. Escriure un programa Prolog que digui"
%% "la sequencia mes curta d’operacions per a obtenir exactament 4 litres d’aigua en la galleda de 8"
%% "litres."

main :- EstatInicial = [0,0], EstatFinal = [0,4], 
        between(1, 1000, CostMax),                  % Busquem solució de cost 0; si no, de 1, etc.
        cami(CostMax, EstatInicial, EstatFinal, [EstatInicial], Cami),
        reverse(Cami, Cami1), write(Cami1), write(' amb cost '), write(CostMax), nl, halt.

cami(0, E, E, C, C).                                % Cas base: quan l'estat actual és l'estat final.
cami(CostMax, EstatActual, EstatFinal, CamiFinsAra, CamiTotal) :-
        CostMax > 0, 
        unPas(CostPas, EstatActual, EstatSeguent),  % En B.1 i B.2, CostPas és 1.
        \+ member(EstatSeguent, CamiFinsAra),
        CostMax1 is CostMax-CostPas,
        cami(CostMax1, EstatSeguent, EstatFinal, [EstatSeguent|CamiFinsAra], CamiTotal).

%% 1. LLENAMOS LOS CUBOS
unPas(1, [0,B], [5,B]).
unPas(1, [A,0], [A,8]).

%% 2. VACIAMOS CUBOS
unPas(1, [_,B], [0,B]).
unPas(1, [A,_], [A,0]).


%% 3. CALCULAMOS RESTANTES DEL PRIMER CUBO AL SEGUNDO
unPas(1, [A,B], [A1,B1]):- AB is A + B , AB > 8,  A1 is AB - 8, B1 is 8.
unPas(1, [A,B], [A1,B1]):- AB is A + B , AB =< 8, A1 is 0    , B1 is AB.  

%% 4. CALCULAMOS RESTANTES DEL SEGUNDO CUBO AL PRIMER
unPas(1, [A,B], [A1,B1]):- BA is B + A,  BA >  5,  A1 is 5 , B1 is BA - 5.
unPas(1, [A,B], [A1,B1]):- BA is B + A, BA =< 5,  A1 is BA, B1 is 0. 
