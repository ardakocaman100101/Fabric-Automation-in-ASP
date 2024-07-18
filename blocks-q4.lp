%%%%%%%%%%%%%%%%%%% 
% File: blocks.lp: Blocks World 
%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% sort and object declaration 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% every block is a location 
location(B) :- block(B). 

% the table is a location 
location(table). 

%%%%%%%%%%%%%%%%%%%%%%%%%% 
% state description 
%%%%%%%%%%%%%%%%%%%%%%%%%% 

% two blocks can't be on the same block at the same time 
:- 2{on(BB,B,T)}, block(B), T = 0..z. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% effect and preconditions of action 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% effect of moving a block 
on(B,L,T+1) :- move(B,L,T). 

% concurrent actions are limited by num of grippers 
:- not {move(BB,LL,T)} grippers, T = 0..z-1. 

% a block can be moved only when it is clear 
:- move(B,L,T), on(B1,B,T). 

% a block can't be moved onto a block that is being moved also 
:- move(B,B1,T), move(B1,L,T). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% domain independent axioms 
%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% fluents are initially exogenous 
1{on(B,LL,0):location(LL)}1 :- block(B). 

% uniqueness and existence of value constraints 
:- not 1{on(B,LL,T)}1, block(B), T=1..z. 

% actions are exogenous 
{move(B,L,T)} :- block(B), location(L), T = 0..z-1. 

% commonsense law of inertia 
{on(B,L,T+1)} :- on(B,L,T), T < z. 

% Modifying blocks.lp to generate only serializable plans. 
:- move(PP,GG,T), on(P,GG,T), move(P,Q,T), block(P), T=1..z-1. 

% Find a minimal length plan. 
#minimize{1,P,Q,T:move(P,Q,T)}. 
#show move/3.