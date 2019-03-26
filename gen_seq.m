function [cur_prob,seq]=gen_seq(seq,cur_prob)

while(1)    
    [seq,state,choice] = update_seq1(seq);
    if state == 0
        break;
    else
        cur_prob = cur_prob/choice;
    end
end

end