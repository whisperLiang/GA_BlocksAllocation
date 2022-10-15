function [violate_blocks_shuju23] = Judge_shuju23(route,M_constrain_shuju)
% check the shuju constrains
% Input:
% route:��ˮ�ߵȼ�Ⱦɫ��

% Output:
% violate_blocks_shuju2:������д������������Ķ���
% violate_blocks_shuju3:������д��д���������Ķ���
% violate_blocks_shuju4:���������д���������Ķ���
    violate_blocks_shuju23 = 0; 
    [Mr_constrain,Mc_constrain] = find(M_constrain_shuju==2);
    for i = 1:length(Mr_constrain)
        %�ж��Ƿ���ͬһ��ˮ�߼���
        if ~isempty(find(route==(Mr_constrain(i)),1))&&~isempty(find(route==(Mc_constrain(i)),1))
            violate_blocks_shuju23 = violate_blocks_shuju23 + 1;
        end
    end
        [Mr_constrain,Mc_constrain] = find(M_constrain_shuju==3);
    for i = 1:length(Mr_constrain)
        %�ж��Ƿ���ͬһ��ˮ�߼���
        if ~isempty(find(route==(Mr_constrain(i)),1))&&~isempty(find(route==(Mc_constrain(i)),1))
            violate_blocks_shuju23 = violate_blocks_shuju23 + 1;
        end
    end
end