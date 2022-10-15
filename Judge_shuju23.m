function [violate_blocks_shuju23] = Judge_shuju23(route,M_constrain_shuju)
% check the shuju constrains
% Input:
% route:流水线等级染色体

% Output:
% violate_blocks_shuju2:不满足写后读数据依赖的对数
% violate_blocks_shuju3:不满足写后写数据依赖的对数
% violate_blocks_shuju4:不满足读后写数据依赖的对数
    violate_blocks_shuju23 = 0; 
    [Mr_constrain,Mc_constrain] = find(M_constrain_shuju==2);
    for i = 1:length(Mr_constrain)
        %判断是否在同一流水线级别
        if ~isempty(find(route==(Mr_constrain(i)),1))&&~isempty(find(route==(Mc_constrain(i)),1))
            violate_blocks_shuju23 = violate_blocks_shuju23 + 1;
        end
    end
        [Mr_constrain,Mc_constrain] = find(M_constrain_shuju==3);
    for i = 1:length(Mr_constrain)
        %判断是否在同一流水线级别
        if ~isempty(find(route==(Mr_constrain(i)),1))&&~isempty(find(route==(Mc_constrain(i)),1))
            violate_blocks_shuju23 = violate_blocks_shuju23 + 1;
        end
    end
end