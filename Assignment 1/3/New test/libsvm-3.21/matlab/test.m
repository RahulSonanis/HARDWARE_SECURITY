a = [1,0,0,1,0;1,1,1,0,1;0,0,1,1,0;1,1,1,1,1];
b = [1,0,0,1,0;1,1,1,0,1;0,0,1,1,0;1,1,1,1,1];
b(1:4,6) = ones(4,1);
% 3 * 5
for i = 1:4
    for j = 1 : 5
        if a(i,j) == 0
            a(i,j) = 1;
        else
            a(i,j) = -1;
        end
    end
end
% 

for i = 1:4
    for j = 1:5
        hi = 1;
%         if j == 5  
%             b(i,j) = 1;
%         else
            for k = j:5
                hi = hi * a(i,k);
            end
            b(i,j) = hi;
%         end
    end    
end