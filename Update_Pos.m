function Y = Update_Pos(Swarm,Vel_1,Vel_2,Vel_3,Vel_4,NP,PN,Ite)
    New_Swarm=zeros(NP,PN);
    for i=1:NP
        New_Swarm(i,1)=Swarm(i,1)+Vel_1(i,Ite+1);
        New_Swarm(i,2)=Swarm(i,2)+Vel_2(i,Ite+1);
        New_Swarm(i,3)=Swarm(i,3)+Vel_3(i,Ite+1);
        New_Swarm(i,4)=Swarm(i,4)+Vel_4(i,Ite+1);
    end
    Y=New_Swarm;
end