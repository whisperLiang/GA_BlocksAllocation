function M_aug_conflict = cM_aug_conflict(W,R)
N = 823;

%变量下标等于行号减一。
M_aug_conflict = zeros(N+1)*nan;                       % 行是变量：x0-x823，列是基本快号，+ 表示写入，- 表示读取。


[r_W,c_W] = size(W);
[r_R,c_R] = size(R);

for i = 0:N                                      % i 是遍历变量X
    q_n = 1;
    for j = 1:r_W
        for k = 1:c_W
            if (W(j,k)==i)                       %下面i+1 因为矩阵下标从1开始，i是变量编号
                M_aug_conflict(i+1,q_n) = j-1;         %j是存储基本块矩阵的行坐标，基本块编号=行坐标-1；
                q_n = q_n+1;
            end
        end
    end
    for j1 = 1:r_R
        for k1 = 1:c_R
            if (R(j1,k1)==i)
                M_aug_conflict(i+1,q_n) = -(j1-1+4);  % +4的原因是R表前四行没元素，不进行读取。
                q_n = q_n+1; 
            end
        end
    end
%    q_n = 1;
end
    
