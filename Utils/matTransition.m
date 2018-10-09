function [mattransition] = matTransition(G0,G)
% Construct the transitions matrices described in Sub Sub Section 7.3.1.

M=128; nb=20; epsilon=0.4;
mattransition = cell(M/4,M/8);
Linit = zeros(M,1);
LMCParam = struct('G',G,'T',3500,'Linit',Linit,'method','semiFBLMC'); problem = '1D';

for (n=8:8:M)
    for S = 4:4:M
        disp(['n = ',num2str(n),' S = ',num2str(S)])
        tabtheta0 = simulateSignal(M,S,nb,G0);
        err = zeros(nb,1);
        for k=1:nb
            theta0 = tabtheta0{k};
            options = settings(theta0,LMCParam,n,problem);
            thetahat = EWA(options);
            err(k) = (1/sqrt(n))*norm(theta0-thetahat);
        end
        mattransition(S/4,n/8) = (1/nb)*sum(err<epsilon);
    end
end
end

