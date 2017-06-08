:- set_prolog_flag(toplevel_print_options,[quoted(true), portray(true)]).



%state(Player,List),
% max_to_move(State):vrai si le joueur concerné par l'état State veut maximiser
max_to_move(state(black,_)).
% min_to_move(State):vrai si le joueur concerné par l'état State veut minimiser
min_to_move(state(white, _)).

%terminal(Etat, Valeur)
/*
terminal(state(white, List), _) :- (not(thereisblack(List));(moves( state(white, List), PosList),PosList == [])), !.
terminal(state(black, List), _) :- (not(thereiswhite(List));(moves( state(black, List), PosList),PosList == [])), !.
*/

terminal(state(white, List), _) :- not(thereisblack(List)),!.
terminal(state(black, List), _) :- not(thereiswhite(List)),!.



thereisblack([X|_]):-(member(bp,X);member(bk,X)).
thereisblack([X|R]):-(not(member(bp,X));not(member(bk,X))),thereisblack(R).

thereiswhite([X|_]):-(member(wp,X);member(wk,X)).
thereiswhite([X|R]):-(not(member(wp,X));not(member(wk,X))),thereiswhite(R).


moves(State, NewStates) :- findall(NewState, legal_move(State, NewState), NewStates). 
% legal_move(State, NewState) : NewState est une etat successeur State.

legal_move(state(white, List), state(black, NList1)) :- listsuccwp(List,List,E,1),
                needtoeatw(List,E,_A/_B),
                member([L/C,_],E),
                % i need to test if L/C valid to eat twice
                member(L1, [1,2,3,4,5,6,7,8]), L\==L1,Diff is L- L1,(Diff == 2; Diff == -2),
                member(C1, [1,2,3,4,5,6,7,8]),C\==C1, Diff1 is C - C1 ,(Diff1 == 2; Diff1 == -2),
                findL(List,L,Line),
                findwp(Line,C,N),
                findL(List,L1,Ltarget),
                findwp(Ltarget,C1,Ntarget),
                Ntarget == em ,
                ((N == wp , eatwp(List,L/C,L1/C1,NewList));(N == wk , eatwk(List,L/C,L1/C1,NewList) )),
                checkking(NewList,NewList1),
                listsuccwp(NewList1,NewList1,NewE,1),              
                needtoeatw(NewList1,NewE,L1/C1),!,
                %readtoeattwicew(L1/C1,L4/C4),
                member(L2, [1,2,3,4,5,6,7,8]), L1\==L2,Diff3 is L1- L2,(Diff3 == 2; Diff3 == -2),
                member(C2, [1,2,3,4,5,6,7,8]), C1\==C2,Diff11 is C1 - C2 ,(Diff11 == 2; Diff11 == -2),
                findL(NewList1,L2,Ltarget1),
                findwp(Ltarget1,C2,Ntarget1),
                Ntarget1 == em, 
                ((N == wp , eatwp(NewList1,L1/C1,L2/C2,NList) );(N == wk , eatwk(NewList1,L1/C1,L2/C2,NList) )),
                checkking(NList,NList1).
               

legal_move(state(white, List), state(black, NewList1)) :- listsuccwp(List,List,E,1),
                needtoeatw(List,E,_A/_B),!,
                member([L/C,_],E),
                member(L1, [1,2,3,4,5,6,7,8]), L\==L1,Diff is L- L1,(Diff == 2; Diff == -2),
                member(C1, [1,2,3,4,5,6,7,8]),C\==C1, Diff1 is C - C1 ,(Diff1 == 2; Diff1 == -2),
                findL(List,L,Line),
                findwp(Line,C,N),
                findL(List,L1,Ltarget),
                findwp(Ltarget,C1,Ntarget),
                Ntarget == em ,
                ((N == wp , eatwp(List,L/C,L1/C1,NewList));(N == wk , eatwk(List,L/C,L1/C1,NewList) )),
                checkking(NewList,NewList1).
             


 legal_move(state(white, List), state(black, NewList1)) :- 
                                 member(L, [1,2,3,4,5,6,7,8]),
                                 member(C, [1,2,3,4,5,6,7,8]),
                                member(L1, [1,2,3,4,5,6,7,8]), L\==L1,Diff is L- L1,(Diff == 1; Diff == -1),
                                member(C1, [1,2,3,4,5,6,7,8]),C\==C1, Diff1 is C - C1 ,(Diff1 == 1; Diff1 == -1),
                              % write('i move once'),nl,
                                move(w,List,L,C,L1,C1,NewList),


                                checkking(NewList,NewList1). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ([[wp, +, em, +, bk, +, e...|...]], 1/5, 3/3
 
legal_move(state(black, List), state(white, NList1)) :- listsuccbp(List,List,E,1),
                %write('stateone :'),write(E),nl,write(List),nl,
                needtoeatb(List,E,_A/_B),
                member([L/C,_],E),
                member(L1, [1,2,3,4,5,6,7,8]), L\==L1,Diff is L- L1,(Diff == 2; Diff == -2),
                member(C1, [1,2,3,4,5,6,7,8]),C\==C1, Diff1 is C - C1 ,(Diff1 == 2; Diff1 == -2),
                findL(List,L,Line),
                findbp(Line,C,N),
                findL(List,L1,Ltarget),
                findbp(Ltarget,C1,Ntarget),
                Ntarget == em ,
                ((N == bp , eatbp(List,L/C,L1/C1,NewList));(N == bk , eatbk(List,L/C,L1/C1,NewList) )),
                checkking(NewList,NewList1),
                listsuccbp(NewList1,NewList1,NewE,1),
                              %%  write('stateone-2 :'),write(E),nl,write(List),nl,
              
                needtoeatb(NewList1,NewE,L1/C1),!,
                member(L2, [1,2,3,4,5,6,7,8]), L1\==L2,Diff3 is L1- L2,(Diff3 == 2; Diff3 == -2),
                member(C2, [1,2,3,4,5,6,7,8]), C1\==C2,Diff11 is C1 - C2 ,(Diff11 == 2; Diff11 == -2),
                findL(NewList1,L2,Ltarget1),
                findbp(Ltarget1,C2,Ntarget1),
                Ntarget1 == em, 
                ((N == bp , eatbp(NewList1,L1/C1,L2/C2,NList) );(N == bk , eatbk(NewList1,L1/C1,L2/C2,NList) )),
                checkking(NList,NList1).
                
                

legal_move(state(black, List), state(white, NewList1)) :- listsuccbp(List,List,E,1),
               %% write('statetwo :'),write(E),nl,write(List),nl,

                needtoeatb(List,E,_A/_B),!,
                member([L/C,_],E),
                member(L1, [1,2,3,4,5,6,7,8]), L\==L1,Diff is L- L1,(Diff == 2; Diff == -2),
                member(C1, [1,2,3,4,5,6,7,8]),C\==C1, Diff1 is C - C1 ,(Diff1 == 2; Diff1 == -2),
                findL(List,L,Line),
                findbp(Line,C,N),
                findL(List,L1,Ltarget),
                findbp(Ltarget,C1,Ntarget),
                Ntarget == em ,
                ((N == bp , eatbp(List,L/C,L1/C1,NewList));(N == bk , eatbk(List,L/C,L1/C1,NewList) )),
                checkking(NewList,NewList1).
              

legal_move(state(black, List), state(white, NewList1)) :- 
                                 member(L, [1,2,3,4,5,6,7,8]),
                                 member(C, [1,2,3,4,5,6,7,8]),
                                member(L1, [1,2,3,4,5,6,7,8]), L\==L1,Diff is L- L1,(Diff == 1; Diff == -1),
                                member(C1, [1,2,3,4,5,6,7,8]),C\==C1, Diff1 is C - C1 ,(Diff1 == 1; Diff1 == -1),
                               
                                move(b,List,L,C,L1,C1,NewList),
                                checkking(NewList,NewList1). 


%statetoliste(State(_,List),List).
listt(state(_,Lis),Lis):-!.




alphabeta(State, _, _, State, Val,_) :-
  (terminal(State, Val);(moves(State, NewStates),NewStates=[] )),!,
          %listt(State,Lis),
          totaleliste( State, Val).

alphabeta( Pos, Alpha, Beta, GoodPos, Val, Depth) :-
           Depth > 0, moves( Pos, PosList), !,
           boundedbest( PosList, Alpha, Beta, GoodPos, Val, Depth);
           totaleliste( Pos, Val).        % Static value of Pos

boundedbest( [Pos|PosList], Alpha, Beta, GoodPos, GoodVal, Depth) :-
             Depth1 is Depth - 1,
             alphabeta( Pos, Alpha, Beta, _, Val, Depth1),
             goodenough( PosList, Alpha, Beta, Pos, Val, GoodPos, GoodVal, Depth).
%boundedbest( [], Alpha, Beta, GoodPos, GoodVal, Depth)

goodenough( [], _, _, Pos, Val, Pos, Val, _) :- !.     

goodenough( _, Alpha, Beta, Pos, Val, Pos, Val, _) :-
            min_to_move( Pos), Val > Beta, !;       
            max_to_move( Pos), Val < Alpha, !.      

goodenough( PosList, Alpha, Beta, Pos, Val, GoodPos, GoodVal, Depth) :-
            newbounds( Alpha, Beta, Pos, Val, NewAlpha, NewBeta),        
            boundedbest( PosList, NewAlpha, NewBeta, Pos1, Val1, Depth),
            betterof( Pos, Val, Pos1, Val1, GoodPos, GoodVal).

newbounds( Alpha, Beta, Pos, Val, Val, Beta) :-

           min_to_move( Pos), Val > Alpha, !.        

newbounds( Alpha, Beta, Pos, Val, Alpha, Val) :-

           max_to_move( Pos), Val < Beta, !.        

newbounds( Alpha, Beta, _, _, Alpha, Beta).         

betterof( Pos, Val, _, Val1, Pos, Val) :- 

          min_to_move( Pos), Val > Val1, !;
          max_to_move( Pos), Val < Val1, !.

betterof( _, _, Pos1, Val1, Pos1, Val1):-!.            
betterof( Pos, Val,_, _, Pos, Val).



% Heuristique  
occurences(_,0,[]).
occurences(X,N,[X|Q]):- occurences(X,Nr,Q), N is Nr+1.
occurences(X,N,[T|Q]):- occurences(X,N,Q), X\==T.

totlignew(R,N,Val):- occurences(wp,N,R), occurences(wk,N1,R),
     Val is 2*N1.

totlignew([X|R],_,_):- not(member(X,[wp,wk])),
                        totlignew(R,_,_).


                         

totligneb(R,N,Val):- occurences(bp,N,R), occurences(bk,N1,R),
     Val is 2*N1.

totligneb([X|R],_,_):- not(member(X,[bp,bk])),
                        totligneb(R,_,_).


totaleliste(state(_,[A,B,C,D,E,F,G,I]),Val):-   
                               totlignew(A,V1,V111),
                               totlignew(B,V2,V222),
                               totlignew(C,V3,V333),
                               totlignew(D,V4,V444),
                               totlignew(E,V5,V555),
                               totlignew(F,V6,V666),
                               totlignew(G,V7,V777),
                               totlignew(I,V8,V888),
                               totligneb(A,V11,V1111),
                               totligneb(B,V22,V2222),
                               totligneb(C,V33,V3333),
                               totligneb(D,V44,V4444),
                               totligneb(E,V55,V5555),
                               totligneb(F,V66,V6666),
                               totligneb(G,V77,V7777),
                               totligneb(I,V88,V8888),

                               bonusb([A,B,C,D,E,F,G,I],Bonusb),
                               bonusw([A,B,C,D,E,F,G,I],Bonusw),

                               Val1 is Bonusb +(V88*0.1)+V88+V8888+(V77*0.2)+V77+V7777+(V66*0.3)+V66+V6666+(V55*0.4)+V55+V5555+(V44*0.5)+V44+V4444+(V33*0.6)+V33+V3333+(V22*0.7)+V22+V2222+(V11*0.8)+V11+V1111,
                               Val2 is Bonusw +(V1*0.1)+V1+V111+(V2*0.2)+V2+V222+(V3*0.3)+V3+V333+(V4*0.4)+V4+V444+(V5*0.5)+V5+V555+(V6*0.6)+V6+V666+(V7*0.7)+V7+V777+(V8*0.8)+V8+V888,
                                Val is Val1 - Val2,!.





bonusb([A,B,C,D,E,F,G,I],Bonus):- lignepoid(A,V1),
                  lignepoid(B,V2),
                  lignepoid(C,V3),
                  lignepoid(D,V4),
                  lignepoid(E,V5),
                  lignepoid(F,V6),
                  lignepoid(G,V7),
                  lignepoid(I,V8),
                  Bonus is V1 + V2 + V3 +V4 +V5 +V6 +V7 +V8 .


lignepoid([+,bp,+,bp,+,bp,+,_],V):- V is 0.03,!.
lignepoid([_,+,bp,+,bp,+,bp,+],V):- V is 0.03,!.
lignepoid([_,+,_,+,bp,+,bp,+],V):- V is 0.02,!.
lignepoid([_,+,bp,+,_,+,bp,+],V):- V is 0.02,!.
lignepoid([_,+,bp,+,bp,+,_,+],V):- V is 0.02,!.
lignepoid([_,+,_,+,_,+,bp,+],V):- V is 0.01,!.
lignepoid([_,+,_,+,bp,+,_,+],V):- V is 0.01,!.
lignepoid([_,+,bp,+,_,+,_,+],V):- V is 0.01,!.

lignepoid([+,_,+,bp,+,bp,+,_],V):- V is 0.02,!.
lignepoid([+,bp,+,_,+,bp,+,_],V):- V is 0.02,!.
lignepoid([+,bp,+,bp,+,_,+,_],V):- V is 0.02,!.
lignepoid([+,_,+,_,+,bp,+,_],V):- V is 0.01,!.
lignepoid([+,_,+,bp,+,_,+,_],V):- V is 0.01,!.
lignepoid([+,bp,+,_,+,_,+,_],V):- V is 0.01,!.
lignepoid([_,_,_,_,_,_,_,_],0).



bonusw([A,B,C,D,E,F,G,I],Bonus):-lignepoidw(A,V1),
                  lignepoidw(B,V2),
                  lignepoidw(C,V3),
                  lignepoidw(D,V4),
                  lignepoidw(E,V5),
                  lignepoidw(F,V6),
                  lignepoidw(G,V7),
                  lignepoidw(I,V8),
                  Bonus is V1 + V2 + V3 +V4 +V5 +V6 +V7 +V8 .

lignepoidw([+,wp,+,wp,+,wp,+,_],V):- V is 0.03,!.
lignepoidw([_,+,wp,+,wp,+,wp,+],V):- V is 0.03,!.
lignepoidw([_,+,_,+,wp,+,wp,+],V):- V is 0.02,!.
lignepoidw([_,+,wp,+,_,+,wp,+],V):- V is 0.02,!.
lignepoidw([_,+,wp,+,wp,+,_,+],V):- V is 0.02,!.
lignepoidw([_,+,_,+,_,+,wp,+],V):- V is 0.01,!.
lignepoidw([_,+,_,+,wp,+,_,+],V):- V is 0.01,!.
lignepoidw([_,+,wp,+,_,+,_,+],V):- V is 0.01,!.

lignepoidw([+,_,+,wp,+,wp,+,_],V):- V is 0.02,!.
lignepoidw([+,wp,+,_,+,wp,+,_],V):- V is 0.02,!.
lignepoidw([+,wp,+,wp,+,_,+,_],V):- V is 0.02,!.
lignepoidw([+,_,+,_,+,wp,+,_],V):- V is 0.01,!.
lignepoidw([+,_,+,wp,+,_,+,_],V):- V is 0.01,!.
lignepoidw([+,wp,+,_,+,_,+,_],V):- V is 0.01,!.
lignepoidw([_,_,_,_,_,_,_,_],0).
% alphabeta(state(black,[[em,+,em,+,em,+,em,+],[+,em,+,em,+,em,+,em],[em,+,em,+,em,+,em,+],[+,em,+,em,+,em,+,em],[em,+,em,+,em,+,em,+],[+,em,+,em,+,em,+,em],[em,+,em,+,em,+,em,+],[+,em,+,em,+,em,+,em]]),-100,100,S,V,3).