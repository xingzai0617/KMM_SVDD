% addpath(genpath('D:\LX\xiaofu-data\oneclass'));
a = gendatb([50 50]);
aoc = oc_set(a,'1');
[t_aoc, o_aoc]= target_class(a,'1');
scatterd(t_aoc);
%rej=0.2;sigma=1;w = svdd(t_aoc,rej,sigma); plotc(w,'r');
%rej=0.2;sigma=2;w = svdd(t_aoc,rej,sigma); plotc(w,'g');
rej=0.1 ;
sigma=4;
w = svdd(t_aoc,rej,sigma); 

plotc(w,'b');
res = t_aoc*w;
e1=dd_error(res);
res.data
e1
sum(res.data(:,1)>res.data(:,2))/size(res.data,1)
%rej=0.2;sigma=8;w = svdd(t_aoc,rej,sigma); plotc(w,'y');
