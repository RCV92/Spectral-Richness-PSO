function Y = P_SR(Pb,chi,omc,k,kmax,pc)
    N1=Pb;
    D1=1+exp(-chi);
    F1=N1/D1;
    N2=1;
    D2=1+exp(-omc*(k-0.5*kmax));
    F2=N2/D2;
    N3=-Pb*pc;
    D3=1+exp(-omc*(k-0.5*kmax));
    F3=N3/D3;
    Y=Pb+(F1*F2)+F3;
end