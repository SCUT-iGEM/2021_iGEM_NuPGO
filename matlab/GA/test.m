% N=50;%种群上限
% ger=200;%迭代次数
% pc=0.05;%交叉概率
% pm=0.005;%控制变异概率   每个位点变异个概率:pm/2
% load('my_Data2.mat');
% global parent;
% global runsstart;
% global forbiddensites;
% global Forbiddenseqs;
% Pop={};
% % Pop{1,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGAGCAGTAACGATGATGGCTGAAATGTTCAATGTTAAAGATGCAAGATGT';
% % Pop{2,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTATGCCTGTTAAAGATGCATTTTTCATTTTTCATGTATGCCTGTTAAAGATGCATT';
% % Pop{3,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATT';
% % Pop{4,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAATCAAATCTAGAATGGCTGAGAAATCGGAAATAGCAGTATGGAAGTTCATCCTGTGCAGTAACGATGGATAAAGATGCATGCTTT';
% % Pop{5,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATT';
% % Pop{6,1}='TGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATTTTT';
% % Pop{7,1}='CTTTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCA';
% % Pop{8,1}='TTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATTTT';
% % Pop{9,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATT';
% Pop{1,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATT';
% Pop{2,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATT';
% Pop{3,1}='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTGGGTGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAACAAGCAAGGCAGAAACTAACTTCTTCTTCATGTAATAAACACACCCCGCGTTTATTTACCTATCTCTAAACTTCAACACCTTATATCATAACTAATATTTCTTGAGATAAGCACACTGCACCCATACCTTCCTTAAAAACGTAGCTTCCAGTTTTTGGTGGTTCCGGCTTCCTTCCCGATTCCGCCCGCTAAACGCATATTTTTGTTGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTATGTATGCTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAAAAAATGAATAATTTATGAATTTGAGAACAATTTTGTGTTGTTACGGTATTTTACTATGGAATAATCAATCAATTGAGGATTTTATGCAAATATCGTTTGAATATTTTTCCGACCCTTTGAGTACTTTTCTTCATAATTGCATAATATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATCTACTTGCTATCGTTCAACACCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACATTGACGGCACCGTCTCCCCGAGTTTGCATGACGGCACCGTCTCCCCGAGAACATAGGAAAAAAAAATATATAAACAAGGCTCTTTCACTCTCCTTGCAATCAGATTTGGGTTTGTTCCCTTTATTTTCATATTTCTTGTCATATTCCTTTCTCAATTATTATTTTCTACTCATAACCTCACGCAAAATAACACAGTCAAATCAATCAAATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATT';
% 
% for i=1:3
%     newPop=mutate(Pop,pm,prombeg,promend);
%     Pop=[Pop;newPop];
% end
% % newPop=crossover(Pop,1,1,19);
% % fit=fitness(Pop);
% 
% 
% % newPop = crossover(Pop,pc,prombeg,promend);
% % newPop2=crossover(Pop,pc,prombeg,promend);
% % newPop2 = mutate(Pop,pm,prombeg,promend);
% % Pop=[Pop;newPop;newPop2];
% f=fitness(Pop);
% nP=select(Pop,f,5);
% Pop=init(sequence


% Pop=init({sequence},N,prombeg,promend);
% for i=1:50
%     refforbidden=containsforbidden(Pop{i},Forbiddenseqs)
% end


% a={maxrecord{:,2}};
% plot(cell2mat(a))

% t=2:1001;
% p = plot(t,cell2mat(maxrecord(:,3)));
% hold on
% plot([1 t],cell2mat(maxrecord(:,2)));
% axis([0,ger+1,-100,10]);
% xlabel('generation')
% ylabel('affinity')
% title('Optimization of Promoter Score by adaptive genetic algorithm')
% legend('Average population affinity','Minimum population affinity')

% t1='CTTTGGCAAATCTGGAGCAGAACCGTGGCATGGTTCGTACAAACCAAATGCGGTGTTCTTGTCTGGCAAAGAGGCTCGAAGAGCATATGTTCCGCTGATGTGATGTGCAAGATAAATAAGCAAGGGAGAAACTAACTTCTTCTTTATGTAATAAACACACCCCGCGTTTATTTACCTATGTCTAAACTGCAACACCTTATATCATACCTAGTATTTCTTGAGATAAGCACACCGCACCCGTACCTTCCTTAAAAGGGTAGCTTCCAGTTTTTGGTGGTTCCCGCTTCCTTCCCGATTCCGCCCGCGAAACAAATATATTAGTAGCCTGGTGGCATTTGCAAAATGCATAACCTATGCATTTAAAAGATTAAGTATGGTCTTCTGACTTTTCGTGTGATGAGGCTCGTGGAATAAATGAATAAATGATGAATTTGACAACAATTTTGTGTTGTTACGGTATTTTACTAGGCAATAATCAAGCAATGGAGGATTTTATGCGAATTTCGTTTGAATATTTTTCCGATCCTGCGAGTACTTTTCTTCATAATTGCATAGTATTGTCCGCTGCCCCTTTTTCTGTTAGACGGTGTCTTGATGTACTGGCTATCGTTCAACTCCACCTTATTTTCTAACTATTTTTTTTTTAGCTCATTTGAATCAGCTCCAACTCCAACCACAATGACGGCACCGTCTCCCCGACTTTGCCTGACGGCACCGTCTCCCCGAGAACTTAGGAAAAAAAAATATAAAAAAATGGCTCTCTCCCTCTCCTTGCAATTATATTTGGTCTTGTTCCCTTTATTTTCAGATTGCTGGCCATATGGCTGTCTCCATCATTGCTATCCACTCGTCACCTCACTCTAGATAACAAGGTCAAGTCGATCCCATCTAGAATGGCTGAAATGTTCAACGGAAATAGCAGTAACGATGGAAGTTCATGTATGCCTGTTAAAGATGCATT';

% t1=maxrecord{end,1};
% res={};
% res=[sequence;t1];
% dif=num2str(t1(:)~=sequence(:))';
% res=[res;dif];
% xlswrite('./dif1001.xlsx',res')

% for i=1:50
%     refforbidden=containsforbidden(Pop{i},Forbiddenseqs)
% end


% temp=[0 50 100 200 300 400 600]+1;
% temp={maxrecord{temp,1}};
% temp=temp';
% fitness(temp)

% temp={proms{20}};
% temp=[temp;proms{40};proms{60};proms{67}] ;
% t=[20 40 60 67];
% for i=1:4
%     refseq=char(temp(i));
%     
%     dif=refseq(:)~=sequence(:);
%     res=[sequence' refseq' num2str(dif)];
%     path=sprintf('../结果汇总/dif%d.xlsx',t(i));
%     xlswrite(path,res)
% end

% temp={proms{1}};
% for i=5:5:65
%    temp=[temp;proms{i}] ;
% end
% temp=[temp;proms{67}];
% fitness(proms');

% allDif=[sequence'];
% bpChangeNum=[0];
% for i=2:1001
%     lastref=char(maxrecord(i-1));
%     refseq=char(maxrecord(i));
%     
%     dif=refseq(:)~=sequence(:);
%     bpChangeNum=[bpChangeNum sum(dif)];
%     res=[refseq' num2str(dif)];
%     allDif=[allDif res];
% end
%     path=sprintf('./allDif_ver1.2_1001_pm=0.0025.xlsx');
%     xlswrite(path,allDif)
%     path=sprintf('./bpChangeNum_ver1.2_1001_pm=0.0025.xlsx');
%     bpChangeNum=[0:1000;bpChangeNum]
%     xlswrite(path,bpChangeNum);

% plot(bpChangeNum(1,:),bpChangeNum(2,:))


% allAffinity=[];
% for i=1:67
%     path=sprintf('G:/iGEM/IOfile/Rfile/temp%d.fasta_Prediction4.txt',i);
%     data=readmatrix(path);
%     allAffinity=[allAffinity data(:,5)];
% end
% xlswrite('./allAffinity.xlsx',allAffinity);


% allDif=
% for i=2:1001
% 	temp=[temp;maxrecord{i,1}];
% end
% f=fitness(temp)

% sequence='ATATCTCTGATTTCGTCGATCAGAATTTCTCTATGCTTATGGTACGAAGAATCACTATATGGAGAGTTCAAACTTTGTATGAAATCATCAGTCCACAAATTAGGATGGTGGTTTCCAGTACGTCTTAATGCATCTTTAACAGGCATACATGAACTTCCATCGTTACTGCTATTTCCGTTGAACATTTCAGCCATTCTAGATTTGATTGATTTGACTGTGTTATTTTGCGTGAGGTTATGAGTAGAAAATAATAATTGAGAAAGGAATATGACAAGAAATATGAAAATAAAGGGAACAAACCCAAATCTGATTGCAAGGAGAGTGAAAGAGCCTTGTTTATATATTTTTTTTTCCTATGTTCTCGGGGAGACGGTGCCGTCATGCAAACTCGGGGAGACGGTGCCGTCAATGTGGTTGGAGTTGGAGCTGATTCAAATGAGCTAAAAAAAAAATAGTTAGAAAATAAGGTGGTGTTGAACGATAGCAAGTAGATCAAGACACCGTCTAACAGAAAAAGGGGCAGCGGACAATATTATGCAATTATGAAGAAAAGTACTCAAAGGGTCGGAAAAATATTCAAACGATATTTGCATAAAATCCTCAATTGATTGATTATTCCATAGTAAAATACCGTAACAACACAAAATTGTTCTCAAATTCATAAATTATTCATTTTTTCCACGAGCCTCATCACACGAAAAGTCAGAAGAGCATACATAATCTTTTAAATGCATAGGTTATGCATTTTGCAAATGCCACCAGGCAACAAAAATATGCGTTTAGCGGGCGGAATCGGGAAGGAAGCCGGAACCACCAAAAACTGGAAGCTACGTTTTTAAGGAAGGTATGGGTGCAGTGTGCTTATCTCAAGAAATATTAGTTATGATATAAGGTGTTGAAGTTTAGAGATAGGTAAATAAACGCGGGGTGTGTTTATTACATGAAGAAGAAGTTAGTTTCTGCCTTGCTTGTTTATCTTGCACATCACATCAGCGGAACATATGCTCACCCAGGGATCCCCGGGTACCGAGCTCGAATTCACTGGCCGTCGTTTTACAACGTCGTGACTGGGAAAACCCTGGCGTTACCCAACTTAATCGCCTTGCAGCACAT';
% prombeg=201;
% promend=1012;
% Forbiddenseqs={'CTCGGGGAGACGGTGCCGTC', 'GTTGGAGTTGGAG', 'AGGGG', 'GGAAG', 'TTTGATTGATTTGACTGTGTTATTTTGCGTGAGGTTATGAGTAGAAAATAATAATTGAGAAAGGAATATGACAAGAAATATGAAAATAAAGGGAACAAACCCAAATCTGATTGCAAGGAGAGTGAAAGAGCCTTGTTTAT'};
% forbiddensites=containsforbidden(sequence,Forbiddenseqs);
% fitness({sequence;sequence})

% temp={};
% for i=1:30:3001
%     temp=[temp;maxrecord{i,1}];
% end

%% 图片样式
% 先出上面图，再出下面图(挨个出图)
% subplot(1,2,2)
% 
% plot(data_model(:,7),data_model(:,8),'-k','linewidth',1.5)
% hold on
% plot(data_experiment(:,7),data_experiment(:,8),'o','markersize',9)
% hold on
% plot(data_model(:,9),data_model(:,10),'-r','linewidth',1.5)
% hold on
% plot(data_experiment(:,9),data_experiment(:,10),'s','markersize',10)
% 
% 
% axis([0 900 0 0.06])
% legend('Location','northeast')
% legend('Model-150MPa','Exp-150MPa','Model-175MPa','Exp-175MPa')
% set(gca,'FontName','Times New Roman','FontSize',13,'LineWidth',1.5)
% xlabel('time(h)')
% ylabel('creep strain')
% set(gcf, 'Color', [1,1,1])
% 
% 
% box off
% ax2 = axes('Position',get(gca,'Position'),...
%            'XAxisLocation','top',...
%            'YAxisLocation','right',...
%            'Color','none',...
%            'XColor','k','YColor','k','linewidth',1.5);
% set(ax2,'YTick', []);
% set(ax2,'XTick', []);
% box on

% temp={};
% for i=1:3:157
%     temp=[temp;proms{i}];
% end
% learningcurve=affinity(sequence);
% learningcurve=learningcurve(1:25);

% R_text=["rm(list = ls())\nlibrary(xlsx)\nlibrary(NuPoP)\ngetwd()  #获取文件存储位置\nsetwd(","G:/iGEM/IOfile/Rfile",") #设置新的路径`，将文件放入该文件夹中\nifile='G:/iGEM/IOfile/proms.xlsx'\n\n##===================设置输入+数据格式转换===================\n##input = readline(prompt=","请输入总的csv文件路径",")\nread_list = read.xlsx(ifile,1,header=FALSE)\nread_matrix = matrix(unlist(read_list))\nread_frame = data.frame(read_matrix)\nnames(read_frame)[1] = ","n/","\nlen = lengths(read_list)\n##===================分别写入成txt+修改成fasta===================\n##分别写入txt\nfor (i in 1:len){\n  write.table(read_frame[i,1], file=paste("G:/iGEM/IOfile/Rfile/temp",as.character(i),".txt",sep=""), quote=FALSE, row.names=FALSE, col.names=FALSE)\n}\n##修改成fasta\nfolder = getwd()\nfiles = list.files(folder)\nfor (f in files){\n  newname = sub(".txt",".fasta",f)\n  file.rename(f,newname)\n}\n##===================开始了！===================\n# if (!requireNamespace("BiocManager", quietly = TRUE))\n#  install.packages("BiocManager")\n#BiocManager::install("NuPoP")\n\n\noutput = matrix(0,967,len)\ndata = list()\nmudata = list()\npredNuPoP =list()\n\n\nfor (i in 1:len){\n  rm("predNuPoP","data","mydata")\n  library(NuPoP)\n  predNuPoP(file=paste("G:/iGEM/IOfile/Rfile/temp",as.character(i),".fasta",sep=""),species=7,model=4)\n  predNuPoP=function(file,species=7,model=4)\n  {\n    \n    ## ====================================================================================================\n    ## Purpose: This function is a wrapper of Fortran codes for prediction of nucleosome positioning\n    ## input:   file    --- a string specifying the file name of DNA sequence in FASTA format\n    ##          species --- an integer between 0 and 10 to specify which organism the DNA sequence is from.\n    ##                      The default is set as 7 for Yeast. \n    ##          model   --- 1 or 4, specifying the order of Markov models to be used in the\n    ##                      duration Hidden Markov model.\n    ## output:  a result file in text format is output to the current working directory.\n    ## ==================================================================================================\n    \n    file=as.character(file); n=nchar(file); maxlen=500; maxlen=as.integer(maxlen)\n    species=as.integer(species); model=as.integer(model)\n    rep=1; rep=as.integer(rep); ind=0\n    file_name_num=as.integer(charToRaw(file))\n    \n    \n    if(model==1){\n      results=.Fortran("vtbfb",n,as.integer(file_name_num),freqL,tranL,freqN,tranN,maxlen,rep,species,Pd,ind=as.integer(ind),PACKAGE = "NuPoP")\n      ind=results$ind\n      if(ind==0){\n        FilePath=getwd()\n        parts=strsplit(file,"/")[[1]]\n        cat(paste("Prediction output: '"), FilePath, "/", parts[length(parts)],"_Prediction1.txt'",sep="")\n      }\n    } else if(model==4){\n      results=.Fortran("vtbfbNL4",n,as.integer(file_name_num),freqL,tranL,tranL2,tranL3,tranL4,freqN4,tranN4,maxlen,rep,species,Pd,ind=as.integer(ind),PACKAGE = "NuPoP")\n      ind=results$ind\n      if(ind==0){\n        FilePath=getwd()\n        parts=strsplit(file,"/")[[1]]\n        cat(paste("Prediction output: '"), FilePath, "/", parts[length(parts)],"_Prediction4.txt'",sep="")\n      }\n    } else if(model!=1 && model!=4){\n      stop("'model' should be 1 or 4 only; exit!")\n    }\n    \n    if(ind==1){\n      print("In current directory, the input file does not exist, stop!")\n    } else if(ind==2){\n      print("The input file is not in FASTA format, or contains characters other than A/a, C/c, G/g, T/t, N/n, stop!")\n    } else if(ind==3){\n      print("The input species label is incorrectly specificed. It should be an integer from 0 to 10!")\n    }\n  }\n  data=readNuPoP(paste("G:/iGEM/IOfile/Rfile/temp",as.character(i),".fasta","_Prediction4.txt",sep=""),startPos=1,endPos=1113)\n  ##===================裁剪positon+作图+输出图片===================\n  mydata = data[c(74:1040),c(1,5)]\n  #jpeg(file = paste("plot",as.character(i),".jpg",sep=""))\n  #plot(mydata$Position, mydata$Affinity, type="b", pch=20, cex=0.5, lty=1 ,lwd=1)\n  #abline(h=0, col="red")\n  #dev.off()\n  ##===================输出评分+写入文件===================\n  output[,i] = mydata$Affinity\n}\n\n##write.csv(list, file = "D:/code/iGEM/temp/socre.csv",quote = TRUE, \n##            eol = "\n", na = "NA", row.names = TRUE,\n##            fileEncoding = "")\n\nwrite.table(output, file = "G:/iGEM/IOfile/Rfile/output.txt", \n            sep=" ", row.names=FALSE,  col.names=FALSE)"
% text = fileread("G:/iGEM/R/fitnessTemplate.txt");
% text=sprintf(text,promend-73-72,promend-73);
% fid=fopen("G:/iGEM/R/fitness3.R",'wb');
% fwrite(fid,text);
% fclose(fid);

%% 所有结果跑完，得最后结果
temp={};
for i=1:60:3001
    temp=[temp;maxrecord{i}];
end
getResult(temp,'HXT',prombeg,promend);
