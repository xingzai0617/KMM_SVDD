function stat = cluster_stats(cluster)
%CLUSTER_STAT Calculate some statistical infosw
%   stat = cluster_stats(cluster) 
%          cluster should be struct('data',[],'center',[]);

%   Version: 2014-10-22
%   Authors: crackhopper
delta = cluster.data-ones(size(cluster.data,1),1)*cluster.center;
dist = sqrt(sum(delta.^2,2));
dist = sort(dist,'ascend');
len = length(dist);

if len == 1
    stat.radius_100 = 0; % total radius
    stat.radius_90 = 0; % radius of 90% of the data
    stat.ratio_90_100 =  1; % this reflects the extent of density.    
else
    stat.radius_100 = dist(len); % total radius
    stat.radius_90 = dist(floor(len*0.9)); % radius of 90% of the data
    stat.ratio_90_100 =  stat.radius_90/stat.radius_100; % this reflects the extent of density.
    stat.dist = dist;
end
trival_thrd = 50;

if len < trival_thrd
    stat.trival = true;
else
    stat.trival = false;
end
