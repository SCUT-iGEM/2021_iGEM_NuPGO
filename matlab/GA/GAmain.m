%% This is the main script of NuPGO

%% You can directly save the parameters
%% as mat matrix to import when using
load('my_Data2.mat')
%% Declare Variable
global parent;
global runsstart;
global forbiddensites;
global Forbiddenseqs;
global RPath;
global dirPath;
%% Path configuration
RPath='G:\R\R\R-4.1.0\bin\R.exe';
dirPath='G:\proNuGO';

%% Initial information parameters
%% Replace with your own initial parameters
sequence='ATATCTCTGATTTCGTCGATCAGAATTTCTCTATGCTTATGGTACGAAGAATCACTATATGGAGAGTTCAAACTTTGTATGAAATCATCAGTCCACAAATTAGGATGGTGGTTTCCAGTACGTCTTAATGCATCTTTAACAGGCATACATGAACTTCCATCGTTACTGCTATTTCCGTTGAACATTTCAGCCATTCTAGATTTGATTGATTTGACTGTGTTATTTTGCGTGAGGTTATGAGTAGAAAATAATAATTGAGAAAGGAATATGACAAGAAATATGAAAATAAAGGGAACAAACCCAAATCTGATTGCAAGGAGAGTGAAAGAGCCTTGTTTATATATTTTTTTTTCCTATGTTCTCGGGGAGACGGTGCCGTCATGCAAACTCGGGGAGACGGTGCCGTCAATGTGGTTGGAGTTGGAGCTGATTCAAATGAGCTAAAAAAAAAATAGTTAGAAAATAAGGTGGTGTTGAACGATAGCAAGTAGATCAAGACACCGTCTAACAGAAAAAGGGGCAGCGGACAATATTATGCAATTATGAAGAAAAGTACTCAAAGGGTCGGAAAAATATTCAAACGATATTTGCATAAAATCCTCAATTGATTGATTATTCCATAGTAAAATACCGTAACAACACAAAATTGTTCTCAAATTCATAAATTATTCATTTTTTCCACGAGCCTCATCACACGAAAAGTCAGAAGAGCATACATAATCTTTTAAATGCATAGGTTATGCATTTTGCAAATGCCACCAGGCAACAAAAATATGCGTTTAGCGGGCGGAATCGGGAAGGAAGCCGGAACCACCAAAAACTGGAAGCTACGTTTTTAAGGAAGGTATGGGTGCAGTGTGCTTATCTCAAGAAATATTAGTTATGATATAAGGTGTTGAAGTTTAGAGATAGGTAAATAAACGCGGGGTGTGTTTATTACATGAAGAAGAAGTTAGTTTCTGCCTTGCTTGTTTATCTTGCACATCACATCAGCGGAACATATGCTCACCCAGGGATCCCCGGGTACCGAGCTCGAATTCACTGGCCGTCGTTTTACAACGTCGTGACTGGGAAAACCCTGGCGTTACCCAACTTAATCGCCTTGCAGCACAT';
Forbiddenseqs={'CTCGGGGAGACGGTGCCGTC','GTTGGAGTTGGAG','AGGGG'};
prombeg=201;
promend=1013;


%% Hyper-parameters in Genetic Algorithm
N=50;%Population quantity	50 was recommended, while you can turn it up to expand search.
ger=3000;%Number of iterations	500 to 3000 was recommended, while the suited value is decided by convergence situation.
pc=0.1;%Probability of crossover	Default value is 0.1, while you can tune according to the length of promoter sequence.
pm=0.005;%Probability of mutation, while the probability is pm/2 on each site	We set 0.005 as default, while you can tune according to the length of promoter sequence.


%% Automatically rewrite the R script with the input parameters as above
rewriteR(promend);
rewriteR_NuPoP();

%% Learningcurve is used for rescaling from NuPoP, and maxrecord would record the information during GA iterations
learningcurve=affinity(sequence);
maxrecord={sequence,sum(learningcurve(prombeg-73:promend-73)),[]};
learningcurve=learningcurve(1:25);
t=[0];
%% Variable setting
forbiddenruns={'AAAAAAAAA','CCCCCC','TTTTTTTTT','GGGGGG'};  %Sequences illegal for IDT
runsstart=containsforbidden(sequence,forbiddenruns); %Locating sequences forbidden by user, except for appearance in origion sequence
forbiddensites=containsforbidden(sequence,Forbiddenseqs); %Transforming forbidden sequence into position
parent=sequence;


%% Initialize population and figure window
Pop=init({sequence},N,prombeg,promend);%Initialize population
record={};%Help recording information
p = plot(t,cell2mat(maxrecord(:,2)),'EraseMode','background','MarkerSize',5);%Initialize the figure window
axis([0,ger+1,-15000,10]);
xlabel('generation')
ylabel('Aggregate affinity score')
title('Promoter Optimization With Adaptive Genetic Algorithm')


%% Main body of genetic algorithm
for i=1:ger
    
    newP1=mutate(Pop,pm,prombeg,promend);%Obtain a part of new population through mutation
    Pop=[Pop;newP1];%Merging into population
    newP2=crossover(Pop,pc,prombeg,promend);%Obtain a part of new population through crossover
    Pop=[Pop;newP2];
    f=fitness(Pop,learningcurve,prombeg,promend);%Predicting the affinity score of each variant in population by R script with rescaling
	
    [minf,ind]=min(f); %Finding the individual with lowest DNA nucleosome affinity
    aver=mean(f); %Computing the average affinity score in this round
    record{1,1}=Pop{ind}; %Recoding the best sequence with lowest affinity in this population
    record{1,2}=minf; %Recoding the best score value
    record{1,3}=aver; %Recoding the average score value
    
    maxrecord=[maxrecord;record]; %Recoding the generation information
    
    Pop=select(Pop,f,N); %Roulette wheel is used to select N individuals according the wheel rules
    
    t=[t i];
    set(p,'XData',t,'YData',cell2mat(maxrecord(:,2)));
    drawnow
    pause(0.01);
end
save('maxrecord.mat'); %Program finished and all the information would be saved in this file.
