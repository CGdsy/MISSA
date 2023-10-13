clear all;
clc;

populationSize = 100; % Number of search agents
Max_iteration =2000;
runs = 30;

for fn = 1:30
    if fn == 2
        continue;   %To skip function-2 of CEC-BC-2017 because of its unstable behavior
    end
    Function_name=strcat('F',num2str(fn));
    [lb,ub,dim,fobj]=CEC2017(Function_name);
    Best_score_T = zeros(1,runs);
    parfor run=1:runs
        rng('shuffle');
        [Best_score_0,Best_pos,PO_cg_curve] = MISSA(populationSize,Max_iteration,lb,ub,dim,fobj);
        Best_score_T(1,run) = Best_score_0;
        PO_cg_curve2(:,run) = PO_cg_curve;
    end
    %%Finding statistics
    Best_score_Best = min(Best_score_T);
    Best_score_Worst = max(Best_score_T);
    Best_score_Median = median(Best_score_T,2);
    Best_Score_Mean = mean(Best_score_T,2);
    Best_Score_std = std(Best_score_T);
    %Printing results
    display(['Fn = ', num2str(fn)]);
    display(['Best, Worst, Median, Mean, and Std. are as: ', num2str(Best_score_Best),'  ', ...
    num2str(Best_score_Worst),'  ', num2str(Best_score_Median),'  ', num2str(Best_Score_Mean),'  ', num2str(Best_Score_std)]);
end

