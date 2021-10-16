rm(list = ls())

getwd()  #获取文件存储位置
setwd("C:/code/iGEM/temp") #设置新的路径`，将文件放入该文件夹中

##===================设置输入+数据格式转换===================
input = readline(prompt="请输入总的csv文件路径")
read_list = read.csv(input, header=FALSE)
read_matrix = matrix(unlist(read_list))
read_frame = data.frame(read_matrix)
names(read_frame)[1] = "n"
len = lengths(read_list)
##===================分别写入成txt+修改成fasta===================
##分别写入txt
for (i in 1:len){
  write.table(read_frame[i,1], file=paste("C:/code/iGEM/temp/temp",as.character(i),".txt",sep=""), quote=FALSE, row.names=FALSE, col.names=FALSE)
}
##修改成fasta
folder = getwd()
files = list.files(folder)
for (f in files){
  newname = sub(".txt",".fasta",f)
  file.rename(f,newname)
}
##===================开始了！===================
list = list()
data = list()
predNuPoP =list()
predNuPoP =list()
predNuPoP =list()

for (i in 1:len){
  rm("predNuPoP","data","mydata","score")
  library(NuPoP)
  predNuPoP(file=paste("C:/code/iGEM/temp/temp",as.character(i),".fasta",sep=""),species=7,model=4)
  predNuPoP=function(file,species=7,model=4)
  {
    
    ## ====================================================================================================
    ## Purpose: This function is a wrapper of Fortran codes for prediction of nucleosome positioning
    ## input:   file    --- a string specifying the file name of DNA sequence in FASTA format
    ##          species --- an integer between 0 and 10 to specify which organism the DNA sequence is from.
    ##                      The default is set as 7 for Yeast. 
    ##          model   --- 1 or 4, specifying the order of Markov models to be used in the
    ##                      duration Hidden Markov model.
    ## output:  a result file in text format is output to the current working directory.
    ## ==================================================================================================
    
    file=as.character(file); n=nchar(file); maxlen=500; maxlen=as.integer(maxlen)
    species=as.integer(species); model=as.integer(model)
    rep=1; rep=as.integer(rep); ind=0
    file_name_num=as.integer(charToRaw(file))
    
    
    if(model==1){
      results=.Fortran("vtbfb",n,as.integer(file_name_num),freqL,tranL,freqN,tranN,maxlen,rep,species,Pd,ind=as.integer(ind),PACKAGE = "NuPoP")
      ind=results$ind
      if(ind==0){
        FilePath=getwd()
        parts=strsplit(file,"/")[[1]]
        cat(paste("Prediction output: '"), FilePath, "/", parts[length(parts)],"_Prediction1.txt'",sep="")
      }
    } else if(model==4){
      results=.Fortran("vtbfbNL4",n,as.integer(file_name_num),freqL,tranL,tranL2,tranL3,tranL4,freqN4,tranN4,maxlen,rep,species,Pd,ind=as.integer(ind),PACKAGE = "NuPoP")
      ind=results$ind
      if(ind==0){
        FilePath=getwd()
        parts=strsplit(file,"/")[[1]]
        cat(paste("Prediction output: '"), FilePath, "/", parts[length(parts)],"_Prediction4.txt'",sep="")
      }
    } else if(model!=1 && model!=4){
      stop("'model' should be 1 or 4 only; exit!")
    }
    
    if(ind==1){
      print("In current directory, the input file does not exist, stop!")
    } else if(ind==2){
      print("The input file is not in FASTA format, or contains characters other than A/a, C/c, G/g, T/t, N/n, stop!")
    } else if(ind==3){
      print("The input species label is incorrectly specificed. It should be an integer from 0 to 10!")
    }
  }
  data=readNuPoP(paste("C:/code/iGEM/temp/temp",as.character(i),".fasta","_Prediction4.txt",sep=""),startPos=1,endPos=1024)
  ##===================裁剪positon+作图+输出图片===================
  mydata = data[c(74:868),c(1,5)]
  jpeg(file = paste("plot",as.character(i),".jpg",sep=""))
  plot(mydata$Position, mydata$Affinity, type="b", pch=20, cex=0.5, lty=1 ,lwd=1)
  abline(h=0, col="red")
  dev.off()
  ##===================输出评分+写入文件===================
  score = sum(mydata$Affinity)
  list[i] = score
}

write.csv(list, file = "C:/code/iGEM/temp/socre.csv",quote = TRUE, 
            eol = "\n", na = "NA", row.names = TRUE,
            fileEncoding = "")
