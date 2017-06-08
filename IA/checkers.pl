
%:- set_prolog_flag(answer_write_options,[quoted(true), portray(true), max_depth(0), spacing(next_argument)]).
suppr(_,[],[]).
suppr(X,[X|R],R1):-suppr(X,R,R1),!.
suppr(X,[Y|R],[Y|R1]):-
	suppr(X,R,R1).

conc([], L, L). 
conc([X|R1], L2, [X|R]) :-
	conc(R1,L2,R).


% On garde le Ll pour pouvoir sauvegarder le numero de la ligne pour connaitre son successeur
nextwp([_|R],Ll,L/C,N):-  L \== 1, 
                          L1 is L- 1,
                          nextwp(R,Ll, L1/C ,N),!.    

nextwp([X,Y|R],T,L/C,[s(TL/K2,N2)]):- L==1,
                                      K is C-1,
                                      TL is T + 1,
                                      K @=< 0,
                                      K2 is C + 1,
                                      findwp(Y,K2,N2),!.

nextwp([X,Y|R],T,L/C,[s(TL/K,N)]):-  L==1, K is C-1,
                      TL is T + 1,
                        K2 is C + 1,
                        K2 @>=9,
                        
                        findwp(Y,K,N),!.

nextwp([X,Y|R],T,L/C,[s(TL/K,N1),s(TL/K2,N2)]):-L==1, K is C-1,
                        TL is T + 1,
                        K2 is C + 1,
                        findwp(Y,K,N1),
                        findwp(Y,K2,N2),!.

findwp([X|R],C1,X):-C1 == 1,!.

findwp([_|R],C1,X):- C1 @>=1,
                    C1 @=<8,
                    C1 \== 1,
                    C is C1 -1,
                    findwp(R,C,X). 
%%%%%%% for the king option
nextbk([X,Y|R],TL,L/C,[s(TL1/K2,N)]):- TL==1,
                                       K is C-1,
                                       K @=< 0,
                                       K2 is C + 1,
                                       TL1 is TL + 1 ,
                                       findbp(Y,K2,N),!.
                                       
nextbk([X,Y|R],TL,L/C,[s(TL1/K2,N)]):- TL==1,K is C+1,K @>=9,K2 is C - 1,TL1 is TL + 1 ,
                          findbp(Y,K2,N),!.                          
nextbk([X,Y|R],TL,L/C,[s(TL1/K1,N1),s(TL1/K2,N2)]):- TL==1,K1 is C-1, K2 is C+1,TL1 is TL + 1 ,
                        findbp(Y,K1,N1),
                        findbp(Y,K2,N2),!.
%nextbk([X,Y|R],Tl,L/C,[s(TL1/K2,N)]):- TL==8,K is C-1,K @=< 0,K2 is C + 1,TL1 is TL - 1 ,
%                          findbp(Y,K2,N),!.


nextbk([_|R],TL,L/C,N):- L \== 2, 
                    L1 is L - 1,
                    nextbk(R,TL, L1/C ,N),!.

nextbk([Z,Y],TL,L/C,[s(TL1/K2,N)]):-TL ==8,L==2, 
                        TL1 is TL - 1 , K is C-1,K @=< 0,
                        K2 is C + 1,
                        findbp(Z,K2,N),!.

nextbk([Z,Y],TL,L/C,[s(TL1/K2,N)]):-TL ==8,L==2, 
                        TL1 is TL - 1 , K2 is C-1,K is C + 1,K @>=9,
                        findbp(Z,K2,N),!.

nextbk([Z,Y],TL,L/C,[s(TL1/K,N3),s(TL1/K2,N4)]):-TL ==8,L==2,TL1 is TL - 1 , K is C-1,
                        K2 is C + 1,
                        findbp(Z,K,N3),
                        findbp(Z,K2,N4),!.


nextbk([X,Y,Z|R],TL,L/C,[s(TL1/K2,N1),s(TL2/K2,N2)]):- L==2,K is C-1,
                        K @=< 0,
                        K2 is C + 1,
                         TL1 is TL - 1 ,
                        TL2 is TL + 1,
                        findbp(X,K2,N1),
                        findbp(Z,K2,N2),!.
                      

nextbk([X,Y,Z|R],TL,L/C,[s(TL1/K,N1),s(TL2/K2,N2)]):-L==2, K is C-1,   
                        K2 is C + 1,
                        K2 @>=9,
                        TL1 is TL - 1 ,
                        TL2 is TL + 1,
                        findbp(X,K,N1),
                        findbp(Z,K,N2),!.

nextbk([X,Y,Z|R],TL,L/C,[s(TL1/K,N1),s(TL1/K2,N2),s(TL2/K,N3),s(TL2/K2,N4)]):-L==2, K is C-1,
                        K2 is C + 1,
                        TL1 is TL - 1 ,
                        TL2 is TL + 1,
                        findbp(X,K,N1),
                        findbp(X,K2,N2),
                        findbp(Z,K,N3),
                        findbp(Z,K2,N4),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% lets try the same thing with wk
nextwk([X,Y|R],TL,L/C,[s(TL1/K2,N)]):- TL==1,K is C-1,K @=< 0,K2 is C + 1,TL1 is TL + 1 ,
                          findwp(Y,K2,N),!.
nextwk([X,Y|R],TL,L/C,[s(TL1/K2,N)]):- TL==1,K is C+1,K @>=9,K2 is C - 1,TL1 is TL + 1 ,
                          findwp(Y,K2,N),!.                          
nextwk([X,Y|R],TL,L/C,[s(TL1/K1,N1),s(TL1/K2,N2)]):- TL==1,K1 is C-1, K2 is C+1,TL1 is TL + 1 ,
                        findwp(Y,K1,N1),
                        findwp(Y,K2,N2),!.
                        %%%%%%%%%%%%%%%%%%%%%%%%%%
nextwk([_|R],TL,L/C,N):- L \== 2, 
                    L1 is L- 1,
                    nextwk(R, TL,L1/C ,N),!.



nextwk([Z,Y],TL,L/C,[s(TL1/K2,N)]):-TL ==8,L==2, 
                        TL1 is TL - 1 , K is C-1,K @=< 0,
                        K2 is C + 1,
                        findwp(Z,K2,N),!.

nextwk([Z,Y],TL,L/C,[s(TL1/K2,N)]):-TL ==8,L==2, 
                        TL1 is TL - 1 , K2 is C-1,K is C + 1,K @>=9,
                        
                        findwp(Z,K2,N),!.

nextwk([Z,Y],TL,L/C,[s(TL1/K,N3),s(TL1/K2,N4)]):-TL ==8,TL1 is TL - 1 ,L==2, K is C-1,
                        K2 is C + 1,
                        findwp(Z,K,N3),
                        findwp(Z,K2,N4),!.




nextwk([X,Y,Z|R],TL,L/C,[s(TL1/K2,N1),s(TL2/K2,N2)]):- L==2,K is C-1,
                        K @=< 0,
                        K2 is C + 1,
                        TL1 is TL - 1 ,
                        TL2 is TL + 1,
                        
                        findwp(X,K2,N1),
                        findwp(Z,K2,N2),!.

nextwk([X,Y,Z|R],TL,L/C,[s(TL1/K,N1),s(TL2/K,N2)]):-L==2, K is C-1,
                        K2 is C + 1,
                        K2 @>=9,
                        TL1 is TL - 1 ,
                        TL2 is TL + 1,
                        findwp(X,K,N1),
                        findwp(Z,K,N2),!.

nextwk([X,Y,Z|R],TL,L/C,[s(TL1/K,N1),s(TL1/K2,N2),s(TL2/K,N3),s(TL2/K2,N4)]):-L==2, K is C-1,
                        K2 is C + 1,
                        TL1 is TL - 1 ,
                        TL2 is TL + 1,
                        findwp(X,K,N1),
                        findwp(X,K2,N2),
                        findwp(Z,K,N3),
                        findwp(Z,K2,N4),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nextbp([_|R],Ll,L/C,N):- L \== 2, 
                    L1 is L- 1,
                    nextbp(R,Ll, L1/C ,N),!.

nextbp([X|_],T,L/C,[s(TL/K2,N2)]):- L==2,K is C-1,
                        TL is T - 1,
                        K @=< 0,
                        K2 is C + 1,
                        findbp(X,K2,N2),!.
nextbp([X|_],T,L/C,[s(TL/K,N)]):-L==2, K is C-1,
                        TL is T - 1,
                        K2 is C + 1,
                        K2 @>=9,
                        
                        findbp(X,K,N),!.
 
nextbp([X|_],T,L/C,[s(TL/K,N1),s(TL/K2,N2)]):-L==2, K is C-1,
                        TL is T - 1,
                        K2 is C + 1,
                        findbp(X,K,N1),
                        findbp(X,K2,N2),!.




findbp([X|_],C1,X):-C1 @>=1,
                    C1 @=<8,
                    C1 == 1,!.

findbp([_|R],C1,X):- C1 @>=1,
                    C1 @=<8,
                    C1 \== 1,
                    C is C1 -1,
                    findbp(R,C,X).            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % On va extraire la liste des successeurs qu'on va traiter ligne par ligne et qu'on va concatener dans E3' 
listsuccwp(_,[],[],9).
listsuccwp(List,[X|R],E3,L):-succcolwp(List,X,E1,L,1), 
                            L1 is L + 1,
                            conc(E1,E,E3),
                            listsuccwp(List,R,E,L1).


% On va parcourir nos sous listes des qu'on trouve un wp on va essayer de trouver ces successeurs.
% On va supprimer les WP et Wk des successeurs car il ne peut pas attaquer ces propres piÃ¨ces.
succcolwp(_,[],[],_,_).
succcolwp(List,[wp|R],E1,L,C):- nextwp(List,L,L/C,N),
                            suppr(s(_A,wp),N,Nn1),
                            suppr(s(_B,wp),Nn1,Nn2),
                            suppr(s(_C,wp),Nn2,Nn3),
                            suppr(s(_D,wp),Nn3,Nn4),
                            suppr(s(_E,wk),Nn4,Nn5),
                            suppr(s(_F,wk),Nn5,Nn6),
                            suppr(s(_G,wk),Nn6,Nn7),
                            suppr(s(_H,wk),Nn7,Nn),
                            Nn \== [],
                            conc([[L/C,Nn]],E,E1),!,
                            C1 is C + 1,
                            succcolwp(List,R,E,L,C1).
succcolwp(List,[wp|R],E1,L,C):- nextwp(List,L,L/C,N),
                            suppr(s(_A,wp),N,Nn1),
                            suppr(s(_B,wp),Nn1,Nn2),
                            suppr(s(_C,wp),Nn2,Nn3),
                            suppr(s(_D,wp),Nn3,Nn4),
                            suppr(s(_E,wk),Nn4,Nn5),
                            suppr(s(_F,wk),Nn5,Nn6),
                            suppr(s(_G,wk),Nn6,Nn7),
                            suppr(s(_H,wk),Nn7,Nn),
                            Nn == [],!,   
                            C1 is C + 1,
                            succcolwp(List,R,E1,L,C1).

succcolwp(List,[wk|R],E1,L,C):-nextwk(List,L,L/C,N),
                             suppr(s(_A,wp),N,Nn1),
                            suppr(s(_B,wp),Nn1,Nn2),
                            suppr(s(_C,wp),Nn2,Nn3),
                            suppr(s(_D,wp),Nn3,Nn4),
                            suppr(s(_E,wk),Nn4,Nn5),
                            suppr(s(_F,wk),Nn5,Nn6),
                            suppr(s(_G,wk),Nn6,Nn7),
                            suppr(s(_H,wk),Nn7,Nn),
                              Nn \== [],!,
                              conc([[L/C,Nn]],E,E1),
                              C1 is C + 1,
                              succcolwp(List,R,E,L,C1).

succcolwp(List,[wk|R],E1,L,C):-nextwk(List,L,L/C,N),
                              suppr(s(_A,wp),N,Nn1),
                            suppr(s(_B,wp),Nn1,Nn2),
                            suppr(s(_C,wp),Nn2,Nn3),
                            suppr(s(_D,wp),Nn3,Nn4),
                            suppr(s(_E,wk),Nn4,Nn5),
                            suppr(s(_F,wk),Nn5,Nn6),
                            suppr(s(_G,wk),Nn6,Nn7),
                            suppr(s(_H,wk),Nn7,Nn),
                              Nn == [],!,
                              
                              C1 is C + 1,
                              succcolwp(List,R,E,L,C1).
succcolwp(List,[_|R],E,L,C):- C1 is C + 1,
                            succcolwp(List,R,E,L,C1),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


listsuccbp(_,[],[],9).
listsuccbp(List,[X|R],E3,L):-succcolbp(List,X,E1,L,1),L1 is L + 1,conc(E1,E,E3),
                        listsuccbp(List,R,E,L1),!.


succcolbp(_,[],[],_,_).
succcolbp(List,[bp|R],E1,L,C):- nextbp(List,L,L/C,N),
                            suppr(s(_A,bp),N,Nn1),
                            suppr(s(_B,bp),Nn1,Nn2),
                            suppr(s(_C,bp),Nn2,Nn3),
                            suppr(s(_D,bp),Nn3,Nn4),
                            suppr(s(_E,bk),Nn4,Nn5),
                            suppr(s(_F,bk),Nn5,Nn6),
                            suppr(s(_G,bk),Nn6,Nn7),
                            suppr(s(_H,bk),Nn7,Nn),
                            Nn \== [],
                            conc([[L/C,Nn]],E,E1),!,
                            C1 is C + 1,
                            succcolbp(List,R,E,L,C1).
succcolbp(List,[bp|R],E1,L,C):- nextbp(List,L,L/C,N),
                            suppr(s(_A,bp),N,Nn1),
                            suppr(s(_B,bp),Nn1,Nn2),
                            suppr(s(_C,bp),Nn2,Nn3),
                            suppr(s(_D,bp),Nn3,Nn4),
                            suppr(s(_E,bk),Nn4,Nn5),
                            suppr(s(_F,bk),Nn5,Nn6),
                            suppr(s(_G,bk),Nn6,Nn7),
                            suppr(s(_H,bk),Nn7,Nn),
                            Nn == [],!,   
                            C1 is C + 1,
                            succcolbp(List,R,E1,L,C1).

succcolbp(List,[bk|R],E1,L,C):-nextbk(List,L,L/C,N),
                              suppr(s(_A,bp),N,Nn1),
                            suppr(s(_B,bp),Nn1,Nn2),
                            suppr(s(_C,bp),Nn2,Nn3),
                            suppr(s(_D,bp),Nn3,Nn4),
                            suppr(s(_E,bk),Nn4,Nn5),
                            suppr(s(_F,bk),Nn5,Nn6),
                            suppr(s(_G,bk),Nn6,Nn7),
                            suppr(s(_H,bk),Nn7,Nn),
                              Nn \== [],!,
                              conc([[L/C,Nn]],E,E1),
                              C1 is C + 1,
                              succcolbp(List,R,E,L,C1).

succcolbp(List,[bk|R],E1,L,C):-nextbk(List,L,L/C,N),
                              suppr(s(_A,bp),N,Nn1),
                            suppr(s(_B,bp),Nn1,Nn2),
                            suppr(s(_C,bp),Nn2,Nn3),
                            suppr(s(_D,bp),Nn3,Nn4),
                            suppr(s(_E,bk),Nn4,Nn5),
                            suppr(s(_F,bk),Nn5,Nn6),
                            suppr(s(_G,bk),Nn6,Nn7),
                            suppr(s(_H,bk),Nn7,Nn),
                              Nn == [],!, 
                              C1 is C + 1,
                              succcolbp(List,R,E,L,C1).
succcolbp(List,[_|R],E,L,C):- C1 is C + 1,
                            succcolbp(List,R,E,L,C1),!.
%%%%%%%%%%%%%%%%%%%%%move%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%entrer coordonnÃ©e d promier et 3eme prog gener auto de la 2eme


eatwp([X|R],L/C,L2/C2,[X|E]):-L\==1,L1 is L - 1, L3 is L2 - 1,eatwp(R,L1/C,L3/C2,E).
eatwp([X,Y,Z|R],L1/C1,L2/C2,[X1,Y2,Z2|R]):-L1 ==1,L99 is L1 + 2, L2 == L99,
                                        K is C2 - C1,
                                        K == 2 ,
                                        C3 is C1 + 1,
                                        getelement(X,C1,wp),
                                        getelement(Y,C3,Black),
                                        getelement(Z,C2,em),
                                        member(Black,[bp,bk]),
                                        remplace(X,em,C1,X1),
                                        remplace(Y,em,C3,Y2),
                                        remplace(Z,wp,C2,Z2),!.

%eatwp([X|R],L/C,L2/C2,[X|E]):-L\==1,L1 is L - 1, L3 is L2 - 1,eatwp(R,L1/C,L3/C2,E).
eatwp([X,Y,Z|R],L1/C1,L2/C2,[X1,Y2,Z2|R]):-   L1 == 1,L99 is L1 + 2, L2 == L99,
                                              K is C1 - C2,% c1 - C2 not the same as the first
                                              K == 2 ,
                                              C3 is C1 - 1,
                                              getelement(X,C1,wp),
                                              getelement(Y,C3,Black),
                                              member(Black,[bp,bk]),
                                              getelement(Z,C2,em),
                                              remplace(X,em,C1,X1),
                                              remplace(Y,em,C3,Y2),
                                              remplace(Z,wp,C2,Z2),!.


eatbp([X|R],L/C,L2/C2,[X|E]):-    L\==3,
                                  L1 is L - 1, 
                                  L3 is L2 - 1,
                                  eatbp(R,L1/C,L3/C2,E),!.

eatbp([X,Y,Z|R],L1/C1,L2/C2,[X1,Y2,Z2|R]):-   L1 ==3,L99 is L1 - 2, L2 == L99,
                                              K is C2 - C1,
                                              K == 2 ,
                                              C3 is C1 + 1,
                                              getelement(X,C2,em),
                                              getelement(Y,C3,White),
                                              member(White,[wp,wk]),
                                              getelement(Z,C1,bp),
                                              remplace(X,bp,C2,X1), 
                                              remplace(Y,em,C3,Y2),
                                              remplace(Z,em,C1,Z2),!.

% L1 pos initi L2 pos distinqtion

 eatbp([X,Y,Z|R],L1/C1,L2/C2,[X1,Y2,Z2|R]):- L1 ==3,L99 is L1 - 2, L2 == L99,
                                             K is C1 - C2,
                                             K == 2 ,
                                             C3 is C1 - 1,
                                             getelement(X,C2,em),
                                             getelement(Y,C3,White),
                                             member(White,[wp,wk]),
                                             getelement(Z,C1,bp),
                                             remplace(X,bp,C2,X1), 
                                             remplace(Y,em,C3,Y2),
                                             remplace(Z,em,C1,Z2),!.


getelement([_|R],C,Y):-  C\==1, C1 is C - 1 ,getelement(R,C1,Y).
getelement([X|_],1,X).

%%%%%eatwking if L1 < l2 ra 7na habtin so like Wp sinon tal3in like bp
eatwk([X|R],L/C,L2/C2,[X|E]):-L@=<L2,L\==1,L1 is L - 1, L3 is L2 - 1,eatwk(R,L1/C,L3/C2,E),!.
eatwk([X|R],L/C,L2/C2,[X|E]):-L@>=L2,L\==3,L1 is L - 1, L3 is L2 - 1,eatwk(R,L1/C,L3/C2,E),!.

eatwk([X,Y,Z|R],L1/C1,_/C2,[X1,Y2,Z2|R]):-  L1 ==1,
                                            K is C2 - C1,
                                            K == 2 ,
                                            C3 is C1 + 1,
                                            getelement(X,C1,wk),
                                            getelement(Y,C3,Black),
                                            getelement(Z,C2,em),
                                            member(Black,[bp,bk]),
                                            remplace(X,em,C1,X1),
                                            remplace(Y,em,C3,Y2),
                                            remplace(Z,wk,C2,Z2),!.

eatwk([X,Y,Z|R],L1/C1,_/C2,[X1,Y2,Z2|R]):-  L1 ==1,
                                            K is C1 - C2,
                                            K == 2 ,
                                            C3 is C1 - 1,
                                            getelement(X,C1,wk),
                                            getelement(Y,C3,Black),
                                            getelement(Z,C2,em),
                                            member(Black,[bp,bk]),
                                            remplace(X,em,C1,X1),
                                            remplace(Y,em,C3,Y2),
                                            remplace(Z,wk,C2,Z2),!.

eatwk([X,Y,Z|R],L1/C1,_/C2,[X1,Y2,Z2|R]):- L1 ==3,
                                            K is C2 - C1,
                                            K == 2 ,
                                            C3 is C1 + 1,
                                            getelement(X,C2,em),
                                            getelement(Y,C3,Black),
                                            getelement(Z,C1,wk),
                                            member(Black,[bp,bk]),
                                            remplace(X,wk,C2,X1),
                                            remplace(Y,em,C3,Y2),
                                            remplace(Z,em,C1,Z2),!.

eatwk([X,Y,Z|R],L1/C1,_/C2,[X1,Y2,Z2|R]):- L1 ==3,
                                            K is C1 - C2,% c1 - C2 not the same as the first
                                            K == 2 ,
                                            C3 is C1 - 1,
                                            getelement(X,C2,em),
                                            getelement(Y,C3,Black),
                                            getelement(Z,C1,wk),
                                            member(Black,[bp,bk]),
                                            remplace(X,wk,C2,X1),
                                            remplace(Y,em,C3,Y2),
                                            remplace(Z,em,C1,Z2),!.

%lets now fix the bk its the same thing like the white king there is no deffernce exepte we chqnge the piece
eatbk([X|R],L/C,L2/C2,[X|E]):-L@=<L2,L\==1,L1 is L - 1, L3 is L2 - 1,eatbk(R,L1/C,L3/C2,E),!.
eatbk([X|R],L/C,L2/C2,[X|E]):-L@>=L2,L\==3,L1 is L - 1, L3 is L2 - 1,eatbk(R,L1/C,L3/C2,E),!.

eatbk([X,Y,Z|R],L1/C1,_/C2,[X1,Y2,Z2|R]):-L1 ==1,
                                           K is C2 - C1,
                                           K == 2 ,
                                           C3 is C1 + 1,
                                           getelement(X,C1,bk),
                                           getelement(Y,C3,White),
                                           getelement(Z,C2,em),
                                           member(White,[wp,wk]),
                                           remplace(X,em,C1,X1),
                                           remplace(Y,em,C3,Y2),
                                           remplace(Z,bk,C2,Z2),!.

eatbk([X,Y,Z|R],L1/C1,_/C2,[X1,Y2,Z2|R]):-L1 ==1,
                                        K is C1 - C2,% c1 - C2 not the same as the first
                                        K == 2 ,
                                        C3 is C1 - 1,
                                        getelement(X,C1,bk),
                                        getelement(Y,C3,White),
                                        getelement(Z,C2,em),
                                        member(White,[wp,wk]),
                            
                            remplace(X,em,C1,X1),
                            remplace(Y,em,C3,Y2),
                            remplace(Z,bk,C2,Z2),!.

eatbk([X,Y,Z|R],L1/C1,_/C2,[X1,Y2,Z2|R]):-L1 ==3,
                                        K is C2 - C1,
                                        K == 2 ,
                                        C3 is C1 + 1,
                                        getelement(X,C2,em),
                                        getelement(Y,C3,White),
                                        getelement(Z,C1,bk),
                                        member(White,[wp,wk]),
                            remplace(X,bk,C2,X1),
                            remplace(Y,em,C3,Y2),
                            remplace(Z,em,C1,Z2),!.

eatbk([X,Y,Z|R],L1/C1,_/C2,[X1,Y2,Z2|R]):-L1 ==3,
                                        K is C1 - C2,
                                        K == 2 ,
                                        C3 is C1 - 1,
                                        getelement(X,C2,em),
                                        getelement(Y,C3,White),%C3 is the emplqcement of the white or the black piece to eat becareful  
                                        getelement(Z,C1,bk),
                                        member(White,[wp,wk]),
                            remplace(X,bk,C2,X1),
                            remplace(Y,em,C3,Y2),
                            remplace(Z,em,C1,Z2),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% getEl permet d'extraire le caractère A qui se trouve les coordonnées L, C
getEl([X|R],L,C,A):- L\==1,
                     L1 is L - 1,
                     getEl(R,L1,C,A).


getEl([X|R],L,C,A):- L==1,  getelement(X,C,A).

% getcor demande à l'utilisateur d'entrer deux coordonnées (L,C) pion que vous vous déplacez, (L2,C2) ces nouveaux coordonnées 
getcor(L,C,L2,C2):-
  write(' Write L and C'),
  nl,
  read(L), read(C),
  write(' Write L2 and C2'),
  nl,
 read(L2), read(C2).

% move permet de décider si la pièce que vous avez choisi  est un king ou une pièce afin de décider quel mouvement il pourra faire
move(w,R,L,C,L2,C2,R1):- (( getEl(R,L,C,wp), domove(w,piece,R,L,C,L2,C2,R1));
                        (getEl(R,L,C,wk), domove(w,king,R,L,C,L2,C2,R1))).

move(b,R,L,C,L2,C2,R1):-(( getEl(R,L,C,bp), domove(b,piece,R,L,C,L2,C2,R1));
                         (getEl(R,L,C,bk),  domove(b,king,R,L,C,L2,C2,R1))).


% Quand le type de la piece est choisi il opte pour la fonction adequate
domove(w,piece,R,L,C,L2,C2,R1):- readpw(R,L,C,L2,C2,R1).
domove(w,king,R,L,C,L2,C2,R1):-  readkw(R,L,C,L2,C2,R1).
domove(b,piece,R,L,C,L2,C2,R1):- readpb(R,L,C,L2,C2,R1).
domove(b,king,R,L,C,L2,C2,R1):-  readkb(R,L,C,L2,C2,R1).



% Permet de tester les mouvements possible d'un king noir
readkb(R,L,C,L2,C2,R1) :-
(T is L+1; T is L-1),  (Tt is C+1; Tt is C-1),
 L2==T,
 C2== Tt,
 movebk(R,L/C,L2/C2,R1).

% permet de tester les mouvements possible d'une piece noire
readpb(R,L,C,L2,C2,R1) :-
 T is L-1,  (Tt is C+1; Tt is C-1),
 L2==T,
 C2== Tt,
 movebp(R,L/C,L2/C2,R1).

% Permet de tester les mouvements possible d'un king blanc
readkw(R,L,C,L2,C2,R1) :-
(T is L+1; T is L-1),  (Tt is C+1; Tt is C-1),
 L2==T,
 C2== Tt,
 movewk(R,L/C,L2/C2,R1).
 
 % permet de tester les mouvements possible d'une piece blanche

readpw(R,L,C,L2,C2,R1) :-

 T is L+1,  (Tt is C+1; Tt is C-1),
 L2==T,
 C2== Tt,
 movewp(R,L/C,L2/C2,R1).

% Permet de faire le mouvement d'une pièce noire en échangeant les emplacements

movebp([X|R],L/C,L2/C2,[X|E]):-  L\==2,
                                 L1 is L - 1,
                                 L3 is L2 - 1,
                                 movebp(R,L1/C,L3/C2,E).


movebp([Y,X|R],L/C,L2/C2,[Y2,X1|R]):- L==2,
                                      getelement(Y,C2,em),
                                      getelement(X,C,bp),
                                      remplace(X,em,C,X1),
                                      remplace(Y,bp,C2,Y2).
% Permet de faire le mouvement d'un king noire en échangeant les emplacements                           
movebk([X|R],L/C,L2/C2,[X|E]):-  L\==2,
                                 L1 is L - 1,
                                 L3 is L2 - 1,
                                movebk(R,L1/C,L3/C2,E),!.


movebk([Y,X|R],L/C,L2/C2,[Y2,X1|R]):- L==2, L>L2,
                                      getelement(Y,C2,em),
                                      getelement(X,C,bk),
                                      remplace(X,em,C,X1),
                                      remplace(Y,bk,C2,Y2),!.

movebk([X,Y,Z|R],L/C,L2/C2,[X,Y1,Z1|R]):- L==2 , L<L2,
                                   getelement(Y,C,bk),
                                   getelement(Z,C2,em),
                                    remplace(Z,bk,C2,Z1),
                                    remplace(Y,em,C,Y1),!.

movebk([X,Y|R],L/C,L2/C2,[X1,Y2|R]):- L==1,  L2>L,
                                      getelement(Y,C2,em),
                                      getelement(X,C,bk),
                                      remplace(X,em,C,X1),
                                      remplace(Y,bk,C2,Y2).
                                     
movebk([X|R],L/C,L2/C2,[X|E]):- L\==1, 
                                L1 is L - 1,
                                L3 is L2 - 1,
                                movebk(R,L1/C,L3/C2,E),!.



% Permet de faire le mouvement d'une pièce blanche en échangeant les emplacements  
movewp([X|R],L/C,L2/C2,[X|E]):- L\==1,
                                L1 is L - 1,
                                L3 is L2 - 1,
                                movewp(R,L1/C,L3/C2,E).


movewp([X,Y|R],L/C,_/C2,[X1,Y2|R]):-  L==1,  
                                      getelement(Y,C2,em),
                                      getelement(X,C,wp),
                                      remplace(X,em,C,X1),
                                      remplace(Y,wp,C2,Y2).

% Permet de faire le mouvement d'un king blanc en échangeant les emplacements
movewk([X,Y|R],L/C,L2/C2,[X1,Y2|R]):- L==1,  L2>L,
                                      getelement(Y,C2,em),
                                      getelement(X,C,wk),
                                      remplace(X,em,C,X1),
                                      remplace(Y,wk,C2,Y2).
                                     
movewk([X|R],L/C,L2/C2,[X|E]):- L\==1, 
                                L1 is L - 1,
                                L3 is L2 - 1,
                                movewk(R,L1/C,L3/C2,E),!.



movewk([Z,X|R],L/C,L2/C2,[Z,X|E]):- L\==2, 
                                    L1 is L - 1,
                                    L3 is L2 - 1,
                                    movewk(R,L1/C,L3/C2,E),!.


movewk([Y,X|R],L/C,L2/C2,[Y2,X1|R]):- L==2, L>L2,
                                      getelement(Y,C2,em),
                                      getelement(X,C,wk),
                                      remplace(X,em,C,X1),
                                      remplace(Y,wk,C2,Y2),!.

movewk([X,Y,Z|R],L/C,L2/C2,[X,Y1,Z1|R]):- L==2 , L<L2,
                                   getelement(Y,C,wk),
                                   getelement(Z,C2,em),
                                    remplace(Z,wk,C2,Z1),
                                    remplace(Y,em,C,Y1),!.   

% Il permet de remplacer un element par un autre donée
remplace([_|R],A,C,[A|R]):-    C==1. 
remplace([X|R],A,C,[X|Rest]):- C\==1, 
                               C1 is C-1,
                               remplace(R,A,C1,Rest).



% Transforme une piece si elle dame.




% Transforme une piece si elle dame.



/*
1 [wp, +, wp, +, wp, +, wp, +],
2 [+ ,wp ,+ ,wp ,+ ,wp ,+ ,wp],
3 [wp ,+ ,wp ,+ ,wp ,+ ,wp ,+],
4 [+ ,em ,+ ,em ,+ ,em ,+ ,em],
5 [em ,+ ,em ,+ ,em ,+ ,em ,+],
6 [+ ,bp ,+ ,bp ,+ ,bp ,+ ,bp], 
7 [bp ,+ ,bp ,+ ,bp ,+ ,bp ,+],
8 [+ ,bp ,+ ,bp ,+ ,bp ,+ ,bp]]




[[em,+,em,+,em,+,em,+],[+,em,+,em,+,em,+,em],[em,+ ,wp,+ ,em,+ ,em,+ ],[+ ,em,+ ,em,+ ,em,+ ,em],[em,+ ,em,+ ,em,+ ,em,+ ],[+,em,+,em,+,em,+,em],[em,+,em,+,em,+,bp,+],[+,em,+,em,+,em,+,em]]

5/5  3/3
[wp, +, wp, +, wp, +, wp, +], 
[+, wp, +, wp, +, wp, +, wp], 
[wp, +, wp, +, wp, +, wp, +], 
[+, em, +, em, +, em, +, em], [em, +, em, +, em, +, em, +], 
[+, bp, +, bp, +, bp, +, bp], 
[bp, +, bp, +, bp, +, bp, +], 
[+, bp, +, bp, +, bp, +, bp]

[wp,+,wp,+,wp,+,wp,+],
[+,wp,+,wp,+,wp,+,wp],
[wp,+ ,em,+ ,wp,+ ,wp,+ ],
[+ ,em,+ ,wp,+ ,em,+ ,em],
[em,+ ,em,+ ,bk,+ ,em,+ ],
[+,bp,+,bp,+,bp,+,bp],
[bp,+,bp,+,bp,+,bp,+],[+,bp,+,bp,+,bp,+,bp]

*/
/*
[wp, +, wp, +, wp, +, wp, +],
[+, wp, +, wp, +, wp, +, wp],
[wp, +, em, +, wp, +, wp, +], 
[+, wp, +, em, +, em, +, em],
[em, +, em, +, em, +, em, +], 
[+, bp, +, bp, +, bp, +, bp],
[bp, +, bp, +, bp, +, bp, +],
[+, bp, +, bp, +, bp, +, bp],


[wp,+,wp,+,wp,+,wp,+],
[+,wp,+,wp,+,wp,+,wp],
[wp,+ ,wp,+ ,wp,+ ,wp,+],
[+,em,+ ,em,+ ,em,+ ,em],
[em,+,em,+ ,em,+ ,em,+],
[+,bp,+,bp,+,bp,+,bp],
[bp,+,bp,+,bp,+,bp,+],
[+,bp,+,bp,+,bp,+,bp] 


[[+, bk, +, em, +, em, +, em], [em, +, em, +, em, +, em, +], [+, em, +, em, +, em, +, em], [em, +, em, +, em, +, em, +], [+, em, +, em, +, em, +, em], [em, +, em, +, em, +, em, +], [+, em, +, em, +, em, +, em], [em, +, em, +, em, +, em, +]]


*/