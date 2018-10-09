function mSF = mergeStructFields(cellStructFields)
% Merge several structure fields.

mSF = struct();
for i = 1:length(cellStructFields)
    mSF = setstructfields(mSF,cellStructFields{i});
end
end
