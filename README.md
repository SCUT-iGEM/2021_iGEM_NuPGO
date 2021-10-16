# NuPGO usage tutorial

## Files introduction

- NuPGO files instruction:
  - IOfile: Directory storing the interactive files
    - Rfile: Directory storing the intermediate files from R
    
  - matlab:
    - **GA**:
      - affinity.m : Computes the nucleosome affinity of the input DNA sequence without scaling
      - clearfasta.m : Neatens the fasta file created by R since the raw file created might have null string. This function could transform the raw file into the workable format.
      - containsforbidden.m : Looks for instances of user-defined DNA motifs in the promoter sequence. Degenerate bases in motifs are acceptable.
      - crossover.m : this script is a cross function.
      - fastaWrite.m : Writes the sequence to fasta file, convinient for calling by R. Package xlsx is actually an inefficient way, while using pandas to write csv was often preferred. But we found the csv file written was unusable, so we have to choice xlsx package.
      - fitness.m : Computes the population fitness(concept in genetic algorithm), with the user-defined weights.
      - GAmain : The main script of our NuPGO algorithm.
      - gccontent.m 、gcprofile.m : Computes the GC content or GC content of each 1000bp sliding window  of a sequence.
      - getResult.m : Function for conveniently obtain the result.
      - init.m : Initializes the population from input sequence.
      - mutate.m : Introduces mutations to the population.
      - mydraw.m : Draw the visualized result as the assistant function for getResult.m script.
      - rewriteR.m : Rewrites fitness2.R in order to make it suitable for inputting sequence in this round.
      - rewriteR_NuPoP.m : Rewrites NuPoP.R in order to make it suitable for inputting sequence in this round.
      - select.m : The application function of roulette wheel selection algorithm.
      - seqarea.m : Computes the cumulative affinity score with user-defined weights for the DNA sequence.
      - seqarea_0.m : Computes the cumulative affinity score without user-defined weights for the DNA sequence.
      - seqcheck.m : Makes sure that the sequence generated is eligible, such as for gene synthesis following the IDT's rules.
      - my_Data2.mat 、HXT.mat :Template of data input, which you can refer to for submitting your sequence and parameters. But remember you don't need to really modify it.

  - R:

    - fitness2.R : Make DNA nucleosome affinity predictions of several sequences. Matlab is needed for rescaling since undesirable scaling would be included here.
    - fitnessTemplate.txt : Template of fitness2.R. Different fitness2.R file is needed for different sequences.
    - NuPoP.R : Calculates the affinity aggregate score of a DNA sequence.
    - NuPoPTemplate.txt : - Template of NuPoP.R. Only used for helping understanding and you do not need to modify it while the code will accomplish that automatically.

    

## Runtime Environment Require

Please make sure you have the following runtime environment:

- R.exe 4.1.0 or higher version
  - Package xlsx is needed, and please note that if your computer doesn't have JDK environment, you should configure additionally.
- Matlab 2020 or higher version
- NuPGO, our software folder, which should be completely uncompressed. Besides, the relative path should be altered carefully if you have to make adjustment.

## Path configuration

Open file *ProNuGO/matlab/GA/GAmain.m* and follow these following steps:

1. Line13: Set your own path of R.exe.   e.g. *G:\R\R\R-4.1.0\bin\R.exe*
2. Line14: Set your own folder path of NuPGO.   e.g. *G:\proNuGO*

## Initial data for optimization

Open file *ProNuGO/matlab/GA/GAmain.m* and follow these following steps:

1. Sequnence: The sequnence you want to optimize, such as promoter sequence. Its format is required as **char**. Pay special attention to your sequence that 149bp and 74bp meaningless sequence before and after the real sequence you want to optimize. The reason why is that NuPoP compute affinity of single base position according to the 74bp on its left and right respectively. Without the front meaningless 74bp, the 74bp at the begining of your true sequence cannot be calculated. Additionally, when computing the AUC as aggregate score it uses learning curve for regression and rescaling so as to reduce the bias generated in iterations. You can find detail explaination in seqarea.m.

   DON'T WORRY if you fine it difficult to understand, just remember to **add meaningless sequence on the upstream and downstream of your concerned sequence**. The length we recommended is **200bp of context before and 100bp of context after** your promoter.

2. Forbiddenseqs: The special sequence fragments that you don't want mutations happen

3. prombeg: To skip the meaningless context before your concerned sequence, set as the true initiation site. For example, if your context before has the length of 200bp, prombeg should be 201.

4. promend: To skip the meaningless context after your concerned sequence, set as the true termination site. For example, if your context before has the length of 200bp and concerned sequence has a length of 813bp, promend should be 913.

## Hyper-parameters in GA

1. N: Population quantity. 50 was recommended, while you can turn it up to expand search.
2. ger: Number of iterations. 500 to 3000 was recommended, while the suited one decided by convergence situation.
3. pc: Probability of crossover. Default is 0.1, while you can tune according to the length of promoter sequence.
4. pm: Probability of mutation, the value of each site is pm/2. We set 0.005 as default, while you can tune according to the length of promoter sequence.

## How to run NuPGO?

Before running the program, please make sure the **folders, files path, environment**, **paths in scripts**, are correctly set as we mentioned above.

Dirrectly run the GAmain.m file, successfully, NuPGO will be on then.

The concrete costing time depends on your machine capacity, length of sequence, hyper-parameters. But judging by our experience, it often takes less than 24 hours on 1500bp promoter, several hours on 600bp promoter (taking the forbidden sequences into account).

## Quickly harvest your result

For convenient to harvest result, we additionally writed a function to help.

1. First and foremost, the file named *"maxrecord.mat"* stores the result. You're recommended to modify the file name, in order to avoid file loss caused by coverage when running next time.

2. Make sure the working directory of matlab is NuPGO/matlab/GA

3. Call the following function in the command line window: 

   *getResult(Pop,name,prombeg,promend)*

   The parameter insides are:

   1. Pop: Parameter here stands by the cell storing the best sequence in every iteration. We recommend filling the saving file's name "maxrecord" as Pop.
   2. name: The result name, defined by yourself.
   3. prombeg&promend: same as we mentioned above.

## Add specific weights

Open file named seqarea.m, and find line33 to line36 as the tutorial of adding specific weights:

```matlab
affinitiesscaled(349-73:460-73)=affinitiesscaled(349-73:460-73)*2.5;
affinitiesscaled(505-73:536-73)=affinitiesscaled(505-73:536-73)*1.3;
affinitiesscaled(590-73:670-73)=affinitiesscaled(590-73:670-73)*1.3;
affinitiesscaled(795-73:855-73)=affinitiesscaled(795-73:855-73)*1.8;
```

In the example, weight on the region from 349bp to 460bp was set as 2.5;weight on the region from 505bp to 536bp was set as 1.3;weight on the region from 590bp to 670bp was set as 1.3;weight on the region from 795bp to 855bp was set as 1.8;While the other region have the weights as one.

You're suggested to set your own weights to gain your specific result~

Hope you can have a good time with NuPGO! 



