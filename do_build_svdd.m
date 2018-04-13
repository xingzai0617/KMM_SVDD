% setmyenv;
load('do_kmeans.mat','results');

% these two variable would be used in the subroutine
k = 3;
fracrej = 0.2;
for fracrej = 0.2:0.1:0.6
    disp(sprintf('fracrej %.2f.....',fracrej));
    build_one_svdd;
end