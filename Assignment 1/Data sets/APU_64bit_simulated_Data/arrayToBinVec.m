
%**************************************************************************
% Convert 8 bytes vector to 64 bit binary vecotr
%
% Author: D P Sahoo
%**************************************************************************

function [binVec] = arrayToBinVec( bytes,nBitsRight )
    
    % nBitsRight: from right
    n = size(bytes,2);
    nBits = n*8;
    
    startIndex = 1:8:nBits;
    endIndex = 8:8:nBits;
    
    binVec = zeros(1,nBits);
    for i=1:n
        
        x = fliplr( de2bi(bytes(i),8) );
        binVec(startIndex(i):endIndex(i)) =  x;
    end
    
   binVec = binVec(:, nBits-nBitsRight+1:nBits);
end