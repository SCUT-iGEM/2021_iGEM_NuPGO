function  mydraw(Pop,prombeg,promend,name)%Function to draw epoch result and aggregate result
%The content located in the first row and first column of the table Pop is the best sequence
global RPath;
global dirPath;
f=[];
hold off;
delete('../../IOfile/Rfile/*')
path='../../IOfile/proms.xlsx';
delete(path);
fastaWrite(Pop,path);

odr=sprintf('%s --no-save --slave < %s\\R\\fitness2.R',RPath,dirPath);
system(odr);
affinities=load('../../IOfile/Rfile/output.txt');
learningcurve=affinities(1:25,1);
for i=1:size(affinities,2) % Resetting the affinity score
    [f(i),affinities(:,i)]=seqarea_0(learningcurve,affinities(:,i),prombeg-73,promend-73);
end
%% epoch result figure and aggregate curves to one figure

y=affinities;
x=[1:length(y)];
standardx=[0 length(y)];
srandardy=[0 0];
figure(2)
hold on
for i=1:size(y,2)
    plot(x,y(:,i),standardx,srandardy,'-r','LineWidth',1);
end
axis([0 length(y) -14 4]);
xlabel('bpnum');
ylabel('affinity');
title(name);
saveas(gcf,['./',name,'/',name,'_0verall','.jpg']);

end

