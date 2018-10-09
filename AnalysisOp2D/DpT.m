function res =  DpT(u)
% Define the adjoint DpT of the pseudo inverse Dp of the analysis operator
% D (i.e. <Dp(f),g> = <f,DpT(g)>) for the 2D-image experiment.

res = invdT(RpT(u));
end

function res =  invdT(Pxy)
res(:,:,1) = D12(Pxy(:,:,1),'invD1T');       res(:,:,2) = D12(Pxy(:,:,2),'invD2T');
end

function res = RpT(u)
res(:,:,1) = u/2; res(:,:,2) = u/2;
end