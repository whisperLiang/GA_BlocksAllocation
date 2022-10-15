% calculate the value of objective function
function ObjV = calObj(chroms,block_number,attachment1_date,attachment3_date,M_constrain_shuju)
    n = size(chroms,1); % number of all vehicle                       
    ObjV = zeros(n,1);                        
    for i=1:n
        % NPC ------------- number of process_class
        [~, NPC, violate_num_pc, violate_r11,violate_r22,violate_r33,violate_r44, sviolate_blocks_shuju,sviolate_blocks_kongzhi]=decode(chroms(i,:),block_number,attachment1_date,attachment3_date,M_constrain_shuju);
        % cost = NPC + 1 * (violate_num_pc + violate_blocks_shuju +
        % violate_blocks_kongzhi) + violate_r11 + violate_r22 + violate_r33 + violate_r44
        ObjV(i) = costFuction(NPC, violate_num_pc, violate_r11,violate_r22,violate_r33,violate_r44, sviolate_blocks_shuju,sviolate_blocks_kongzhi);
    end
end
