function newPop = crossover(Pop,pc,prombeg,promend)
    N=size(Pop,1);
    crossN=round(N*pc/2);
    newPop={};
    for i=1:crossN
       order=randperm(N,2);%Index of crossover
       pos=prombeg-1+randperm(promend-prombeg+1,2);%Position of crossover 
       if pos(1)>pos(2)
          pos([2,1])=pos([1,2]);
       end
       x1=Pop{order(1),:};
       x2=Pop{order(2),:};
       tempx1=x1;
       %Execute crossover
       temp=x1(pos(1):pos(2));
       x1(pos(1):pos(2))=x2(pos(1):pos(2));
       x2(pos(1):pos(2))=temp;
       if seqcheck(x1)
            newPop=[newPop;x1];
       end
       if seqcheck(x2)
           newPop=[newPop;x2];
       end
    end
    
end

