%% "B.3. Pont de nit: tracta d’esbrinar la manera mes rapida que tenen quatre persones P1,"
%% "P2, P5 i P8 per a creuar de nit un pont que nomes aguanta el pes de dues, on tenen una unica i"
%% "imprescindible llanterna i cada Pi triga i minuts a creuar. Dues juntes triguen com la mes lenta"
%% "de les dues."

main :- EstatInicial = [i,[1,2,5,8],[] ], EstatFinal = [ f,[], [1,2,5,8] ], 
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

%% CRUZAN DOS PERSONAS DE i A f
unPas(CostePaso, [i, O_I, D_I], [f, O_F, D_F]):-
                select(A, O_I, Temp),
                select(B, Temp, O_F),
                A \= B,
                CostePaso is max(A,B),
                %"subtract(O_I, [A,B], O_F),"
                append(D_I, [A,B], Temp1), sort(Temp1, D_F).
     
%% CRUZAN DOS PERSONAS DE f A i
unPas(CostePaso, [f, O_I, D_I], [i, O_F, D_F]):-
                select(A, O_I, Temp),
                select(B, Temp, O_F),
                A \= B,
                CostePaso is max(A,B),
                %"subtract(O_I, [A,B], O_F),"
                append(D_I, [A,B], Temp), sort(Temp, D_F).
                
%% CRUZA UNA PERSONAS DE i A f
unPas(CostePaso, [i, O_I, D_I], [f, O_F, D_F]):-
                select(A, O_I, O_F),
                CostePaso is A,
                % "subtract(O_I, [A], O_F),"
                append(D_I, [A], Temp), sort(Temp, D_F).

%% CRUZA UNA PERSONAS DE f A i
unPas(CostePaso, [f, O_I, D_I], [i, O_F, D_F]):-
                select(A, O_I, O_F),
                CostePaso is A,
                % "subtract(O_I, [A], O_F),"
                append(D_I, [A], Temp), sort(Temp, D_F).

