% check the resource constrains
% Input:
% chorm:����Ⱦɫ��

% Output:
% violate_blocks_shuju:���������������Ķ���
% violate_blocks_kongzhi����������������Ķ���

function violate_blocks_kongzhi = Judge_kongzhi(chrom,attachment3_date)
violate_blocks_kongzhi = 0; 
[r,c] = size(attachment3_date);                                    %���Ǳ���������
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
