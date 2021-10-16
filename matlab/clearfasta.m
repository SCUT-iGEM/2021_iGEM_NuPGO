function clearfasta(ReadFilePath,WriteFilePath)
% Function for removing the blank lines in file
FidRead=fopen(ReadFilePath,'rb','ieee-le','UTF-8');
FidWrite=fopen(WriteFilePath,'wb','ieee-le','UTF-8');
while ~feof(FidRead)
    FileRowStr = fgetl(FidRead);
    if ~isempty(FileRowStr )
    fprintf(FidWrite,'%s\n',FileRowStr);
    end
end
fclose(FidRead);
fclose(FidWrite);
delete G:\iGEM\IOfile\sequence1.fasta
end