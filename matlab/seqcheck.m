function isok=seqcheck(seq,parent,runsstart)%Use global variable to reduce parameters delivery
%The sole purpose of this program is to make sure that a sequence can be
%synthesized by IDT's gblocks.  It was sufficient at the time of writing but some
%features of it may no longer be necessary as synthesis technology
%improves.

%initiates things
isok=1;
complement=seqcomplement(seq);
len=length(seq);
GCstart=gcprofile(parent);
forbiddenruns={'AAAAAAAAA','CCCCCC','TTTTTTTTT','GGGGGG'};

%check total GC content
GC=gccontent(seq);
if GC>75||GC<=25
    isok=0;
end

%check GC content every 100bp
if isok==1
    GC=gcprofile(seq);
    if max(GC)>80||min(GC)<24 %checks if GC content is not within acceptable range
        if min(GC)<min(GCstart) %is minimum GC content of new sequence lower than parent?
            isok=0;
        elseif min(GC)==min(GCstart) %is minimum GC content of new sequence equal to parent?
            if sum(GC==min(GC))>sum(GCstart==min(GCstart))
                isok=0;
            end
        end
    end
end

%Check for homopolymers which are too long
if isok==1    
    seqforbidden=containsforbidden(seq,forbiddenruns);
    if size(cell2mat(seqforbidden),2)>size(cell2mat(runsstart),2)
       isok=0; 
    end

            

% check for hairpins
if isok==1
    %create the dot matrix and rotate it
    for n=1:len
        hpdot(n,:)=complement==seq(n);
    end
    hpdot=rot90(hpdot);
    %search through all the diagonals for runs of "dots" of a certain
    %length.  higher than 8bp hairpin is bad if GC content is greater than
    %80%, higher than 11bp hairpin is always bad
    for n=-length(seq)+1:length(seq)-1
        if isok==1;
            a=diag(hpdot,n);
            dia=a(1:ceil(length(a)/2));
            hpsmall=strfind(dia',ones(1,9));
            hpbig=strfind(dia',ones(1,12));
            if size(hpbig)~=0
                isok=0;
            elseif size(hpsmall)~=0
                for m=1:size(hpsmall)
                    if n<=0
                        GC=gccontent(seq(hpsmall(m):hpsmall(m)+6));
                    else
                        GC=gccontent(seq(len-hpsmall(m)-5:len-hpsmall(m)+1));
                    end
                    if GC>80
                        isok=0;
                    end
                end
            end
        end
    end
end