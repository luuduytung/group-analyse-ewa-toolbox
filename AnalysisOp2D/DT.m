function res = DT(Pxy)
% Define the adjoint of the analysis operator D (i.e. <D(f),g> = <f,DT(g)>)
% for the 2D-image experiment.

res = RT(dT(Pxy));
end

function res =  dT(Pxy)
res(:,:,1) = D12(Pxy(:,:,1),'D1T');     res(:,:,2) = D12(Pxy(:,:,2),'D2T');
end

function res =  RT(Pxy)
res = Pxy(:,:,1) + Pxy(:,:,2);
end