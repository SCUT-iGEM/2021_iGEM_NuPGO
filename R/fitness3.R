rm(list = ls())
library(xlsx)
library(NuPoP)
getwd()  #????????????
setwd("G:/iGEM/IOfile/Rfile") #?????????`?????????????????
ifile='G:/iGEM/IOfile/proms.xlsx'

##===================??????+?????????===================
##input = readline(prompt="????????csv??????")
read_list = read.xlsx(ifile,1,header=FALSE)
read_matrix = matrix(unlist(read_list))
read_frame = data.frame(read_matrix)
names(read_frame)[1] = "n"
len = lengths(read_list)
##===================????????xt+?????asta===================
##??????txt
for (i in 1:len){
  write.table(read_frame[i,1], file=paste("G:/iGEM/IOfile/Rfile/temp",as.character(i),".txt",sep=""), quote=FALSE, row.names=FALSE, col.names=FALSE)
}
##?????asta
folder = getwd()
files = list.files(folder)
for (f in files){
  newname = sub(".txt",".fasta",f)
  file.rename(f,newname)
}
##===================???????===================
# if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("NuPoP")


output = matrix(0,1767,len)
data = list()
mudata = list()
predNuPoP =list()


for (i in 1:len){
  rm("predNuPoP","data","mydata")
  library(NuPoP)
  predNuPoP(file=paste("G:/iGEM/IOfile/Rfile/temp",as.character(i),".fasta",sep=""),species=7,model=4)
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
  data=readNuPoP(paste("G:/iGEM/IOfile/Rfile/temp",as.character(i),".fasta","_Prediction4.txt",sep=""),startPos=1,endPos=1113)
  ##===================???positon+???+??????===================
  mydata = data[c(74:1840),c(1,5)]
  #jpeg(file = paste("plot",as.character(i),".jpg",sep=""))
  #plot(mydata$Position, mydata$Affinity, type="b", pch=20, cex=0.5, lty=1 ,lwd=1)
  #abline(h=0, col="red")
  #dev.off()
  ##===================??????+??????===================
  output[,i] = mydata$Affinity
}

write.table(output, file = "G:/iGEM/IOfile/Rfile/output.txt", 
            sep=" ", row.names=FALSE,  col.names=FALSE)

