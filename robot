% file 'robot'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% object declaration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
step(0..maxstep).
astep(0..maxstep-1).
axis(1..6).
robot(1).
object(1).
% corresponds to directions (none, left, up, right, down)
% move(0) means do nothing
direction(0..4).
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
#domain axis(XX).
#domain axis(YY).
#domain axis(Y).
#domain location(L).
#domain location(L1).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% state description
%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a function mapping from object and position to time
1{on(OB,X,Y,ST) : axis(X) : axis(Y)}1 :- object(OB).

% a function mapping from robot and position to time
1{ron(R,X,Y,ST) : axis(X) : axis(Y)}1 :- robot(R).

% function mapping object and robot to time
1{pickup(OB,R,ST): robot(R)}1.
1{place(OB,R,ST): robot(R)}1.

% a function describing robot movement
1{move(R,D,T): direction(D)}1.

% uniqueness constraint for all locations, a robot may only be on one location at a time
:- not 1{ron(R,X,Y,ST): axis(X) : axis(Y) }1.

% uniqueness constraint for all locations, an object may only be on one location at a time
:- not 1{on(OB,X,Y,ST): axis(X) : axis(Y) }1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% effect and preconditions of action
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% effect of picking up an object when the robot doesn't have object is that it then has it
has(OB,R,T+1) :- pickup(OB,R,T), not has(OB,R,T).
% if robot has object and robot moves, object moves likewise
move(OB,D,T):- move(R,D,T), has(OB,R,T).

% robot may only pickup an object if they are co-located
%:- pickup(OB,R,T), on(OB,X,Y,T), ron(R,XX,YY,T), XX!=X, YY!=Y.

% when robot places an object, it obtains the location of the robot
on(OB,X,Y,T+1) :- place(OB,R,T).

% cannot place an object if robot does not have it
%:- place(OB,R,T), not has(OB,R,T).

% robot may not pickup the object if he already has it
%:- pickup(OB,R,T), has(OB,R,T).
%:- pickup(OB1,R,T), has(OB,R,T).

% robot may only pickup an object or move at any time
%:- move(R,D,T), pickup(OB,R,T).

% an object can be moved only when the robot has it
% remove answers where it moves when it does not have it
%:- move(OB,D,T), has(OB,R,T).

% effects of robot movement
ron(R,X-1,  Y,T+1) :- move(R,1,T).
ron(R,  X,Y+1,T+1) :- move(R,2,T).
ron(R,X+1,  Y,T+1) :- move(R,3,T).
ron(R,  X,Y-1,T+1) :- move(R,4,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% domain independent axioms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fluents are initially exogenous
{ron(R,X,Y,0)}.

% actions are exogenous
{move(R,D,T): robot(R): direction(D)}.

% commonsense law of inertia
{on(O,X,Y,T+1)} :- on(O,X,Y,T).
{ron(R,X,Y,T+1)} :- ron(R,X,Y,T).
{has(OB,R,T+1)} :- has(OB,R,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% planning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% walls: 
:- ron(R,1,1,T), move(R,2,T).
:- ron(R,2,1,T), move(R,2,T).
:- ron(R,4,1,T), move(R,2,T).
:- ron(R,4,1,T), move(R,3,T).
:- ron(R,5,1,T), move(R,1,T).
:- ron(R,5,1,T), move(R,2,T).

:- ron(R,1,2,T), move(R,4,T).
:- ron(R,2,2,T), move(R,3,T).
:- ron(R,2,2,T), move(R,4,T).
:- ron(R,3,2,T), move(R,1,T).
:- ron(R,4,2,T), move(R,2,T).
:- ron(R,4,2,T), move(R,4,T).
:- ron(R,5,2,T), move(R,2,T).
:- ron(R,5,2,T), move(R,4,T).

:- ron(R,1,3,T), move(R,2,T).
:- ron(R,2,3,T), move(R,2,T).
:- ron(R,4,3,T), move(R,3,T).
:- ron(R,4,3,T), move(R,4,T).
:- ron(R,5,3,T), move(R,1,T).
:- ron(R,5,3,T), move(R,2,T).
:- ron(R,5,3,T), move(R,4,T).
:- ron(R,6,3,T), move(R,2,T).

:- ron(R,1,4,T), move(R,2,T).
:- ron(R,1,4,T), move(R,4,T).
:- ron(R,2,4,T), move(R,2,T).
:- ron(R,2,4,T), move(R,4,T).
:- ron(R,3,4,T), move(R,3,T).
:- ron(R,4,4,T), move(R,1,T).
:- ron(R,4,4,T), move(R,2,T).
:- ron(R,5,4,T), move(R,2,T).
:- ron(R,5,4,T), move(R,4,T).
:- ron(R,6,4,T), move(R,4,T).

:- ron(R,1,5,T), move(R,2,T).
:- ron(R,1,5,T), move(R,4,T).
:- ron(R,2,5,T), move(R,2,T).
:- ron(R,2,5,T), move(R,4,T).
:- ron(R,3,5,T), move(R,3,T).
:- ron(R,4,5,T), move(R,1,T).
:- ron(R,4,5,T), move(R,4,T).
:- ron(R,5,5,T), move(R,2,T).
:- ron(R,5,5,T), move(R,4,T).
:- ron(R,6,5,T), move(R,2,T).

:- ron(R,1,6,T), move(R,4,T).
:- ron(R,2,6,T), move(R,4,T).
:- ron(R,3,6,T), move(R,3,T).
:- ron(R,4,6,T), move(R,1,T).
:- ron(R,5,6,T), move(R,4,T).
:- ron(R,6,6,T), move(R,4,T).

% object, robot, goal positions
% test case
% start conditions
:- not on(OB,3,5,0).
:- not ron( R,4,1,0).
%:- not on( G,2,2,T).
% end conditions
:- not on(OB,2,2,maxstep).
:- not ron(R,2,2,maxstep).

