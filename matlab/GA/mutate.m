function newPop = mutate(Pop,pm,prombeg,promend)
global forbiddensites;
global Forbiddenseqs;
N=size(Pop,1);%种群数量 %Population quantity
nucleo='ACTG';
newPop={};
for i=1:N
    %%
    %Ensure the mutation site
    x=round((promend-prombeg+1)*pm*rand(1));%The bp number of mutation
    if x<=0
        continue;
    end
    mutatePos=prombeg-1+randperm(promend-prombeg+1,x);%The mutation site
    randnum=randi(4,1,x);
    mutateNuc=nucleo(randnum(:));%Nucleotide after mutation
    %%
    %Execute mutation
    newIndividual=Pop{i};
    for j=1:x
        flag=1;
        pos=mutatePos(j);
        
        for k=1:length(forbiddensites)
            if(isempty(forbiddensites{k}))
                continue
            end
            len=length(Forbiddenseqs{k});
            for l=1:length(forbiddensites{k})
                if(pos>=forbiddensites{k}(l)&&pos<=forbiddensites{k}(l)+len-1)
                    flag=0;
                end
            end
        end
        
        if flag==1
            newIndividual(mutatePos(j))=mutateNuc(j);
        end
    end
    if seqcheck(newIndividual)
        newPop=[newPop;newIndividual];
    end
end
end

