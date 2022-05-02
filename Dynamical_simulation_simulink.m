%% Function that computes the simulation from a dynamical system using
% a simulink model
% r is the reference signal applied, t is the vector of time, y0 containts
% the initial conditions of the states of the system and theta is the
% vector that contains the parameters
function Y = Dynamical_simulation_ideal(r,t,y0,theta)
%% Set the contain of theta as the parameter on the model
    Sim_data_1=theta(1); %k
    Sim_data_2=theta(2); %z
    Sim_data_3=theta(3);%p1 
    Sim_data_4=theta(4);%p2
    Sim_data_5=(Sim_data_1*Sim_data_3*Sim_data_4)/Sim_data_2;%Cf
    Sim_data_6=max(t);%T_max
    Sim_data_7=t(2)-t(1);%ts
    Sim_data_8=timeseries(r,t);%Ref
    save('Simu_data','Sim_data_1','Sim_data_2','Sim_data_3','Sim_data_4','Sim_data_5','Sim_data_6','Sim_data_7','Sim_data_8');
    S=sim('Simulation_ideal_S.slx');
    S_timeseries=S.simout;
    S_rela=squeeze(S_timeseries);
%% Definition of the output from the dynamical system
    Y=S_rela;
end