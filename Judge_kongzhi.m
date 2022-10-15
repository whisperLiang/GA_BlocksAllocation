% check the resource constrains
% Input:
% chorm:整条染色体

% Output:
% violate_blocks_shuju:不满足数据依赖的对数
% violate_blocks_kongzhi：不满足控制依赖的对数

function violate_blocks_kongzhi = Judge_kongzhi(chrom,attachment3_date)
violate_blocks_kongzhi = 0; 
[r,c] = size(attachment3_date);                                    %Ａ是表三的数据
for i = 1:r
    index1 = find(chrom==(attachment3_date(i,1)+1));
    if (sum(~isnan(attachment3_date(i,:)))>2)
        for k = 2:c
            index2 = find(chrom==(attachment3_date(i,k)+1));
            if(index1>index2) 
                violate_blocks_kongzhi = violate_blocks_kongzhi +1;
            end
        end
    end
end
end
