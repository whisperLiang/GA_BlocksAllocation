function violated_pc5 = Judgecontrain25(PCB,attachment1_date,NPC,M_acess)
    violated_pc5 = 0;
        for i=1:floor(NPC/2)
            if i < 17 && ((i+16)<=NPC)
            [~, violate_r1I, ~, ~, ~] = Judge_resource(PCB{i},attachment1_date);
            [~, violate_r1J, ~, ~, ~] = Judge_resource(PCB{i+16},attachment1_date);
            [~, ~, violate_r2I, ~, ~] = Judge_resource2(PCB{i},attachment1_date,M_acess);
            [~, ~, violate_r2J, ~, ~] = Judge_resource2(PCB{i+16},attachment1_date,M_acess);
            sviolated_r1 = violate_r1I+violate_r1J;
            sviolated_r2 = violate_r2I+violate_r2J;
            if sviolated_r1 >0
                violated_pc5 = violated_pc5+1;
            end
            if sviolated_r2 >1
                violated_pc5 = violated_pc5+1;
            end
            end
        end
end