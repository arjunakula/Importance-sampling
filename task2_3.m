function [max_length,max_seq,t_p,len]=task2_3
%Design 3
%Start from (0,0), coordinates may only vary from (0,0) to (10,10)
%We favor long walks. For walkslonger than 50, we generate u = 5 more children
%based on it and reweigh each of the children by w0 = w/u.

M = 10^7;
seq = [0,0];%record the sequence
max_seq = [];%record the longest sequence
max_length = 1;
t_p = [];%record all the trial probablity
len = [];
u = 5;
tic;
while(length(t_p)<=M)
    cur_prob = 1;
    seq = [0,0];
    [cur_prob,seq] = gen_seq(seq,cur_prob);
    if size(seq,1) >= 50
        cur_prob = cur_prob*u;
        len = [len size(seq,1) size(seq,1) size(seq,1) size(seq,1) size(seq,1)];
        t_p = [t_p cur_prob cur_prob cur_prob cur_prob cur_prob];
        if length(seq)>max_length
            max_length = size(seq,1);
            max_seq = seq;
        end
    else
        len = [len size(seq,1)];
        t_p = [t_p cur_prob];
        if length(seq)>max_length
            max_length = size(seq,1);
            max_seq = seq;
        end
    end
       
end

toc;
% [histw, intervals] = histwc(d, f, 12); 
% bar(intervals, histw)

% while(length(t_p)<=M)
%     cur_prob = 1;
%     seq = [0,0];
%     while(1)
%         [seq,state,choice] = update_seq1(seq);
%         if state == 0
%             break;
%         else
%             cur_prob = cur_prob/choice;
%         end
%         if size(seq,1) >= 50
%             for jter = 1:(u-1)
%                 [cur_prob_t,seq_t]=gen_seq(seq,cur_prob);
%                 cur_prob_t = cur_prob_t*u;
%                 len = [len size(seq_t,1)];
%                 t_p = [t_p cur_prob_t];
%                 if length(seq_t)>max_length
%                     max_length = size(seq_t,1);
%                     max_seq = seq_t;
%                 end
%             end
%             [cur_prob,seq]=gen_seq(seq,cur_prob);
%             cur_prob = cur_prob*u;
%             break;
%         end
%     end
%
%     len = [len size(seq,1)];
%     t_p = [t_p cur_prob];
%     if length(seq)>max_length
%         max_length = size(seq,1);
%         max_seq = seq;
%     end
%
% end


