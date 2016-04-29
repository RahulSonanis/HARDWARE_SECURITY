function  y = cshiftMatRow(x,rl,shiftAmount)

    % x - Input Matrix
    % rl- Shift left (-1) and Shift Right(1)
    % shiftAmount - Integer value
    
    % Shift elements of a row
    y = circshift(x,[0 rl*shiftAmount 0]);  
   
    
end