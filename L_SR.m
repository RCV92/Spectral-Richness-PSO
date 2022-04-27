function Y = L_SR(Lb,chi,omc,k,kmax,Lmin)
    N=Lb*exp(-chi);
    D=1+exp(-omc*(k-0.5*kmax));
    F=N/D;
    Y=Lmin+F;
end