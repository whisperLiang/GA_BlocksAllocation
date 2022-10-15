% check the resource constrains
% Input:
% PCB:bolcks of every process_class

% Output:
% flag:不合格的流水线标志
% violate_rn：超出资源n的数量


function [flag, violate_r1, violate_r2, violate_r3, violate_r4] = Judge_resource2(PCB,attachment1_date,M_acess)
flag = 0;
violate_r1 = 0;
violate_r2 = 0;
violate_r3 = 0;
violate_r4 = 0;

r2 = 0;
r3 = 0;
% 判断每级同一执行流程资源的最大值
for k = 1:length(PCB)
    r2 = r2+attachment1_date(PCB(k),3);
    r3 = r3+attachment1_date(PCB(k),4);
    col = find(M_acess(PCB(k))==1);     %保证在同一执行流程上
    for co = 1:length(col)
        if ~isempty(find(PCB==col(co),1))  % 保证在同一级
                r2 = r2+attachment1_date(PCB(col(co)),3);   %每个节点都作为起始节点
                r3 = r3+attachment1_date(PCB(col(co)),4);
        end
    end
    if r2 > violate_r2         % 取最大
        violate_r2 = r2;
    end
    if r3 > violate_r3
        violate_r3 = r3;
    end
    
end
for i = 1:length(PCB)
    r = find(attachment1_date(:,1)==(PCB(i)-1));
    violate_r1 = violate_r1+attachment1_date(r,2);
    violate_r4 = violate_r4+attachment1_date(r,5);
end
violate_r1=violate_r1-1;
violate_r2=violate_r2-2;
violate_r3=violate_r3-56;
violate_r4=violate_r4-64;
if( violate_r1>0)
    flag = 1;
elseif(violate_r2 >0)
    flag = 1;
elseif(violate_r3 >0)
    flag = 1;
elseif(violate_r4 >0)
    flag = 1;
end

end