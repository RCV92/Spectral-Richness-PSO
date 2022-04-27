function Y = Velocity_estimation(Swarm,Vel_1,Vel_2,Vel_3,Vel_4,NP,GBP,LBP,C1,C2,Ite)
    V1=zeros(NP,1);
    V2=zeros(NP,1);
    V3=zeros(NP,1);
    V4=zeros(NP,1);
    for i=1:NP
        V1(i)=Vel_1(i,Ite)+C1*rand*(GBP(1)-Swarm(i,1))...
            +C2*rand*(LBP(i,1)-Swarm(i,1));
        V2(i)=Vel_2(i,Ite)+C1*rand*(GBP(2)-Swarm(i,2))...
            +C2*rand*(LBP(i,2)-Swarm(i,2));
        V3(i)=Vel_3(i,Ite)+C1*rand*(GBP(3)-Swarm(i,3))...
            +C2*rand*(LBP(i,3)-Swarm(i,3));
        V4(i)=Vel_4(i,Ite)+C1*rand*(GBP(4)-Swarm(i,4))...
            +C2*rand*(LBP(i,4)-Swarm(i,4));
    end
    Y=[V1,V2,V3,V4];
end