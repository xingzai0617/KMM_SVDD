% setmyenv;
% load pca result
load('do_pca_tr.mat','coeff','n_comp');
coeff_n_comp = coeff(:,1:n_comp); % we only choose part of the principal components

load('drugdata1.mat');load('drugdata2.mat');load('drugdata3.mat');
drugdata=[drugdata1;drugdata2;drugdata3];
drugdata_test=[zscore(drugdata(:,2:end))*coeff_n_comp];

k = 3;
fracrej = 0.4;

clear w sigma t o testdata testdata_oc out e target_reject outlier_accept roc auc

fname = sprintf('do_svdd_%d_%.2f.mat',k,fracrej);
load(fname,'w','sigma');

t = drugdata_test;
testdata = prdataset(t,[zeros(size(t,1),1)]); % the tags doesn't matter.

testdata_oc = oc_set(testdata,'0');
out = nearestcc(testdata_oc,w);  

[res_val,idx] = sort(out(:,1),'descend');% the higher of the first column, the more we regard it as target
res_id = drugdata(idx,1);