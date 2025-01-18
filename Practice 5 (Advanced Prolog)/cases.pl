%% "Problema A: donades cinc persones, que tenen cinc cases de colors diferents, i cinc professions, animals,"
%% "begudes i nacionalitats diferents, i sabent que:"
%% "escriu un programa Prolog que averigue per a cada persona totes les seves caracteristiques de la"
%% "forma [numcasa,color,professio,animal,beguda,pais] averiguables."
%% "Nota: partint d’una solucio [ [1,A1,B1,C1,D1,E1],...,[5,A5,B5,C5,D5,E5] ], es poden"
%% "imposar totes les condicions sobre aquesta amb member o similars."

alLado(P,I):- I is P - 1, I >= 1.
alLado(P,D):- D is P + 1, D =< 5 .

main:- Sol =    [ 
                    [1,_,_,_,_,_],
                    [2,_,_,_,_,_],
                    [3,_,_,_,_,_],
                    [4,_,_,_,_,_],
                    [5,_,_,_,_,_]
                ],

%% "1 - El que vive en la casa roja es de Perú"
    member([_,roja,_,_,_,peru], Sol),
%% "2 - Al francés le gusta el perro"
    member([_,_,_,perro,_,frances], Sol),
%% "3 - El pintor es japonés"
    member([_,_,pintor,_,_,japones], Sol),
%% "4 - Al chino le gusta el ron"
    member([_,_,_,_,ron,chino], Sol),
%% "5 - El húngaro vive en la primera casa"
    member([1,_,_,_,_,hungria], Sol),
%% "6 - Al de la casa verde le gusta el coñac"
    member([_,verde,_,_,conac,_], Sol),
%% "7 - La casa verde está justo a la izquierda de la blanca"
    member([I,verde,_,_,conac,_], Sol),
    D is I + 1,
    member([D,blanca,_,_,_,_]   , Sol),
%% "8 - El escultor crı́a caracoles"
    member([_,_,escultor,caracoles,_,_], Sol),
%% "9 - El de la casa amarilla es actor"
    member([_,amarilla,actor,_,_,_], Sol),
%% "10 - El de la tercera casa bebe cava"
    member([3,_,_,_,cava,_], Sol),
%% "11 - El que vive al lado del actor tiene un caballo"
    member([P1,amarilla,actor,_,_,_], Sol),
    alLado(P1,L1),
    member([L1,_,_,caballo,_,_], Sol),    
%% "12 - El húngaro vive al lado de la casa azul"
    member([P2,_,_,_,_,hungria], Sol),
    alLado(P2,L2),
    member([L2,azul,_,_,_,_], Sol),    
%% "13 - Al notario la gusta el whisky"
    member([_,_,notario,_,whisky,_], Sol),
%% "14 - El que vive al lado del médico tiene un ardilla,"
    member([P3,_,medico,_,_,_], Sol),
    alLado(P3,L3),
    member([L3,_,_,ardilla,_,_], Sol),  
    print(Sol),!.   %% "los member se ejecutan por cada elemento, por eso ponemos !, para uno unificar"
                    %% "las variables que contiene izquierda o derecha deben llamarse diferentes porque contienen"
                    %% "posiciones diferentes"
 
print(L):- member(SL,L), write(SL), nl, fail.
print(_).