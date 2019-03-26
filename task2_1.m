function [max_length,max_seq,t_c,len]=task2_1
%Design 1
%Start from (0,0), coordinates may only vary from (0,0) to (10,10)
%End only when there's nowhere to go
M=10^7;
seq = [0,0];%record the sequence
max_seq = [];%record the longest sequence
max_length = 1;
t_c = [];%record all the trial choices
len = [];

tic;
for iter = 1:M
    if(rem(iter,10000) == 0)
        iter
    end
cur_choice = 1;
seq = [0,0];
while(1)
    [seq,state,choice] = update_seq1(seq);
    if state == 0
        break;
    else
        cur_choice = cur_choice*choice;
    end
end

len = [len size(seq,1)];
t_c = [t_c cur_choice];
if length(seq)>max_length
    max_length = size(seq,1);
    max_seq = seq;
end

end
toc;

