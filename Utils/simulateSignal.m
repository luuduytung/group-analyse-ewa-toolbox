function tabtheta0 = simulateSignal(M,S,nb,G0)
% Simulate \theta_0 which is S-sparse and structured by group of size G0.

L = M/G0; SG = S/G0; tabtheta0 =  cell(1,nb);

for k = 1:nb
    theta0 = zeros(L,1); theta0(1:SG) = 1; theta0 = theta0(randperm(L));
    theta0 = repmat(theta0,[1 G0])'; theta0 = theta0(:);
    tabtheta0{k} = theta0;
end
end

