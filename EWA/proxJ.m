function p = proxJ(x,options)
% Calculate \prox_{\gamma J} by the formulas given in Lemma 7.5 and 7.6.

% Calculate the square norm of each group.
if strcmp(options.problem,'2D')
    normgroup =  sqrt(x(:,:,1).^2+x(:,:,2).^2);
else
    matgroup = vec2mat(x,options.G);
    normgroup = sqrt(sum(matgroup.^2,2));
end

% Calculate \prox_{\gamma w} of each group (see Lemma 7.6).
proxnorm = proxwnewton(normgroup,options);

% Return \prox_{\gamma J} (see Lemma 7.5).
proxnormdivnorm = proxnorm./normgroup;
if strcmp(options.problem,'2D')
    p(:,:,1) = proxnormdivnorm.*x(:,:,1);
    p(:,:,2) = proxnormdivnorm.*x(:,:,2);
else
    matprox = diag(proxnormdivnorm)*matgroup;
    p = matprox'; p = p(:);
end
end


function prox = proxwnewton(x,options)
a = options.a; b = options.b; c = options.c; tau = options.tau; alpha = options.alpha; gamma = options.gamma; p0 = options.p0;
wd   = @(x) c*b*x.^(b-1)./(tau^b+x.^b)+alpha^a*a*x.^(a-1);
wdd  = @(x) c*b*(b-1)*x.^(b-2)./(tau^b+x.^b)-c*b^2*x.^(2*(b-1))./(tau^b+x.^b).^2+alpha^a*a*(a-1)*x.^(a-2);
tol = 1E-6;

prox = zeros(size(x));
ind = find(abs(x) > p0);
xind = x(ind);
prox(ind) = sign(xind).*zeronewton(@(x)x+gamma*wd(abs(x))-abs(xind),@(x)1+gamma*wdd(abs(x)),abs(xind),tol);
end


function xnew = zeronewton(f,fd,xinit,tol)
xold = Inf*ones(size(xinit));
xnew = xinit;

while max(abs(xnew-xold)) >= tol
    xold = xnew;
    xnew = xold - f(xold)./fd(xold);
end
end
