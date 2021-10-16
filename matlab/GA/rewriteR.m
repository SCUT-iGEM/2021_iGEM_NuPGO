function rewriteR(promend)
global dirPath;
text = fileread("../../R/fitnessTemplate.txt");
Rpath=replace([dirPath,'\IOfile'],'\','/');
text=sprintf(text,Rpath,promend+100-73-73,promend+100,promend+100-73);
fid=fopen("../../R/fitness2.R",'wb');
fwrite(fid,text);
fclose(fid);
end

