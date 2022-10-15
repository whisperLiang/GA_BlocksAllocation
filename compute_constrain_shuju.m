function M_constrain_shuju = compute_constrain_shuju(M_acess,M_aug_conflict)
[r1,c1] = size(M_aug_conflict);
% M_constrain_shuju��������������
%Լ��2��д�������
%3��д��д����
%4������д����
M_constrain_shuju = double(M_acess);
for i = 1:r1
    for j = 1:c1
            for k = 1:c1
                if (~isnan(M_aug_conflict(i,j))) && (~isnan(M_aug_conflict(i,k)))&&(M_acess(abs(M_aug_conflict(i,j))+1,abs(M_aug_conflict(i,k))+1) ==1) %��������������ͻ�Ļ��������ͨ·
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