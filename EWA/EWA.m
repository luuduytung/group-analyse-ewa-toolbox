function thetahat = EWA(options)
% Estimate the regression model by EWA estimator implemented by FB-LMC or 
% semi FB-LMC algorithm.

% Calculate the threshold p0 in Lemma 7.6.
options.p0 = calp0(options);

% Implement EWA estimator by FB-LMC or semi FB-LMC algorithm.
if strcmp(options.method,'semiFBLMC')
    thetahat = semiFBLMC(@nablaF,@proxJ,options);
else
    thetahat = FBLMC(@nablaF,@proxJ,options);
end
end

