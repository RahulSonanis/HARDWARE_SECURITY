
function  y = cshiftVec(x,rl,shiftAmount)

    % x - Input Vector
    % rl- Shift left (-1) and Shift Right(1)
    % shiftAmount - Integer value
    
    firstDim = size(x,1);
    if firstDim == 1
        y = circshift(x,[0 rl*shiftAmount]);  % Row vector
    else
        y = circshift(x,[rl*shiftAmount 0]);  % Column Vector
    end
    
end