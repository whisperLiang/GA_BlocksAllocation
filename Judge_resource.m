% check the resource constrains
% Input:
% PCB:bolcks of every process_class

% Output:
% flag:不合格的流水线标志
% violate_rn：超出资源n的数量


function [flag, violate_r1, violate_r2, violate_r3, violate_r4] = Judge_resource(PCB,attachment1_date)
flag = 0;
violate_r1 = -1;
violate_r2 = -2;
violate_r3 = -56;
violate_r4 = -64;
for i = 1:length(PCB)
    r = find(attachment1_date(:,1)==(PCB(i)-1));
    violate_r1 = violate_r1+attachment1_date(r,2);
    violate_r2 = violate_r2+attachment1_date(r,3);
    violate_r3 = violate_r3+attachment1_date(r,4);
    violate_r4 = violate_r4+attachment1_date(r,5);
end
if(violate_r1 >0)
    flag = 1;
elseif(violate_r2 >0)
    flag = 1;
elseif(violate_r3 >0)
    flag = 1;
elseif(violate_r4 >0)
    flag = 1;
end

end