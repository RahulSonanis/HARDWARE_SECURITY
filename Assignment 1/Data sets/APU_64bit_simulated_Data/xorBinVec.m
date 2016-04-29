% XOR of n elemnet vector
function Y = xorBinVec(X)
    Y = mod(sum(logical(X)),2)==1;
end