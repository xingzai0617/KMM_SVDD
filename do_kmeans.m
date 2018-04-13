% setmyenv;

load('do_pca.mat','score','drug_first_column','n_comp');
drug_pca_score = score;

drug_train = drug_pca_score(:,1:n_comp);

% we try  for the number of cluster centers
min_k = 1;
max_k = 20;
step_k = 1;
results=struct('clusters',[],'k',[]);

count = 0;
for k=min_k:step_k:max_k  % need refine  numbers of k     
    
    count = count+1;
    
    [L,C] = kmeansplus(drug_train',k);
    L=L';C=C';

    cluster_data=struct('data',[],'center',[]);
    for i=1:k
        [I,~]=find(L==i);
        cluster_data(i).data=drug_train(I,:);
        cluster_data(i).fc = drug_first_column(I,:); % first column of drug_data
        cluster_data(i).center=C(i,:);
    end
    results(count).clusters=cluster_data;
    results(count).k=k;
end

save('do_kmeans.mat','results');