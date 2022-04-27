function Y = Evaluation_swarm(r,t,y0,Swarm,Data,NP)
Evaluation=zeros(NP,1);
for i=1:NP
    Ev_num=Dynamical_simulation_ideal(r,t,y0,Swarm(i,:)); %Notice the ideal model is applied
    J=sum(abs(Data-Ev_num));
    Evaluation(i,1)=J;
end
Y=Evaluation;
end