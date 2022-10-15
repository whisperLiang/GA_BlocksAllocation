function violated_pc6 = Judgecontrain6(PCB,attachment1_date,NPC)
    violated_pc6 = -5;
    for i = 1:2:NPC
        [~, violate_r1I, ~, ~, ~] = Judge_resource(PCB{i},attachment1_date);
        if violate_r1I > -1
            violated_pc6 = violated_pc6 + 1;
        end
    end
end