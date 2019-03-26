function [max_length,max_seq,t_p,len]=task2_2
%Design 2
%Start from (0,0), coordinates may only vary from (0,0) to (10,10)
%Introduce an early termination rate epsilon = 0.1

epsilon = 0.1;

M=10^7;
seq = [0,0];%record the sequence
max_seq = [];%record the longest sequence
max_length = 1;
t_p = [];%record all the trial probablity
len = [];
tic;
for iter = 1:M
    cur_prob = 1;
    seq = [0,0];
    while(1)
        if rand()<=epsilon %early termination
            cur_prob = cur_prob*epsilon;
            break;
        else
            [seq,state,choice] = update_seq1(seq);
            if state == 0
                cur_prob = cur_prob*(1-epsilon);
                break;
            else
                cur_prob = cur_prob*(1-epsilon)/choice;
            end
        end
    end
    
    len = [len size(seq,1)];
    t_p = [t_p cur_prob];
    if length(seq)>max_length
        max_length = size(seq,1);
        max_seq = seq;
    end
    
end
toc;

