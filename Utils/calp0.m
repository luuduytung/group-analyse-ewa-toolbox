function p0 = calp0(options)
% Calculate the threshold p0 in Lemma 7.6.

a = options.a; b = options.b; c = options.c; alpha = options.alpha; gamma = options.gamma; tau = options.tau;

% Define w'(x), w''(x).
nablaw = @(x) c*b*x.^(b-1)./(tau^b+x.^b)+alpha^a*a*x.^(a-1);
doublenablaw = @(x) c*b*(b-1)*x.^(b-2)./(tau^b+x.^b)-c*b^2*x.^(2*(b-1))./(tau^b+x.^b).^2+alpha^a*a*(a-1)*x.^(a-2);

% Solve p0 = \min_{v\geq 0} {v+gamma*w'(v)}.
fun = @(x)(1+gamma*doublenablaw(x));
m = fzero(fun,[0.00000000001,100]);
p0 = m+gamma*nablaw(m);
end