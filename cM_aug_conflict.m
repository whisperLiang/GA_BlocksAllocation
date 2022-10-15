function M_aug_conflict = cM_aug_conflict(W,R)
N = 823;

%�����±�����кż�һ��
M_aug_conflict = zeros(N+1)*nan;                       % ���Ǳ�����x0-x823�����ǻ�����ţ�+ ��ʾд�룬- ��ʾ��ȡ��


[r_W,c_W] = size(W);
[r_R,c_R] = size(R);

for i = 0:N                                      % i �Ǳ�������X
    q_n = 1;
    for j = 1:r_W
        for k = 1:c_W
            if (W(j,k)==i)                       %����i+1 ��Ϊ�����±��1��ʼ��i�Ǳ������
                M_aug_conflict(i+1,q_n) = j-1;         %j�Ǵ洢���������������꣬��������=������-1��
                q_n = q_n+1;
            end
        end
    end
    for j1 = 1:r_R
        for k1 = 1:c_R
            if (R(j1,k1)==i)
                M_aug_conflict(i+1,q_n) = -(j1-1+4);  % +4��ԭ����R��ǰ����ûԪ�أ������ж�ȡ��
                q_n = q_n+1; 
            end
        end
    end
%    q_n = 1;
end
    
