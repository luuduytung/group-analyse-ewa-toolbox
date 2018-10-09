function res = D(u)
% Define the analysis operator D for the 2D-image experiment.

res = d(R(u));
end

function res = d(Pxy)
res(:,:,1) = D12(Pxy(:,:,1),'D1');       res(:,:,2) = D12(Pxy(:,:,2),'D2');
end

function res = R(u)
res(:,:,1) = u; res(:,:,2) = u;
end
