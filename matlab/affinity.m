function affinities=affinity(sequence)
%takes 'sequence' and computes nucleosome affinity values for each
%nucleotide.

%'sequence' is simply a string of nucleotides in uppercase.

filepath1='G:\iGEM\IOfile\sequence1.fasta';
filepath2='G:\iGEM\IOfile\sequence.fasta';
fastawrite(filepath1,'sequence',sequence);
%makes a FASTA-formatted text file containing the DNA sequence.  This
%function is part of the bioinformatics toolbox

%%
%Deleting the redundant blank lines in fasta files.
clearfasta(filepath1,filepath2);

%%

%system('Npred2 sequence.txt 4 7');
system('"G:\R\R\R-4.1.0\bin\R.exe" --no-save --slave < G:\iGEM\R\NuPoP.R');

% system('Npred2 sequence.txt 4 1');
%Uses Npred2 to calculate the nucleosome affinities at each base.  This
%MATLAB script forces a 4th-order Markov model and uses data for S. cerevisiae.
%In this command, '4' designates the order of the Markov model and '7' designates the
%organism (in this case, yeast).  Other organisms are found in the manual for NuPoP_F.

%Note that Npred2 must be added to the system path for this script to run.
%If it is not, simply edit the above system command to point to the right
%directory.

%Npred2 is nearly equivalent to the script 'Npred' published in the below reference,
%the only difference being the ability to accept variables from the command
%line.  See the attached Readme

%Xi, L., Fondufe-Mittendor, Y., Xia, L., Flatow, J., Widom, J. and Wang, J.-P., 
%Predicting nucleosome positioning using a duration Hidden Markov Model, 
%BMC Bioinformatics, 2010, doi:10.1186/1471-2105-11-346.

% sysstr=sprintf('del %s',filepath2);
% system(sysstr);
system('del G:\iGEM\IOfile\sequence.fasta');
%deletes temp input file

fid=fopen('../IOfile/sequence.fasta_Prediction4.txt');
data=textscan(fid,'%s %s %s %s %s');
fclose(fid);
system('del "G:\iGEM\IOfile\sequence.fasta_Prediction4.txt"');
%gets data from temp output file and deletes the file

affin=str2double(data{1,5}(2:length(data{1,5}),1));
%makes a vector of affinities from extracted data

affinities=affin(~isnan(affin));
%removes NaNs from affinity