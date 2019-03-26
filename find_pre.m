function state = find_pre(seq,point)
% return state 1 when the new point is usable

state = 1;

for iter = 1:size(seq,1)
    
if(point(1,1) == seq(iter,1) && point(1,2) == seq(iter,2))
    state = 0;
    break;
end

end

end