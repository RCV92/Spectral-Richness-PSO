function [X,Y] = Update_LBP(LBP,LBE,Swarm,Evaluation,Ite,NP)
    for i=1:NP
        if LBE(i)>Evaluation(i,Ite)
            LBP(i,:)=Swarm(i,:);
            LBE(i)=Evaluation(i,Ite);
        end
    end
    X=LBP;
    Y=LBE;
end