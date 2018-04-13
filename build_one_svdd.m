addpath(genpath(pwd))

% we should not call this script
% use do_build_svdd instead

% can be set outside script
if ~exist('k','var')
    k = 4; % we've choosed a proper k
end
if ~exist('fracrej','var')
    fracrej = 0.4; % too little would overfit? and return null classifier
end

% do some cleaning
clear data w sigma colors range w_ s_

% got the data
data = [];
for i=1:length(results)
    if results(i).k == k
        data = results(i);
        break;
    end
end


% train the data by using consistent_occ
w={};
sigma={};
colors = {'r+','g+','b+','y+','d+'};
for i=1:k
    x = data.clusters(i).data;
    x = target_class(x);
    range = scale_range(x);
    [w_,s_] = consistent_occ(x,'svdd',fracrej,range);
    hold on;
%   scatterd(x,colors{i});
%   plotc(w_); % we cannot plot mapping of data of dimension more than 2.
    if isempty(w_)
        return
    end
    w{i}=w_;
    sigma{i}=s_;
end

fname = sprintf('do_svdd_%d_%.2f.mat',k,fracrej);
save(fname,'w','sigma');