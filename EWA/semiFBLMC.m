function thetahat = semiFBLMC(nablaF,proxJ,options)
% Semi FB-LMC algorithm.

% Settings.
stheta0 = options.stheta0; gamma = options.gamma; h = options.h; 
T = options.T; D = options.D; DT = options.DT; Linit = options.Linit;

% Initialization.
if isempty(Linit) L = rand(stheta0); else L = Linit; end;
uhat = zeros(stheta0);

% Perform the discretized LMC processus by the forward Euler scheme.
for t = 1:T
    dispIter(t,10);
    DL = D(L);
    valnablaF = nablaF(L,options);
    epsilon = sqrt(2*h)*randn(stheta0);
    L = L-h*valnablaF-(h/gamma)*DT(DL-proxJ(DL,options))+epsilon;
    uhat = uhat + L;
end

% Return the result of estimation.
thetahat = uhat/T;
end



