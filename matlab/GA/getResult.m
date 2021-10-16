function getResult(Pop,name,prombeg,promend)
rewriteR(promend)
%% Select 50 sequences in Pop
Pop2={};
N1=length(Pop);
for i=1:floor(N1/50):N1
    Pop2=[Pop2;Pop{i}];
end
Pop=Pop2;
N=length(Pop);
% draw dif table
allDif=[Pop{1}'];
bpChangeNum=[0];

dirName="./"+name;

if ~exist(dirName)  
    mkdir(dirName)
end

for i=2:N
    lastref=char(Pop{i-1,1});
    refseq=char(Pop{i,1});
    dif=refseq(:)~=Pop{1}(:);
    bpChangeNum=[bpChangeNum sum(dif)];
    res=[refseq' num2str(dif)];
    allDif=[allDif res];
end

path=sprintf("%s%s%s%s",dirName,'/allDif_',name,'.xlsx');
xlswrite(path,allDif)
path=sprintf("%s%s%s%s",dirName,'/bpChangeNum_',name,'.xlsx');
bpChangeNum=[1:N;bpChangeNum];
xlswrite(path,bpChangeNum);
plot(bpChangeNum(1,:),bpChangeNum(2,:));
path=sprintf("%s%s%s%s",dirName,'./','bpChangeNum','.jpg');
saveas(gcf,path);
%Drawing epoch result and aggregate result
mydraw(Pop,prombeg,promend,name);

end

