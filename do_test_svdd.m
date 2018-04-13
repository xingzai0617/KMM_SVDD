% setmyenv;
% load pca result
load('do_pca.mat','coeff','n_comp');
coeff_n_comp = coeff(:,1:n_comp); % we only choose part of the principal components

% load test data
load('drug_pos.mat');
drug_pos_test=[zscore(drug_pos(:,2:end))*coeff_n_comp];

load('outlier.mat');
outlier_test=[zscore(outlier)*coeff_n_comp];

% the following variables are used in the subroutine.
k = 3;
fracrej = 0.2;

fracrej_list = [];
auc_list = [];
auc_bound = [0.05,0.5]; % range of outlier accept error
for fracrej = 0.3:0.1:0.6
    test_one_svdd;
end
auc_list
