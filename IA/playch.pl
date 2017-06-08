  %:- set_prolog_flag(answer_write_options,[quoted(true), portray(true), max_depth(0), spacing(next_argument)]).



% move permet de décider si la pièce que vous avez choisi  est un king ou une pièce afin de décider quel mouvement il pourra faire



doeatw(List,L/C,L1/C1,NList):-  listsuccwp(List,List,E,1),
                needtoeatw(List,E,_A/_B),
                %readToeatoncew(L/C,L1/C1),
                findL(List,L,Line),
                findwp(Line,C,N),
                ((N == wp , eatwp(List,L/C,L1/C1,NewList) );(N == wk , eatwk(List,L/C,L1/C1,NewList) )),
                listsuccwp(NewList,NewList,NewE,1),
                needtoeatw(NewList,NewE,L1/C1),!,
                readtoeattwicew(L1/C1,L4/C4),
                findL(NewList,L1,Line1),
                findwp(Line1,C1,N4),write(N4),nl,
               
                ((N4 == wp , eatwp(NewList,L1/C1,L4/C4,NList) );(N4 == wk , eatwk(NewList,L1/C1,L4/C4,NList) )).

doeatw(List,L/C,L1/C1,NewList):-  listsuccwp(List,List,E,1),
                needtoeatw(List,E,L3/C3),
                %readToeatoncew(L/C,L1/C1),
                findL(List,L,Line),
                findwp(Line,C,N),
                ((N == wp , eatwp(List,L/C,L1/C1,NewList) );(N == wk , eatwk(List,L/C,L1/C1,NewList) )),!.

doeatw(List,L/C,L1/C1,NewList):-%readtomovew(L/C,L1/C1), 
                                move(w,List,L,C,L1,C1,NewList).

/*
testeatagainw(NewList,L1/C1):-
                listsuccwp(NewList,NewList,NewE,1),
                needtoeatw(NewList,NewE,L1/C1),
                readtoeattwicew(L1/C1,L4/C4),
                findL(NewList,L1,Line1),
                findwp(Line1,C1,N4),write(N4),nl,
                ((N4 == wp , eatwp(NewList,L1/C1,L4/C4,NList) );(N4 == wk , eatwk(NewList,L1/C1,L4/C4,NList) )).
*/





needtoeatw(List,[X|_],L/C):- somethingtoeat(List,X,L/C),!.
needtoeatw(List,[_|R],L/C) :- needtoeatw(List,R,L/C).

somethingtoeat(List,[L/C,Y],L/C):-(member(s(L1/C1,bp),Y);member(s(L1/C1,bk),Y)),
                                    ((L < L1 ,C < C1 , L3 is L1 + 1, C3 is C1 + 1);
                                    (L < L1 ,C > C1 , L3 is L1 + 1, C3 is C1 - 1);
                                    (L > L1 ,C < C1 , L3 is L1 - 1, C3 is C1 + 1);
                                    (L > L1 ,C > C1 , L3 is L1 - 1, C3 is C1 - 1)),
                                    findL(List,L3,Line),
                                    findwp(Line,C3,N),
                                    N == em.
% nothing tested yet


doeatb(List,L/C,L1/C1,NList):-  listsuccbp(List,List,E,1),
                      needtoeatb(List,E,_A/_B),
                      %readToeatonceb(L/C,L1/C1),
                      findL(List,L,Line),
                      findbp(Line,C,N),
                     ((N == bp , eatbp(List,L/C,L1/C1,NewList) );(N == bk , eatbk(List,L/C,L1/C1,NewList) )),
                     listsuccbp(NewList,NewList,NewE,1),
                     needtoeatb(NewList,NewE,L1/C1),
                     readtoeattwiceb(L1/C1,L4/C4),
                     findL(NewList,L1,Line1),
                     findbp(Line1,C1,N4),
                     ((N4 == bp , eatbp(NewList,L1/C1,L4/C4,NList) );(N4 == bk , eatbk(NewList,L1/C1,L4/C4,NList) )),write(' good move').

doeatb(List,L/C,L1/C1,NewList):-  listsuccbp(List,List,E,1),
                        needtoeatb(List,E,_A/_B),
                        %readToeatonceb(L/C,L1/C1),
                        findL(List,L,Line),
                        findbp(Line,C,N),
                        ((N == bp , eatbp(List,L/C,L1/C1,NewList) );(N == bk , eatbk(List,L/C,L1/C1,NewList) )).


doeatb(List,L/C,L1/C1,NewList):-%readtomoveb(L/C,L1/C1), 
                              move(b,List,L,C,L1,C1,NewList).



needtoeatb(List,[X|_],L/C):-somethingtoeatb(List,X,L/C),!.
needtoeatb(List,[_|R],L/C) :- needtoeatb(List,R,L/C).

somethingtoeatb(List,[L/C,Y],L/C):-(member(s(L1/C1,wp),Y);member(s(L1/C1,wk),Y)),
                                    ((L < L1 ,C < C1 , L3 is L1 + 1, C3 is C1 + 1);
                                    (L < L1 ,C > C1 , L3 is L1 + 1, C3 is C1 - 1);
                                    (L > L1 ,C < C1 , L3 is L1 - 1, C3 is C1 + 1);
                                    (L > L1 ,C > C1 , L3 is L1 - 1, C3 is C1 - 1)),
                                    findL(List,L3,Line),
                                    findbp(Line,C3,N),
                                    N == em.


readToeatoncew(L/C,L2/C2) :-
  write(' you need to eat first white '),
  write(' Write L and C'),
  nl,
  read(L), read(C),
  write(' Write L2 and C2'),
  nl,
 read(L2), read(C2).

readtoeattwicew(L/C,L2/C2) :-
  write(' you need to eat again white'),
  write(' Write L and C'),
  nl,
  read(L), read(C),
  write(' Write L2 and C2'),
  nl,
 read(L2), read(C2).

readtomovew(L/C,L2/C2) :-
  write(' you need to move white, make a good one !'),nl,
  write(' Write L and C'),
  nl,
  read(L), read(C),
  write(' Write L2 and C2'),
  nl,
 read(L2), read(C2).

readkb(L/C,L2/C2) :-
  write(' Write L and C'),
  nl,
  read(L), read(C),
  write(' Write L2 and C2'),
  nl,
 read(L2), read(C2).

readToeatonceb(L/C,L2/C2) :-
  write(' you need to eat first black '),
  nl,
  write(' black L and C'),
  nl,
  read(L), read(C),
  write(' black L2 and C2'),
  nl,
 read(L2), read(C2).

readtoeattwiceb(L/C,L2/C2) :-
  write(' you need to eat again black'),nl,
  write(' black L and C'),
  nl,
  read(L), read(C),
  write(' black L2 and C2'),
  nl,
 read(L2), read(C2).

readtomoveb(L/C,L2/C2) :-
  write(' you need to move, make a good one !'),
  write(' black L and C'),
  nl,
  read(L), read(C),
  write(' black L2 and C2'),
  nl,
 read(L2), read(C2).

findL([X|_],L,X):-L == 1.
findL([_|R],L,X):-L \== 1, L1 is L - 1,
                findL(R,L1,X).


doeatagain(List,L/C,L1/C1,NewList,X):-  listsuccwp(List,List,E,1),
                needtoeatw(List,E,_A/_B),
                %readToeatoncew(L/C,L1/C1),
                findL(List,L,Line),
                findwp(Line,C,N),
                ((N == wp , eatwp(List,L/C,L1/C1,NewList) );(N == wk , eatwk(List,L/C,L1/C1,NewList) )),
                listsuccwp(NewList,NewList,NewE,1),
                needtoeatw(NewList,NewE,L1/C1),!,
                X =1.
doeatagain(List,L/C,L1/C1,NewList,X):-  listsuccwp(List,List,E,1),
                needtoeatw(List,E,L3/C3),!,
                findL(List,L,Line),
                findwp(Line,C,N),
                ((N == wp , eatwp(List,L/C,L1/C1,NewList) );(N == wk , eatwk(List,L/C,L1/C1,NewList) )),
                X = 0.

doeatagain(List,L/C,L1/C1,NewList,X):-%readtomovew(L/C,L1/C1), 
                                move(w,List,L,C,L1,C1,NewList),
                                X=0.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                
findw(R,C):- member(C,[1,2,3,4,5,6,7,8]), getEl(R,8,C,wp),!.
findb(R,C):- member(C,[1,2,3,4,5,6,7,8]), getEl(R,1,C,bp),!.



%findking(R,E):- findw(R,C), lookkingw([X|R],1/C,[X|E]),!.
%findking(R,R).

lookkingw([X|R],L/C,[X|E]):-  L\==8,
                              L1 is L + 1,
                             lookkingw(R,L1/C,E).


lookkingw([X|R],L/C,[X|E]):-  L\==1,
                             L1 is L - 1,
                              lookkingw(R,L1/C,E).


lookkingw([Y|R],L/C,[Y2|R]):- L==1, remplace(Y,wk,C,Y2).

%�������������������������������������������
lookkingb([Y|R],L/C,[Y2|R]):- L==1, remplace(Y,bk,C,Y2).



findking(R,E):- findw(R,C), lookkingw([X|R],1/C,[X|E]),!.
findking(R,R).

findkings(R,E):- findb(R,C), lookkingb(R,1/C,E),!.
findkings(R,R).

checkking(R,E):-findking(R,E1),findkings(E1,E),!.