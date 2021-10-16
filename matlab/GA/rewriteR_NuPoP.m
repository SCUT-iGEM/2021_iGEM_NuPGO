function rewriteR_NuPoP()
global dirPath;
text = fileread("../../R/NuPoPTemplate.txt");
Rpath=replace([dirPath,'\IOfile'],'\','/');
text=sprintf(text,Rpath);
fid=fopen("../../R/NuPoP.R",'wb');
fwrite(fid,text);
fclose(fid);
end

