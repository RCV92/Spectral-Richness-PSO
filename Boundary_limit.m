function Y = Boundary_limit(Swarm,Vel,LB,UB,NP,PN)
    Swarm_test=zeros(NP,PN);  %Swarm for testing solutions
    Vel_Lim=zeros(NP,PN);
    for i=1:NP
        Check=1;
        while 1
            Swarm_test(i,1)=Swarm(i,1)+Vel(i,1);
            Swarm_test(i,2)=Swarm(i,2)+Vel(i,2);
            Swarm_test(i,3)=Swarm(i,3)+Vel(i,3);
            Swarm_test(i,4)=Swarm(i,4)+Vel(i,4);
            if (Swarm_test(i,1)>=LB(1))&&(Swarm_test(i,1)<=UB(1))&&...
               (Swarm_test(i,2)>=LB(2))&&(Swarm_test(i,2)<=UB(2))&&...
               (Swarm_test(i,3)>=LB(3))&&(Swarm_test(i,3)<=UB(3))&&...
               (Swarm_test(i,4)>=LB(4))&&(Swarm_test(i,4)<=UB(4))
                Check=0;
            end
            if Check==0
                Vel_Lim(i,:)=Vel(i,:);
                break;
            end
            Vel(i,:)=Vel(i,:)/2;
        end
    end
    Y=Vel_Lim;
end