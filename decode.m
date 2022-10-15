% input: 
% chrom ---------- one single chroms
% block_number --------- number of blocks
% a, b ----------- time window
% L -------------- latest arrival time to depot

% output:
% PCB ------------- bolcks of every process_class
% NPC ------------- number of process_class

% seperate a chromosome to several routes 

function [PCB, NPC, violate_num_pc, violate_r11,violate_r22,violate_r33,violate_r44, ...
    sviolate_blocks_shuju,sviolate_blocks_kongzhi] = decode(chrom, block_number,attachment1_date,attachment3_date,M_constrain_shuju)
  violate_num_pc = 0;
  violate_r11 = 0;
  violate_r22 = 0;
  violate_r33 = 0;
  violate_r44 = 0;
  sviolate_blocks_kongzhi = 0;
  sviolate_blocks_shuju = 0;
  PCB = cell (block_number, 1);
  count = 1;
  % 选取最后的几个点，作为分割位置
  location0 = find(chrom > block_number); % 找到这几个切割点
  
  % 将基本块分配到流水线级数
  for i = 1:length(location0)
    if i == 1
      % create a new route, include the number of depot
      route = chrom(1:location0(i));
      % delete the number of depot at the end
      route(route == chrom(location0(i))) = [];
    else
      route = chrom(location0(i - 1):location0(i));
      route(route == chrom(location0(i - 1))) = [];
      route(route == chrom(location0(i))) = [];
    end
    PCB{count} = route; % add the route to set
    count = count + 1;
  end
  
  % for the last route
  if isempty(location0)
      route = chrom;
  else
      route = chrom(location0(end) : end);
      route(route == chrom(location0(end))) = [];
  end
  PCB{count} = route;
  % delete empty routes, and get the number of process_class
  [PCB,NPC]=deleteEmptyRoutes(PCB);
  
  % 计算违反数据依赖和控制依赖的基本块个数，以及超过最大级数的个数
  for j=1:NPC
    route = cell(1,1);                                
    route{1} = PCB{j}; % pick up one route
    % check the violated resource
    route = route{1};
    [flag, violate_r1, violate_r2, violate_r3, violate_r4] = Judge_resource(route,attachment1_date);
    [violate_blocks_shuju23] = Judge_shuju23(route,M_constrain_shuju);
    if flag == 1
        violate_num_pc = violate_num_pc+1;
        violate_r11 = violate_r11+violate_r1;
        violate_r22 = violate_r22+violate_r2;
        violate_r33 = violate_r33+violate_r3;
        violate_r44 = violate_r44+violate_r4;
    end
  end
  % check the violated kongzhi & shuju constrain
  violate_blocks_kongzhi = Judge_kongzhi(chrom,attachment3_date);
  violate_blocks_shuju2 = Judge_shuju(chrom,M_constrain_shuju,2);
  violate_blocks_shuju3 = Judge_shuju(chrom,M_constrain_shuju,3);
  violate_blocks_shuju4 = Judge_shuju(chrom,M_constrain_shuju,4);
  violated_pc5 = Judgecontrain5(PCB,attachment1_date,NPC);
  violated_pc6 = Judgecontrain6(PCB,attachment1_date,NPC);
  violate_num_pc = violated_pc5 + violated_pc6;
  sviolate_blocks_shuju = sviolate_blocks_shuju+violate_blocks_shuju4+violate_blocks_shuju23+violate_blocks_shuju2+violate_blocks_shuju3;
  sviolate_blocks_kongzhi = sviolate_blocks_kongzhi+violate_blocks_kongzhi;

end