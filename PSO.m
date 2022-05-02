%% PSO algorithm in script
close all; clear all; clc;

%% Preliminaries related to the used data

% Load of the reference signals
load('References.mat')

% If the data is obtained by physical experimentation is loaded
% load('Data.mat')

% If the data is performed by simulation
r=White_noise; %Selection the reference to be used

y0=[0,0]; %Implementation of the initial conditions
theta=[2.5466,0.1375,0.0115,0.1379]; %Set of parameters from the dynamical system in simulation
Data=Dynamical_simulation_nonideal(r,t,y0,theta); %Simulation using the Euler integration method

% In case that a Simulink model is used for the simulation of the dynamical
% system the "sim(.)" function is applied, just is required the output of
% the system is saved as a numerical vector with the name Data. 
% Must be noticed that a fixed step integration method with the
% same sample time used on the reference must be set on Simulink.


%%  PSO algorithm settings

PN=4;                           %Number of parameters
NP=30;                          %Number of particles on the swarm
K_max=200;                      %Maximum number of iterations
LB=[0,0,0,0];                   %Lower constraint boundaries for the parameters
UB=[8,3,3,3];                   %Upper constraint boundaries for the parameters
alpha=0.5;                      %Boundary of performance function to stop search of solutions

C1=1.5;                         %Weigth for Global Solution
C2=1.5;                         %Weigth for Local Solution

%% Generation of the initial population of the swarm

Swarm=zeros(NP,PN);
for i=1:PN
    A=rand(NP,1)*(UB(i)-LB(i))+LB(i);
    Swarm(:,i)=A;
end

%% Generation of the vector for velocities

Vel_1=zeros(NP,K_max);
Vel_2=zeros(NP,K_max);
Vel_3=zeros(NP,K_max);
Vel_4=zeros(NP,K_max);

%% Vectors for the recording of the global best position swarm evoluation over iterations

Save_pos=zeros(K_max,PN);
Save_eva=zeros(K_max,1);
Evaluation=zeros(NP,K_max);

%% First evaluation of the particles on the swarm
Ite=1;                  %Number of iteration
Evaluation(:,Ite)=Evaluation_swarm(r,t,y0,Swarm,Data,NP)'; %Evaluation of the particles on the swarm

% Save of the local best position (LBP) and local best evaluation (LBE)
LBP=Swarm;
LBE=Evaluation(:,Ite);

% Save of the global best position (GBP) and global best evaluation (GBE)
[Sort_list,Index]=sort(Evaluation(:,Ite)); %Identification of the best evaluated particle
GBP=Swarm(Index(1),:);
GBE=Evaluation(Index(1),Ite);
Save_pos(Ite,:)=GBP;
Save_eva(Ite)=GBE;

%% Generation of new position for the particles

Vel=Velocity_estimation(Swarm,Vel_1,Vel_2,Vel_3,Vel_4,NP,GBP,LBP,C1,C2,Ite); %Estimation of new velocities
Vel_lim=Boundary_limit(Swarm,Vel,LB,UB,NP,PN); %Limitation of the velocity to remain into the boundaries
Vel_1(:,Ite+1)=Vel_lim(:,1);
Vel_2(:,Ite+1)=Vel_lim(:,2);
Vel_3(:,Ite+1)=Vel_lim(:,3);
Vel_4(:,Ite+1)=Vel_lim(:,4);
Swarm=Update_Pos(Swarm,Vel_1,Vel_2,Vel_3,Vel_4,NP,PN,Ite); %Update the population of the swarm

%% Loop of the algorithm

while 1
    Ite=Ite+1;
    Evaluation(:,Ite)=Evaluation_swarm(r,t,y0,Swarm,Data,NP)';
    [LBP,LBE] = Update_LBP(LBP,LBE,Swarm,Evaluation,Ite,NP); % Selection of new local best positions and evaluations
    [Sort_list,Index]=sort(Evaluation(:,Ite));
    if Evaluation(Index(1),Ite)<=GBE
        GBP=Swarm(Index(1),:);
        GBE=Evaluation(Index(1),Ite);  
    end
    Save_pos(Ite,:)=GBP;
    Save_eva(Ite,:)=GBE;
    Vel=Velocity_estimation(Swarm,Vel_1,Vel_2,Vel_3,Vel_4,NP,GBP,LBP,C1,C2,Ite); %Estimation of new velocities
    Vel_lim=Boundary_limit(Swarm,Vel,LB,UB,NP,PN); %Limitation of the velocity to remain into the boundaries
    Vel_1(:,Ite+1)=Vel_lim(:,1);
    Vel_2(:,Ite+1)=Vel_lim(:,2);
    Vel_3(:,Ite+1)=Vel_lim(:,3);
    Vel_4(:,Ite+1)=Vel_lim(:,4);
    Swarm=Update_Pos(Swarm,Vel_1,Vel_2,Vel_3,Vel_4,NP,PN,Ite); %Update the population of the swarm
    
    if Ite>K_max
        break;
    end
    if GBE<alpha
        break;
    end 
end
disp('The best estimated parameters are :')
GBP
disp('With a performance function (J) value of:')
GBE








