function thetahat = FBLMC(nablaF,proxJ,options)
% FB-LMC algorithm.

% Settings.
gamma = options.gamma; T = options.T; h = options.h; 
sDtheta0 = options.sDtheta0; Dp = options.Dp; problem = options.problem; 
Linit = options.Linit;

% Initialization.
if isempty(Linit) L = rand(sDtheta0); else L = Linit; end;
uhat = zeros(sDtheta0);

% Perform the discretized LMC processus by the forward Euler scheme.
for t = 1:T
    dispIter(t,10);
    valnablaF = nablaF(L,options);
    epsilon = sqrt(h)*randn(sDtheta0);
    L = (1-h/(2*gamma))*L + h/(2*gamma)*proxJ(L-gamma*valnablaF+epsilon,options);
    if strcmp(problem,'2D') L = proj(L); end;
    uhat = uhat + L;
end

% Return the result of estimation.
thetahat = Dp(uhat/T);
end


