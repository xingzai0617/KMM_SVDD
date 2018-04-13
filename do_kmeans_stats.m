% setmyenv;
load('do_kmeans.mat','results');

n = length(results);

stats = struct('k',0,'radios',[],'aver_radios',0);
x = []; y=[]; z=[];% use to plot result
for i = 1:n
    res = results(i);
    stats(i).k = res.k;
    trival = false;
    minlen = 9999;
    for j = 1:length(res.clusters)
        % we save the number of elements of the miniumal cluster.
        if minlen > size(res.clusters(j).data,1)
            minlen = size(res.clusters(j).data,1);
        end
        
        stat = cluster_stats(res.clusters(j));
        if stat.trival 
            trival = true;
        end
        stats(i).radios(j) = stat.ratio_90_100;
    end
    stats(i).aver_radios = mean(stats(i).radios);
    stats(i).has_trival_cluster = trival;
    stats(i).minlen = minlen;
    
    if ~stats(i).has_trival_cluster
        x = [x stats(i).k];
        y = [y stats(i).aver_radios];
        z = [z stats(i).minlen];
    end
end
figure;
plot(x,y,'r+');
figure;
plot(x,z,'b+');