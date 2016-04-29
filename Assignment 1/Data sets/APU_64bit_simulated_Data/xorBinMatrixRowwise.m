function R = xorBinMatrixRowwise(X)
% XORing among the rows
% R is row vector
    
    n = size(X,1);
    m = size(X,2);
    R = zeros(1,m);             % Response of XOR 
    for i=1:n
        Ri = X(i,:);
        R = double(xor(Ri,R));
    end

end