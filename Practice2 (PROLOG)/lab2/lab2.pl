% pert

pert(X, [X|_]).
pert(X, [_|Resto]):- pert(X, Resto).


% concat

concat([],L2,L2).
concat([X|L1], L2, [X|L3]):- concat(L1,L2, L3).


% pert_con_resto

pert_con_resto(X, L, Resto):- concat(L1,[X|L2], L), concat(L1, L2,Resto).


% suma elementos de una lista

suma_lista([], 0).
suma_lista([X| Resto], S):- suma_lista(Resto, SP), S is SP + X. 


% cuenta las aparaciones de un elemento en una lista

counter(_,[],0).
counter(X, [X |Resto], C ):- counter(X, Resto, CP), C is CP + 1, !. 
counter(X, [_ |Resto], C ):- counter(X, Resto, C).


% delete_element list

delete_element(_,[],[]).
delete_element(X, [X |Resto], L ):- delete_element(X, Resto, L), !. 
delete_element(X, [Y |Resto], [Y|L] ):- delete_element(X, Resto, L).


% permutacion
% permutacion(L,P) = "P es una permutacion de la lista L" hay n! factorial respuestas posibles 


permutacion([],[]).
permutacion([X|L], P):- permutacion(L,P1),     
			concat( Pa,    Pb, P1),
			concat( Pa, [X|Pb], P).

/* por cada elemento X de la lista lo concatenaremos con la permutacion del RESTO de elementos de la lista. */
permutacion1([],[]).
permutacion1(L, [X|P]):- pert_con_resto(X, L, Resto), permutacion1(Resto, P). 

% factorial
fact(0,1):-!.
fact(N, F):- N > 0, N1 is N - 1, fact(N1,F1), F is  N*F1.

% long (L,N) = "la longitud de L es N"

long([],0).
long([_|Resto], L):- long(Resto, L1), L is L1 + 1.

%subcjto(L,S) = "S es un subconjunto de L"  2^n
% Si L es [e1 ... en-1 en]
%           0 ...  0    1  
% hay tantos subconjuntos como tiras de n bits. Es decir, 2^n subconjuntos distintos
% hablamos de tiras de bits, porque podemos caracterizar estas tiras donde:
% un 1 significa: "elemento presente"
% un 0 significa: "elemento NO esta presente"
% estas tiras de bits de 1's y 0's nos permiten caracterizar todos los subconjunto de n elementos
% por ejemplo: la tira de todos "0's", representa el conjunto vacio
% por ejemplo: la tira de todos "1's", representa el conjunto de n elementos

subcjto( [], [] ). % lista vacia solo tiene un subconjunto "conjunto vacion"
subcjto( [_|L],    S  ):-  subcjto(L,S). % subconjunto donde NO esta el elemento X
subcjto( [X|L], [X|S] ):-  subcjto(L,S). % subconjunto donde NO esta el elemento X




% --------------------------------------------------------------------------------
% 1

prod([X],X).
prod([X|Resto], P):- prod(Resto, PP), P is PP*X.

% 2
pescalar([],[], 0).
pescalar([X|Resto1], [Y|Resto2], PE):- pescalar(Resto1, Resto2, PPE), PE is PPE + X*Y. 

% 3.1 union
union([], L2, L2).
union([X|Resto], L2, U):- pert(X, L2), union(Resto,L2, U), !.
union([X|Resto], L2, [X|U]):- union(Resto,L2, U).

% 3.2 interseccion

interseccion([],_, []).
interseccion([X|Resto], L2, [X|I]):- pert(X, L2), interseccion(Resto, L2, I),!.
interseccion([_|Resto], L2, I):- interseccion(Resto, L2, I).

% 4.1 ultimo elemento de una lista

ultimo_elemento(L, Last):- concat(_,[Last], L), !.

% 4.2 inversa de una lista
inversa([],[]).
inversa([X|Resto], I):- inversa(Resto, IP), concat(IP, [X], I).

% 5. fibonacci

fib(0,0).
fib(N, 1):- N >= 1, N =< 2.
fib(N, F):- N > 2, N1 is N - 1,  N2 is N - 2, fib(N1, F1) , fib(N2, F2), F is F1 + F2.

% 6
dados(0, 0, []).
dados(P, N, [X|LP]):- N > 0 , pert(X,[1,2,3,4,5,6]), P1 is P - X, N1 is N - 1, dados(P1, N1, LP). 


% 7 satisface si algun elemento es la suma de los otros elementos de la lista

suma_demas(L):- pert_con_resto(X, L, Resto), suma_lista(Resto, X), !.

% 8 satisface si algun elemento es la suma de los elementos anteriores de una lista dada

suma_ants(L):- concat(L1,[X|_], L), suma_lista(L1, X),!.
 
% 9  cards

card([],[]).
card([X| Resto], [[X,C]|R]):-  counter(X, [X|Resto], C),  delete_element(X, [X|Resto], L), card(L, R). 

card(L):- card(L, L1), write(L1).

% 10 esta_ordenada

esta_ordenada([_]):-!.
esta_ordenada([X,Y|Resto]):- X =< Y, esta_ordenada([Y|Resto]).

% 11 L2 es la lista de enteros L1 ordenada de menor a mayor

ord([],[]).
ord(L1,P):- permutacion(L1, P), esta_ordenada(P),!.


% 12

diccionario(_,0,[]).
diccionario(A, N, [X|LP]):- N > 0, pert(X , A), N1 is N - 1, diccionario(A, N1, LP).

diccionario(A, N):- diccionario(A, N, Res), write(Res).

% 13 palindromo


print(X):- write(X).

capicua([]).
capicua([X|Resto]):- inversa(X, X), print(X), capicua(Resto),!.
capicua([_|Resto]):- capicua(Resto).      


palindomos([]).
palindomos(L):- setof(P, permutacion(L, P), N), capicua(N).


% 14 send more money

sendmoremoney:- L = [ S, E, N, D, M, O, R, Y,_ ,_ ],
                permutacion([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], P), 
                
                L = P,
                M = 1,
                
                SEND  is  S*1000  +  E*100  + N*10  + D,
                MORE  is  M*1000  +  O*100  + R*10  + E,
                MONEY is  M*10000 +  O*1000 + N*100 + E*10 + Y,
                MONEY is SEND + MORE, 
                write(L),!.

% 15 simplifica
/*  ?- calcula(x*0, S). */


simplifica(E, E2):- calcula(E,E1), simplifica(E1, E2),!.
simplifica(E, E).                                /* responde a: ?- simplifica(5, S), porque calcula da FAIL  */


calcula(_*0, 0):-!.
calcula(0*_, 0):-!.
calcula(1*X, X):-!. 
calcula(X*1, X).


/*  unifica tanto enteros como enteros con incognitas */

/* producto de enteros */
calcula(A * B, B * C):- calcula(A,C),!.    /* unifica 5*4*3.  donde: A = 5 * 4 y B = 3        */
calcula(A * B, A * C):- calcula(B,C),!.    /* unifica 5*(4*3) donde: A = 5     y B = 4 * 3    */

/* suma de enteros (ojo con el orden de la diferencia) */
calcula(A + B, B + C):- calcula(A,C),!.  /* Unifica 5+4+3.  y 5x+4x+3x.   donde: A = 5 + 4 y B = 3      */
calcula(A + B, A + C):- calcula(B,C),!.  /* unifica 5+(4+3) y 5x+(4x+3x). donde: A = 5     y B = 4 + 3  */

/* diferencia de enteros ( igual que las otras operaciones )*/
calcula(A - B, C - B):- calcula(A,C),!.    /* unifica 5 - 4-3.  donde: A = 5 - 4 y B = 3        */
calcula(A - B, A - C):- calcula(B,C),!.    /* unifica 5 -(4-3). donde: A = 5     y B = 4 + 3    */

/* ------------------------------------------------------ */
/*

    producto de enteros 

    calcula(A*X + B*X, B*X + C*X):- calcula(A,C),!.    /* Procesa 5x+4x+3x.  donde: A = 5x + 4x y B = 3x        */
    calcula(A*X * B*X, A*X * C*X):- calcula(B,C),!.    /* Procesa 5+(4+3) donde: A = 5x     y B = 4x + 3x    */
    
    (NO HACE FALTA porque  

    este predicado ya calcula(A + B, B + C):- calcula(A,C),!. donde: A = 5*x + 4*x y B = 3*x   
    este predicado ya calcula(A + B, A + C):- calcula(B,C),!. donde: A = 5*x       y B = 4*x + 3*x  

*/

calcula(N1*X * N2*X, N3*X*X):-  number(N1), number(N2), N3 is N1 * N2.  /*  calcula 5*x * 3*x = 8*x      */
calcula(N1*X + N2*X, N3*X):-    number(N1), number(N2), N3 is N1 + N2.  /*  calcula 5*x + 3*x = 8*x      */
calcula(N1*X - N2*X, N3*X):-    number(N1), number(N2), N3 is N1 - N2.  /*  calcula 5*x - 3*x = 2*x      */

%  write(" "),write(N1),write(" "), write(N2), write(" | "), 
/* suma, diferencia, producto de enteros */
calcula(N1 * N2, N3):- number(N1), number(N2), N3 is N1 * N2.
calcula(N1 + N2, N3):- number(N1), number(N2), N3 is N1 + N2.
calcula(N1 - N2, N3):- number(N1), number(N2), N3 is N1 - N2.





% programa calcular derivadas

derivada(C,_, 0):- number(C),!.                                                 /* derivada de una constante                */
derivada(X,X, 1).                                                               /* f(x) = x          → f'(x) = 1            */
/* la linea siguiente no es necesaria, ya que la multiplicacion resuelve estos casos                                        */
%derivada(C*X,X, C):- number(C).                                                /* f(x) = ax         → f'(x) = a            */
derivada(U + V, X, DU + DV):-       derivada(U, X, DU), derivada(V,X,DV).       /* f(x) = u + x      → f(x) = u' + x'       */
derivada(U - V, X, DU - DV):-       derivada(U, X, DU), derivada(V,X,DV).       /* f(x) = u - x      → f(x) = u' - x'       */
derivada(U * V, X, U*DV + V*DU):-   derivada(U, X, DU), derivada(V, X, DV).     /* f(x) = u*v        → f(x) = v*u'+ u*v'    */ 
                                                                                /* also f(x) = ax    → f'(x) = a    */
derivada(sin(U),X,cos(U)*DU):-      derivada(U,X,DU).
derivada(cos(U),X,-sin(U)*DU):-     derivada(U,X,DU).
derivada(e^U,X,DU*e^U):-            derivada(U,X,DU).
derivada(ln(U),X,DU*1/U):-          derivada(U,X,DU).




%cifras( L, N ) escribe las maneras de obtener N
% a partir de + - * / y los elementos de la lista L
% ejemplo:
% ?- cifras( [4,9,8,7,100,4], 380 ).
%    4 * (100-7) + 8         <-------------
%    ((100-9) + 4 ) * 4
%    ...

cifras(L,N):-
    subcjto(L,S),         % S = [4,8,7,100]
    permutation(S,P),     % P = [4,100,7,8]
    expresion(P,E),       % E = 4 * (100-7) + 8 
    N is E,
    write(E), nl, fail.


% E = ( 4  *  (100-7) )    +    8
%            +
%          /   \
%         *     8
%        / \
%       4   -
%          / \
%        100  7

% Ver página del You Tube: http://www.youtube.com/watch?v=lBcwA0TYEVo
% A partir del minuto 6.
% Hacer llamada:
% ?- cifras([8,75,25,7,6,5], 901).

expresion([X],X).
expresion( L, E1 +  E2 ):- append( L1, L2, L), 
			  L1 \= [], L2 \= [],
			  expresion( L1, E1 ),
			  expresion( L2, E2 ).
expresion( L, E1 -  E2 ):- append( L1, L2, L), 
			  L1 \= [], L2 \= [],
			  expresion( L1, E1 ),
			  expresion( L2, E2 ).
expresion( L, E1 *  E2 ):- append( L1, L2, L), 
			  L1 \= [], L2 \= [],
			  expresion( L1, E1 ),
			  expresion( L2, E2 ).
expresion( L, E1 // E2 ):- append( L1, L2, L), 
			  L1 \= [], L2 \= [],
			  expresion( L1, E1 ),
			  expresion( L2, E2 ),
                          K1 is E1,
                          K2 is E2,
                          K2\=0,    % evitamos que se produzcan divisiones por cero
                          0 is K1 mod K2. % imponemos divisiones exactas!





