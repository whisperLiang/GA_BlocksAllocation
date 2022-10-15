function M_constrain_shuju = compute_constrain_shuju(M_acess,M_aug_conflict)
[r1,c1] = size(M_aug_conflict);
% M_constrain_shuju：数据依赖矩阵
%约定2：写后读依赖
%3：写后写依赖
%4：读后写依赖
M_constrain_shuju = double(M_acess);
for i = 1:r1
    for j = 1:c1
            for k = 1:c1
                if (~isnan(M_aug_conflict(i,j))) && (~isnan(M_aug_conflict(i,k)))&&(M_acess(abs(M_aug_conflict(i,j))+1,abs(M_aug_conflict(i,k))+1) ==1) %代表两个变量冲突的基本块存在通路
                    if M_aug_conflict(i,j) > -1 && M_aug_conflict(i,k) < 0 %+-
                        M_constrain_shuju(abs(M_aug_conflict(i,j))+1,abs(M_aug_conflict(i,k))+1) = 2;
                    elseif M_aug_conflict(i,j) > -1 && M_aug_conflict(i,k) > -1 %++
                        M_constrain_shuju(abs(M_aug_conflict(i,j))+1,abs(M_aug_conflict(i,k))+1) = 3;
                    elseif M_aug_conflict(i,j) < 0 && M_aug_conflict(i,k) > -1 %-+
                        M_constrain_shuju(abs(M_aug_conflict(i,j))+1,abs(M_aug_conflict(i,k))+1) = 4;
                    end
                end
            end
    end
end