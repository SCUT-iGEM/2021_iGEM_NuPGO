function  f=fitness(Pop,learningcurve,prombeg,promend)
global RPath;
global dirPath;

f=zeros(size(Pop));
delete('../../IOfile/Rfile/*')
path='../../IOfile/proms.xlsx';
delete(path);
fastaWrite(Pop,path);
odr=sprintf('"%s" --no-save --slave < %s\\R\\fitness2.R',RPath,dirPath);
system(odr);
affinities=load('../../IOfile/Rfile/output.txt');
for i=1:size(affinities,2) % Resetting the score
    [f(i),~]=seqarea(learningcurve,affinities(:,i),prombeg-73,promend-73);
end
end

