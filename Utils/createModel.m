function modelParam = createModel(theta0,signalParam,n,problem)
% Construct the linear regression model
%                       Y = X\theta_0 + \xi
% where the design matrix X is drawn uniformly at random from the 
% Rademacher ensemble and \xi i.i.d. ~ \mathcal N(0,\sigma^2) with the 
% noise level \sigma is chosen according to \theta_0 through the 
% signal-to-noise ratio.

M = signalParam.M; stheta0 = signalParam.stheta0;

matX = 2*round(rand(n,M))-1;
if strcmp(problem,'2D')
    X = @(x) matX*x(:);
    XT = @(x) reshape(matX'*x(:),stheta0);
else
    X = @(x) matX*x;
    XT = @(x) matX'*x;
end;
Xtheta0 = X(theta0);
snr = -2;   sigma = norm(Xtheta0)*10^(-snr/10)/n;
epsilon = sigma*randn(size(Xtheta0));
y = Xtheta0 + epsilon;

modelParam = struct('n',n,'X',X,'XT',XT,'y',y,'sigma',sigma);
end