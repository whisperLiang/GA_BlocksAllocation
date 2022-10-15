function M_acess = matrix_change(attachment3_date)

[row,col] = size(attachment3_date);

M_neighborhood = zeros(row,row);
for i = 1:row
    for j = 2:col   
        if ~isnan(attachment3_date(i,j))
            M_neighborhood(attachment3_date(i,1)+1,attachment3_date(i,j)+1)=1;
        end
    end
end

%计算可达矩阵
%B=A+A^2+A^3+……+A^n   A为邻接矩阵
n=length(M_neighborhood);
M_acess=M_neighborhood;
for i=2:n
    M_acess=M_acess+M_neighborhood^i;
end

M_acess=(M_acess~=0);

end