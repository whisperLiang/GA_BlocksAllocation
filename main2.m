clear, clc; 
close all;

%% input data
attachment1_date = csvread('attachment1.csv',1,0);
attachment2_date = readmatrix('attachment2.csv','OutputType','string');
attachment3_date = xlsread('attachment3.csv');
W = xlsread('W.xlsx');
R = xlsread('R.xlsx');
M_acess = matrix_change(attachment3_date);
M_aug_conflict = cM_aug_conflict(W,R);
M_constrain_shuju = compute_constrain_shuju(M_acess,M_aug_conflict);



block_number = size(attachment1_date,1);
process_class_number = 607; % number of process_class  

%% GA parameters 
population = 100; %��Ⱥ��С��Խ��Խ��������
generation = 1;
maximum_generation = 5000; %��������
probability_crossover = 0.9; %������� 
probability_mutation = 0.05; %�������
rate_gap = 0.9; %����
length_chrom = block_number + process_class_number - 1; %Ⱦɫ�峤��=��������+��ˮ�߼���-1

%% initialize population
%������ɷ�
chroms = InitPop(population,length_chrom);
% init_chrom = createInitChrom(block_number, time_window1);
% chroms = createInitPopulation(population, length_chrom, block_number, init_chrom);

% display some values of the initial random population
[PCB, NPC, violate_num_pc, violate_r11,violate_r22,violate_r33,violate_r44, ...
    sviolate_blocks_shuju,sviolate_blocks_kongzhi] = decode2(chroms(1,:),block_number,attachment1_date,attachment3_date,M_constrain_shuju,M_acess);
disp('The initial population:');
disp(['Number of process_class: ', num2str(NPC), ', Number of violated process_class: ',...
    num2str(violate_num_pc), ', Number of Violated blocks_shuju: ', num2str(sviolate_blocks_shuju),...
    ', Number of Violated blocks_kongzhi: ', num2str(sviolate_blocks_kongzhi)]);
fprintf('\n');
% calsulate the value of objective function 
ObjV = calObj(chroms,block_number,attachment1_date,attachment3_date,M_constrain_shuju);
% the minimal value
pre_objective_value=min(ObjV);

% Display the change of the objective function value
figure;
hold on;
box on;
xlim([0, maximum_generation]);
title('Optimization Process');
xlabel('Generation');
ylabel('The Optimal Value');


iter_time = [];


%% the loop
while generation <= maximum_generation
    
    tic;
    
    % calculate the fitness value
    ObjV = calObj(chroms,block_number,attachment1_date,attachment3_date,M_constrain_shuju);
    % draw the line
    line([generation - 1, generation], [pre_objective_value, min(ObjV)]); pause(0.0001);
    pre_objective_value = min(ObjV);
    FitnV = Fitness(ObjV);
    % select
    SelCh = Select(chroms,FitnV,rate_gap);
    % crossover
    SelCh = Recombin(SelCh,probability_crossover);
    % mutation
    SelCh = Mutate(SelCh,probability_mutation);
    
    
    % local search
    % SelCh = neighborhoodSearch(SelCh, block_number, time_window1, time_window2, depot_time_window2, service_time, distance_matrix);
    % 
    chroms = Reins(chroms,SelCh,ObjV);
    % Delete duplicate chromsomes 
    chroms = DealRepeat(chroms);
    ObjV = calObj(chroms,block_number,attachment1_date,attachment3_date,M_constrain_shuju);
    [minObjV,minInd]=min(ObjV);
    disp(['Generation:' num2str(generation)]);
    [bestPCB,bestNPC,bestviolate_num_pc,bestviolate_r11,bestviolate_r22,bestviolate_r33,bestviolate_r44, ...
    bestsviolate_blocks_shuju,bestsviolate_blocks_kongzhi]=decode2(chroms(minInd(1),:),block_number,attachment1_date,attachment3_date,M_constrain_shuju,M_acess);
    disp(['Number of process_class: ', num2str(bestNPC), ', Number of violated process_class: ',...
    num2str(bestviolate_num_pc), ', Number of Violated blocks_shuju: ', num2str(bestsviolate_blocks_shuju),...
    ', Number of Violated blocks_kongzhi: ', num2str(bestsviolate_blocks_kongzhi)]);
    fprintf('\n');
    generation = generation + 1;
    
    iter_time(generation) = toc;   
end
ObjV = calObj(chroms,block_number,attachment1_date,attachment3_date,M_constrain_shuju);
[minObjV,minInd]=min(ObjV);

disp('Optimal Result:')
bestChrom=chroms(minInd(1),:);
[bestPCB,bestNPC,bestviolate_r11,bestviolate_r22,bestviolate_r33,bestviolate_r44, ...
    bestsviolate_blocks_shuju,bestsviolate_blocks_kongzhi]=decode2(bestChrom, block_number,attachment1_date,attachment3_date,M_constrain_shuju,M_acess);
disp(['Number of process_class: ', num2str(bestNPC), ', Number of violated process_class: ',...
    num2str(bestviolate_num_pc), ', Number of Violated blocks_shuju: ', num2str(bestsviolate_blocks_shuju),...
    ', Number of Violated blocks_kongzhi: ', num2str(bestsviolate_blocks_kongzhi)]);

% check the missing element in the final result
missing_element = judgeFullElement(bestPCB, block_number);

%drawMap(bestVC, vertexs);



% close all
