%% Function that calculate the Spectral Richness from a signal
% r corresponds to a vector that contains the reference and t is the vector
% that contains the time
function Y = Spectral_Richness(r,t)
%% Calculation of the sampling time ts and the sampling frequency fs based
% on the vector of time
ts=t(2)-t(1);
fs=1/ts;
%% Fast fourier transformation using the fft function
L=max(size(r));
Y = fft(r);
P2 = abs(Y/L);
P1 = P2(1:round(L/2+1));
P1(2:end-1) = 2*P1(2:end-1);
%% Normalization from the frequency components
P1=P1/max(P1);
%% Estimation of the threshold kappa
Z=(fs)/length(r);
Kap=1-pi*Z*cot(pi*Z);
%% Evaluation of spectral lines to compute chi
chi=0;
for i=1:length(P1)
    if P1(i)>Kap
        chi=chi+1;
    end
end
    Y=chi;
end