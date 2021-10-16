function clearfasta(ReadFilePath,WriteFilePath)

global dirPath;
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
delfile=sprintf("%s%s%s%s",'"',dirPath,'\IOfile\sequence1.fasta','"');
system('del '+delfile);
end