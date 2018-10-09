function res = D12(u,type)
% Define D1 (resp. D2) the finite difference operators along the columns
% (reps. rows) with the corresponding adjoint and inverse operators.

switch type
    case 'D1'
        res = u-u([1 1:end-1],:);     res(1,:) = u(1,:);
    case 'D2'
        res = u-u(:,[1 1:end-1]);     res(:,1) = u(:,1);
    case 'D1T'
        res = u-u([2:end end],:);     res(end,:) = u(end,:);
    case 'D2T'
        res = u-u(:,[2:end end]);     res(:,end) = u(:,end);
    case 'invD1'
        res = cumsum(u);
    case 'invD2'
        res = cumsum(u,2);
    case 'invD1T'
        res = cumsum(u(end:-1:1,:));    res = res(end:-1:1,:);
    case 'invD2T'
        res = cumsum(u(:,end:-1:1),2);    res = res(:,end:-1:1);
    otherwise
        res = u;
end
end