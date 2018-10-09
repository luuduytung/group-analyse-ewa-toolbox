function res = Dp(Pxy)
% Define the pseudo inverse Dp of the analysis operator D
% (i.e. Dp(D(f)) = f) for the 2D-image experiment.

res = Rp(invd(Pxy));
end

function res = invd(Pxy)
res(:,:,1) = D12(Pxy(:,:,1),'invD1');    res(:,:,2) = D12(Pxy(:,:,2),'invD2');
end

function res = Rp(Pxy)
res = (Pxy(:,:,1)+Pxy(:,:,2))/2;
end