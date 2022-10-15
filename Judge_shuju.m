% check the shuju constrains
% Input:
% chrom:����Ⱦɫ��

% Output:
% violate_blocks_shuju2:������д������������Ķ���
% violate_blocks_shuju3:������д��д���������Ķ���
% violate_blocks_shuju4:���������д���������Ķ���

function [violate_blocks_shuju4] = Judge_shuju(chrom,M_constrain_shuju,type)
    violate_blocks_shuju4 = 0; 
    [Mr_constrain,Mc_constrain] = find(M_constrain_shuju==type);
    for i = 1:length(Mr_constrain)
        index1 = find(chrom == (Mr_constrain(i)));
        index2 = find(chrom == (Mc_constrain(i)));
        if index1 > index2
            violate_blocks_shuju4 = violate_blocks_shuju4 + 1;
        end
    end
end