% we should not call this script
% use do_test_svdd instead

% load map
% can be set outside script
if ~exist('k','var')
    k = 4; % we've choosed a proper k
end
if ~exist('fracrej','var')
    fracrej = 0.4; % too little would overfit? and return null classifier
end

% clear possible results of last run
clear w sigma t o testdata testdata_oc out e target_reject outlier_accept roc auc

fname = sprintf('do_svdd_%d_%.2f.mat',k,fracrej);
load(fname,'w','sigma');

% we only use the 2rd and 3th data to test?
t = drug_pos_test;%drugdata_test;
o = outlier_test;
testdata = prdataset([t;o],[zeros(size(t,1),1);ones(size(o,1),1)]);
testdata_oc = oc_set(testdata,'0');

out = nearestcc(testdata_oc,w);
e = dd_error(out);
%target_reject = e(1);
%outlier_accept = e(2);

roc = dd_roc(out);
auc = dd_auc(out);
auc_list = [auc_list auc];
fracrej_list = [fracrej_list fracrej];
figure;
plotroc(roc);