% this function is used to calculate the result by combining several svdd
% result data.  and choose the nearest to the thredshold as its distance
% and 0 as its threshold value.  it is not implemented as a prmapping. (but
% it should). it's just a normal function.
function data = nearestcc(a,w)
nd = size(a,1);
n = length(w);
% calculate the results of all classifier
val = [];% this stores distance results
for i=1:n
    d = a*w{i};
    val(:,i) = d.data(:,1)-d.data(:,2); % higher than 0 means it's a target
end
data_v = zeros(nd,2);
data_v(:,1) = max(val,[],2); % if at least one classifier accepts it, we accept it.

data = d; % we just use the struct
data.data  = data_v; % and we specifies the results here
end

