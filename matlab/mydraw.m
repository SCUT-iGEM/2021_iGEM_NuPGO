function  mydraw(Pop,prombeg,promend)%Function to draw epoch result and aggregate result
%The content located in the first row and first column of the table Pop is the best sequence
    f=[];
    hold off;
    delete('G:/iGEM/IOfile/Rfile/*')
    path='G:/iGEM/IOfile/proms.xlsx';
    delete(path);
    fastaWrite(Pop,path);
    system('"G:\R\R\R-4.1.0\bin\R.exe" --no-save --slave < G:\iGEM\R\fitness2.R');
    affinities=load('G:/iGEM/IOfile/Rfile/output.txt');
    learningcurve=affinities(1:25,1);
    for i=1:size(affinities,2) % Resetting the affinity score
        [f(i),affinities(:,i)]=seqarea_0(learningcurve,affinities(:,i),prombeg-73,promend-73);
    end
    %% epoch result figure
    standardx=[0 1113];
    srandardy=[0 0];
    y=affinities;
    x=[1:length(y)];
    hold on
    for i=1:size(y,2)
        plot(x,y(:,i),standardx,srandardy,'-r','LineWidth',1);
    end
    axis([0 1113 -14 4]);
    xlabel('bpnum');
    ylabel('affinity');
    title('Traditional-parameter=nan');
   
    
end

