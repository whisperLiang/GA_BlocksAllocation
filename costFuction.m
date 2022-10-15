function [cost] = costFuction(NPC, violate_num_pc, violate_r11,violate_r22,violate_r33,violate_r44, sviolate_blocks_shuju,sviolate_blocks_kongzhi) 
    % the weight will influence the result.
    cost = 10*NPC + 10*violate_num_pc + 2*sviolate_blocks_shuju + 5*sviolate_blocks_kongzhi+ violate_r11 + violate_r22 + violate_r33 + 0.1*violate_r44;
end