function Pop = init(seq,N,prombeg,promend)
    Pop={};
    Pop=[Pop;seq];
    while(length(Pop)<N)
       newseq=mutate(seq,0.05,prombeg,promend);
       Pop=[Pop;newseq];
    end
end

