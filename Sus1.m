% stochastic universal sampling
% output: 
% NewChrIx -------- the indexes of selected chromosomes

function NewChrIx = Sus(FitnV,Nsel)
   [population_size, ~] = size(FitnV);
   % cumsum, cumulative sum
   cumfit = cumsum(FitnV);
   % ���ȷֲ�+ƫ��, ptr
   trials = cumfit(population_size) / Nsel * (rand + (0 : Nsel-1)');
   %copy the column
   Mf = cumfit(:, ones(1, Nsel));
   Mt = trials(:, ones(1, population_size))';
   
   % ���ص����У�
   % һ��һ�������⣿
   % ���޺����ޣ�
   % Mf���ص�
   [NewChrIx, ans] = find(Mt < Mf & [zeros(1, Nsel); Mf(1:population_size-1,:)] <= Mt);
   
   % sort these indexes to a random order
   [~, shuf] = sort(rand(Nsel, 1));
   NewChrIx = NewChrIx(shuf);
   
end



% End of function
% Proportionate Roulette Wheel Selection
% bad performance, need more iterations

% function NewChrIx = Sus(FitnV,Nsel)
%    % cumsum, cumulative sum
%    p = cumsum(FitnV) / sum(FitnV);
%    NewChrIx = [];
%    count = 0;
%    while (count <= Nsel)
%        temp_idx = find(p >= rand);
%        if isempty(find(NewChrIx == temp_idx(1), 1))
%            NewChrIx = [NewChrIx; temp_idx(1)];
%            count = count + 1;
%        end
%    end
% end