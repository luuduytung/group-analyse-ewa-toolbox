function dispIter(t,d)
% Display the numerical order of k*d th iterations, k\in\mathcal N^*.

if ~mod(t,d)
    disp(['iteration = ',num2str(t)])
end
end