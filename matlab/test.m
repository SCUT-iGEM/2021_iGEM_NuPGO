% forbiddenregexp1=seq2regexp(forbiddenseqs{1,2}(1),'Ambiguous',false)
% forbiddenregexp2=seq2regexp(forbiddenseqs{1,2}(2:length(forbiddenseqs{1,2})),'Ambiguous',false)
% strcat(forbiddenregexp1,'(?=',forbiddenregexp2,')');
% sequence='ATCACCCAAAACG';
% regexp(sequence,strcat(forbiddenregexp1,'(?=',forbiddenregexp2,')'))

% Prombeg=74;
% Promend=961;
% Forbiddenseqs={'ACCGTCTCCCCGA', 'CTCCAA','CTTCC','AGGGG'};
% forbiddensites=containsforbidden(sequence,Forbiddenseqs);
% forbiddensize=[13,6,5,5];

% cd('G:\iGEM\matlab');
% load('my_Data.mat');
% maxprom(sequence,Prombeg,Promend,numchanges,forbiddensites,Forbiddenseqs);

% str1=proms{1};
% str18=proms{18};
% find(str1~=str18);
% fastawrite('../IOfile/sequenc1.txt','sequence',str1);
% fastawrite('../IOfile/sequenc18.txt','sequence',str18);

% Pop={};
% Pop{1,1}='ACGAATGTTGTCGAATTGG';
% Pop{2,1}='CCTGAATGATGGAATGTAC';
% newPop=mutate(Pop,0.1,1,19)


%% GA总体图+dif表
% t=2:1001;

% p = plot(t,cell2mat(maxrecord(:,3)));
% hold on
% plot([1 t],cell2mat(maxrecord(:,2)));
% axis([0,ger+1,-100,10]);
% xlabel('generation')
% ylabel('affinity')
% title('Optimization of Promoter Score by adaptive genetic algorithm')
% legend('Average population affinity','Minimum population affinity')

% t1=maxrecord{end,1};
% res={};
% res=[sequence;t1];
% dif=num2str(t1(:)~=sequence(:))';
% res=[res;dif];
% xlswrite('./dif1001.xlsx',res')
%% 
% mydraw(proms,prombeg,promend);

% allDif=[sequence'];
% bpChangeNum=[0];
% for i=2:55
%     lastref=char(proms(i-1));
%     refseq=char(proms(i));
%     
%     dif=refseq(:)~=sequence(:);
%     bpChangeNum=[bpChangeNum sum(dif)];
%     res=[refseq' num2str(dif)];
%     allDif=[allDif res];
% end
%     path=sprintf('./allDif_ver2.0_traditional_parameter=nan.xlsx');
%     xlswrite(path,allDif)
%     path=sprintf('./bpChangeNum_ver2.0_traditional_parameter=nan.xlsx');
%     bpChangeNum=[1:55;bpChangeNum];
%     xlswrite(path,bpChangeNum);
% 
% plot(bpChangeNum(1,:),bpChangeNum(2,:));

%% GA.dif表
% allDif=[sequence'];
% bpChangeNum=[0];
% for i=2:1001
%     lastref=char(maxrecord{i-1,1});
%     refseq=char(maxrecord{i,1});
%     
%     dif=refseq(:)~=sequence(:);
%     bpChangeNum=[bpChangeNum sum(dif)];
%     res=[refseq' num2str(dif)];
%     allDif=[allDif res];
% end
%     path=sprintf('./allDif_ver2.0_GA_parameter=8.18.xlsx');
% %     xlswrite(path,allDif)
%     path=sprintf('./bpChangeNum_ver2.0_GA_parameter=8.18.xlsx');
%     bpChangeNum=[1:1001;bpChangeNum];
% %     xlswrite(path,bpChangeNum);
% 
% plot(bpChangeNum(1,:),bpChangeNum(2,:));


%% GA总体图%%
% t=2:2001;
% p = plot(t,cell2mat(maxrecord(2:2001,3)));
% hold on
% plot([1 t],cell2mat(maxrecord(1:2001,2)));
% axis([0,ger+1,-10000,10]);
% xlabel('generation')
% ylabel('affinity')
% title('Optimization of Promoter Score by adaptive genetic algorithm')
% legend('Average population affinity','Minimum population affinity')
%% GA画affinity图
% drawrecord={};
% for i=1:50:2001
%     drawrecord=[drawrecord;maxrecord{i,1}];
% end
% mydraw(drawrecord,prombeg,promend)

% f=fitness(maxrecord,learningcurve,prombeg,promend);
% plot(f)
% xlabel('generation')
% ylabel('area')
% title('traditional_parameter=8.18')
%% 
temp={};
for i=1:40:2001
    temp=[temp;maxrecord{i,1}];
end


