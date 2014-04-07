% file 'robot'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% object declaration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
step(0..maxstep).
astep(0..maxstep-1).
axis(1..6).
robot(1).
object(1).
% corresponds to directions (left, up, right, down)
direction(1..4).
location(1..36).
goal(1).

#domain step(ST).
#domain astep(T).
#domain robot(R).
#domain robot(R).
#domain object(OB).
#domain object(OB1).
#domain goal(G).
#domain direction(DIR).

% 2-dimensional maze
#domain axis(X).
#domain axis(Y).
#domain location(L).
#domain location(L1).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% state description
%%%%%%%%%%%%%%%%%%%%%%%%%%
% a function from position coordinates to location
on(L,X,Y).

% a function mapping from object and position to time
on(OB,X,Y,ST).

% a function mapping a robot's position to time
on(R,X,Y,ST).
on(G,X,Y,ST).

% function mapping object and robot to time
pickup(OB,R,ST).

% a function of robot having an object
% has(OB,R,ST).

% uniqueness constraint for all locations, an object may only be on one location at a time
:- not 1{on(OB,L,ST): location(L)}1.
% uniqueness constraint for all locations, a robot may only be on one location at a time
:- not 1{on(R,L,ST): location(L)}1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% effect and preconditions of action
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% effect of picking up an object when the robot doesn't have object is that it then has it
has(OB,R,T+1) :- pickup(OB,R,T), not has(OB,R,T).

% robot may only pickup an object or move at any time
:- not {move(R,D,T): robot(R): direction(D) }.

% an object can be moved only when the robot has it
:- move(OB,D,T), has(OB,R,T).

% effects of robot movement
on(R,X-1,  Y,T+1) :- move(R,1,T).
on(R,  X,Y+1,T+1) :- move(R,2,T).
on(R,X+1,  Y,T+1) :- move(R,3,T).
on(R,  X,Y-1,T+1) :- move(R,4,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% domain independent axioms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fluents are initially exogenous
{on(R,X,Y,0)}.

% actions are exogenous
{move(R,D,T): robot(R): direction(D)}.

% commonsense law of inertia
{on(O,X,Y,T+1)} :- on(O,X,Y,T).
{on(R,X,Y,T+1)} :- on(R,X,Y,T).
{has(OB,R,T+1)} :- has(OB,R,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% planning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% walls: 
%:- on(R,1,1,T), move(R,2,T).
%:- on(R,2,1,T), move(R,2,T).
%:- on(R,4,1,T), move(R,2,T).
%:- on(R,4,1,T), move(R,3,T).
%:- on(R,5,1,T), move(R,1,T).
%:- on(R,5,1,T), move(R,2,T).
%
%:- on(R,1,2,T), move(R,4,T).
%:- on(R,2,2,T), move(R,3,T).
%:- on(R,2,2,T), move(R,4,T).
%:- on(R,3,2,T), move(R,1,T).
%:- on(R,4,2,T), move(R,2,T).
%:- on(R,4,2,T), move(R,4,T).
%:- on(R,5,2,T), move(R,2,T).
%:- on(R,5,2,T), move(R,4,T).
%
%:- on(R,1,3,T), move(R,2,T).
%:- on(R,2,3,T), move(R,2,T).
%:- on(R,4,3,T), move(R,3,T).
%:- on(R,4,3,T), move(R,4,T).
%:- on(R,5,3,T), move(R,1,T).
%:- on(R,5,3,T), move(R,2,T).
%:- on(R,5,3,T), move(R,4,T).
%:- on(R,6,3,T), move(R,2,T).
%
%:- on(R,1,4,T), move(R,2,T).
%:- on(R,1,4,T), move(R,4,T).
%:- on(R,2,4,T), move(R,2,T).
%:- on(R,2,4,T), move(R,4,T).
%:- on(R,3,4,T), move(R,3,T).
%:- on(R,4,4,T), move(R,1,T).
%:- on(R,4,4,T), move(R,2,T).
%:- on(R,5,4,T), move(R,2,T).
%:- on(R,5,4,T), move(R,4,T).
%:- on(R,6,4,T), move(R,4,T).
%
%:- on(R,1,5,T), move(R,2,T).
%:- on(R,1,5,T), move(R,4,T).
%:- on(R,2,5,T), move(R,2,T).
%:- on(R,2,5,T), move(R,4,T).
%:- on(R,3,5,T), move(R,3,T).
%:- on(R,4,5,T), move(R,1,T).
%:- on(R,4,5,T), move(R,4,T).
%:- on(R,5,5,T), move(R,2,T).
%:- on(R,5,5,T), move(R,4,T).
%:- on(R,6,5,T), move(R,2,T).
%
%:- on(R,1,6,T), move(R,4,T).
%:- on(R,2,6,T), move(R,4,T).
%:- on(R,3,6,T), move(R,3,T).
%:- on(R,4,6,T), move(R,1,T).
%:- on(R,5,6,T), move(R,4,T).
%:- on(R,6,6,T), move(R,4,T).

% object, robot, goal positions
:- not on(OB,1,2,0).
:- not on( R,1,6,0).
:- not on( G,6,6,T).


