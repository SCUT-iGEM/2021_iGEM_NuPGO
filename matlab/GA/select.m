function newPop = select(Pop,f,N)
% Roulette wheel selection and predominant population reservation.
% Select the candidate with low auc which means low histone affinity
    f=-f;
    f(:)=f(:)-min(f(:));
    total=sum(f(:));
    f(:)=f(:)/total;
    
    [~,temp]=max(f);
    x=[temp(1)];%Reserving predominant population
    
    f=cumsum(f);
    rdm=rand(1,N);
    for i=1:N-1
        temp=find(f>=rdm(i));
        x=[x;temp(1)];
    end
    newPop={};
    for i=1:N
       newPop=[newPop;Pop{x(i),1}]; 
    end
end

