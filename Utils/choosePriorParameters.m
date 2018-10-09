function priorParam = choosePriorParameters(theta0,options)
% Choose the prior parameters by minimizing the remaining term of the 
% Analysis-group SOI at \theta_0.

n=options.n; M = options.M; G = options.G; D = options.D; problem = options.problem; muD = 10^-9;

% Calculate the square norm of each group.
Dtheta0 = D(theta0);
if strcmp(problem,'2D')
    normgroup =  sqrt(Dtheta0(:,:,1).^2+Dtheta0(:,:,2).^2);
else
    normgroup =  sqrt(sum(vec2mat(Dtheta0,G).^2,2));
end
L = M/G;

% Choose a, b and c by minimizing the remaining term of the Analysis-group 
% SOI at \theta_0.
tildeKag = @(a,b,c) gamma((2*a+G)/b)*gamma(c-(2*a+G)/b)/(gamma(G/b)*gamma(c-G/b));
fun = @(x) resOracleMinimize(x(1),x(2),x(3),muD,L,normgroup,tildeKag,options);
lb = [0,0,0]; ub = [1,1,Inf];
x0 = [0.5,0.5,1];
x = fmincon(fun,x0,[],[],[],[],lb,ub,[],optimset('Display','off'));
a = x(1); b = x(2);  c = (2+G)/b+x(3);

% Define \tau and \alpha by the theory.
tau = sqrt(muD/(M*n*tildeKag(1,b,c)));
alpha = 1/(3*sqrt(tau^(2*a)*tildeKag(a,b,c))*(M/G))^(1/a);

% Return the prior parameters.
priorParam = struct('a',a,'b',b,'c',c,'alpha',alpha,'tau',tau);
end



function [res] = resOracleMinimize(a,b,err,muD,L,normgroup,tildeKag,options)
beta = options.beta; n = options.n; M = options.M; G = options.G; c = (2+G)/b + err; tau = sqrt(muD/(M*n*tildeKag(1,b,c)));
res = (c*beta)/n*sum(sum(log(1+(normgroup/tau).^b))) + (beta/n)*(2+sum(sum(normgroup.^a))/(3*L*tau^a*sqrt(tildeKag(a,b,c)))) + 2*M*tau^2*tildeKag(1,b,c)*exp(1)/muD;
end




