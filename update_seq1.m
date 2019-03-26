function [output,state,choice] = update_seq1(seq)
% return state 0 when the sequence teminates and 1 it continues to grow
%Representing the moves to left/right/up/down by the numbers 1,2,3,4 respectively
state = 1;

cur_point = seq(end,:);

usa_point=[];

if (0 <= cur_point(1,1)+1 && cur_point(1,1)+1 <= 10 && find_pre(seq,[cur_point(1,1)+1,cur_point(1,2)]) == 1)
    usa_point = [usa_point;[cur_point(1,1)+1,cur_point(1,2)]];
end

if (0 <= cur_point(1,1)-1  && cur_point(1,1)-1 <= 10 && find_pre(seq,[cur_point(1,1)-1,cur_point(1,2)]) == 1)
    usa_point = [usa_point;[cur_point(1,1)-1,cur_point(1,2)]];
end

if (0 <= cur_point(1,2)+1 && cur_point(1,2)+1 <= 10 && find_pre(seq,[cur_point(1,1),cur_point(1,2)+1]) == 1)
    usa_point = [usa_point;[cur_point(1,1),cur_point(1,2)+1]];
end

if (0 <= cur_point(1,2)-1 && cur_point(1,2)-1 <= 10 && find_pre(seq,[cur_point(1,1),cur_point(1,2)-1]) == 1)
    usa_point = [usa_point;[cur_point(1,1),cur_point(1,2)-1]];
end

if (isempty(usa_point))
    state = 0;
    output = seq;
    choice = 1;
else
    sel = ceil(rand()*size(usa_point,1));
    output = [seq;usa_point(sel,:)];
    choice = size(usa_point,1);
end
    
end