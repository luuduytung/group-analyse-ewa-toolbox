function nV1 = nablaF(x,options)
% Calculate the \nabla F term in FB-LMC and semi FB-LMC algorithms.

X = options.X; XT = options.XT; y = options.y; beta = options.beta;

if strcmp(options.method,'semiFBLMC')
    A = @(x) X(x); AT = @(x) XT(x);
else
    Dp = options.Dp; DpT = options.DpT;
    A = @(x) X(Dp(x)); AT = @(x) DpT(XT(x));
end

AA = @(x) AT(A(x)); Ay = AT(y);
nV1 = -(2/beta)*(Ay-AA(x));
end