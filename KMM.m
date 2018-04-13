t1 = clock;

load('drug_1441.mat');
load('drugdata1.mat');load('drugdata2.mat');load('drugdata3.mat');
B=[drugdata1;drugdata2;drugdata3];
A=drug_1441;
%B=drugdata1;
A_feature=A(:,2:1665);
A_ind=A(1,:);
B_feature=B(:,2:1665);
B_ind=B(1,:);
%rbf kernel,sigma=0.5
% sigma = 0.5;
% rows = size(A_feature,1);
% columns= size(A_feature,1);
% tmpMatrix = zeros(rows,columns);
% for iRow = 1:rows
%     for jColumn = 1:columns
%         tmpMatrix(iRow,jColumn) = norm(A_feature(iRow,:)-A_feature(jColumn,:));
%     end
% end
% K1= exp(-0.5 * (tmpMatrix/sigma).^2);
% rows = size(A_feature,1);
% columns= size(B_feature,1);
% tmpMatrix = zeros(rows,columns);
% for iRow = 1:rows
%     for jColumn = 1:columns
%         tmpMatrix(iRow,jColumn) = norm(A_feature(iRow,:)-B_feature(jColumn,:));
%     end
% end
% K2= exp(-0.5 * (tmpMatrix/sigma).^2);
K=A_feature*A_feature';
K2=A_feature*B_feature';
m=size(A_feature,1);
n=size(B_feature,1);
for i=1:m
    g(i)=0;
    for j=1:n
        g(i)=g(i)+K2(i,j);
    end
end
beta0=zeros(1441,1);
g=-g*2/(m*n);
K=K*2/(m^2);
% f=@(beta)beta'*K*beta+g'*beta
l=zeros(1441,1);
u=1.2*ones(1441,1);
P=1.2/m*ones(m,m);
b=1*ones(m,1);
B=1/m*zeros(m,m);
c=zeros(m,1);
[x,fval,exitflag,output,lambda]=quadprog(K,g',P,b,B,c,l,u,[],[]);
count=size(x,1);
j=1;
for k=1:count
    if x(k,1)>0.2
        drug_1441_tr(j,:)=A(k,:);
        j=j+1;
    end
end
save 'drug_1441_tr.mat'

t2 = clock;
etime(t2,t1)