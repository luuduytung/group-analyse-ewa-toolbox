function options = settings(theta0,LMCParam,n,problem)
% Construct the problem of estimation and set the posterior paramaters.

% Get the size of regression matrix and the dimension of model.
stheta0 = size(theta0);
signalParam = struct('stheta0',size(theta0),'M',stheta0(1)*stheta0(2));

% Define analysis operator.
if strcmp(problem,'2D')
    anaOp = struct('D',@D,'DT',@DT,'Dp',@Dp,'DpT',@DpT);
else
    fI = @(x) x;
    anaOp = struct('D',fI,'DT',fI,'Dp',fI,'DpT',fI);
end
anaOp.sDtheta0 = size(anaOp.D(theta0));

% Construct the model.
modelParam = createModel(theta0,signalParam,n,problem);

% Define temperature parameter.
beta = 4*modelParam.sigma^2;

% In the 1D problem, h is defined theoretically by \beta/(M*n)
if strcmp(problem,'1D')
    LMCParam.h = beta/(n*signalParam.M);
    LMCParam.gamma = LMCParam.h/2;
end;

options = mergeStructFields({signalParam,LMCParam,anaOp,modelParam,struct('beta',beta,'problem',problem)});

% Choose prior parameters (We choose the suitable prior parameters by 
% minimizing the remaining term of the Analysis-group oracle inequality 
% at \theta_0$)
priorParam = choosePriorParameters(theta0,options);

options = mergeStructFields({options,priorParam});
end
