%% "Missioners: busquem la manera mes rapida per tal que tres missioners i tres canibals"
%% "travessin un riu en una canoa que pot ser utilitzada per 1 o 2 persones (missioners o canibals),"
%% "pero sempre evitant que els missioners quedin en minoria en qualsevol riba (per raons obvies)."
main :- EstatInicial = [i,[3,3,0,0]], EstatFinal = [d,[0,0,3,3]], 
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

%% IDA

unPas(1, [i,[Mi, Ci, Mf, Cf ]], [d,[Mfi, Cfi, Mff, Cff]]):-  
                            
            move(Mv,Cv),      
            Mfi is Mi - Mv, Cfi is Ci - Cv,
            Mff is Mf + Mv, Cff is Cf + Cv,
            noComen(Mfi,Cfi), noComen(Mff, Cff).

%% VUELTA
unPas(1, [d,[Mi, Ci, Mf, Cf ]], [i,[Mfi, Cfi, Mff, Cff]]):-
            move(Mv,Cv), 
            Mfi is Mi + Mv, Cfi is Ci + Cv,
            Mff is Mf - Mv, Cff is Cf - Cv,
            noComen(Mfi,Cfi), noComen(Mff, Cff).


noComen(M,C):-         M == 0 , C >= 0, C =< 3,!.
noComen(M,C):- M >= C, M >= 0 , M =< 3, C >= 0, C =< 3.

%move(Mv, Cv):- member([Mv,Cv], [ [1,0],[0,1], [1,1], [2,0],[0,2] ]).
move(Mv, Cv):- member([Mv,Cv], [ [0,1],[0,2], [1,0], [1,1],[2,0] ]).
