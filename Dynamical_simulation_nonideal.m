%% Function that computes the simulation from a dynamical system using
% the Euler integration method for the nonideal case.
% r is the reference signal applied, t is the vector of time, y0 containts
% the initial conditions of the states of the system and theta is the
% vector that contains the parameters
function Y = Dynamical_simulation_nonideal(r,t,y0,theta)
%% Set the contain of theta as the parameter on the model
    k=theta(1);
    z=theta(2);
    p1=theta(3);
    p2=theta(4);
    Cf=(k*p1*p2)/z;
%% Evaluate the vector time from the reference to determinate the sampling
%  time and the number of evaluations requires for the Euler method
    ts=t(2)-t(1);
    N=length(t);
%% Generate the vector that contains the solutions required and stablish 
%  the initial conditions
    x1=zeros(N,1);
    x2=zeros(N,1);
    x1(1)=y0(1);
    x2(1)=y0(2);
%% Implementation of the input perturbation
    rm=r+0.01*sin(t); 
%% Evaluation of the dynamical system using the Euler integration method
    for i=2:N
        x1(i)=x1(i-1)+ts*x2(i-1);
        if i==2
            dr=(rm(i-1)-0)/ts;
        else
            dr=(rm(i-1)-rm(i-2))/ts;
        end
        Din=-x2(i-1)*(p1+p2)-x1(i-1)*p1*p2+Cf*(-z*rm(i-1)-dr);
        x2(i)=x2(i-1)+ts*Din;
    end
%% Definition of the output from the dynamical system with measurement
%  noise
    Y=x1+rand(N,1)*0.005;
end