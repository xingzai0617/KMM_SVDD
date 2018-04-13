% setmyenv;

% load original data
load('drug_1441.mat');

drug_first_column = drug_1441(:,1);
drug_features = drug_1441(:,2:end);
drug_features_normalized = zscore(drug_features);
clear drug_1441;

% we use the normalized data
[coeff,score,latent,tsquared,explained,mu] = pca(drug_features_normalized);

n_comp = 172;  % 172 component

save 'do_pca.mat'