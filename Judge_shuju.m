% check the shuju constrains
% Input:
% chrom:整条染色体

% Output:
% violate_blocks_shuju2:不满足写后读数据依赖的对数
% violate_blocks_shuju3:不满足写后写数据依赖的对数
% violate_blocks_shuju4:不满足读后写数据依赖的对数

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