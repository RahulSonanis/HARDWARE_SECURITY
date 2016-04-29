
function R = xorBinMatrixColwise(X)
% XORing among the columns

    n = size(X,1);
    m = size(X,2);
    R = zeros(n,1);             % Response of XOR 
    for i=1:m
        Ri = X(:,i);
        R = double(xor(Ri,R));
    end

end