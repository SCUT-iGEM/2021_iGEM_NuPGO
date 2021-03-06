function forbiddensites=containsforbidden(sequence,forbiddenseqs)
%"forbiddenseqs" means those region you don't want to introduce mutation to.
%And "forbiddensites" is the positions of your "forbiddenseqs", obtained 
%from comparison between forbiddenseqs and sequence.
%This script looks for instances of motifs in forbiddenseqs in seq.  motifs
%can include degenerate bases.
    forbiddensites={[]};
end

for n=1:size(forbiddenseqs,2)
    %cycles through everything in forbiddenseqs
    
    forbiddenregexp1=seq2regexp(forbiddenseqs{1,n}(1),'Ambiguous',false);
    forbiddenregexp2=seq2regexp(forbiddenseqs{1,n}(2:length(forbiddenseqs{1,n})),'Ambiguous',false);
    forbiddensites{n}=regexp(sequence,strcat(forbiddenregexp1,'(?=',forbiddenregexp2,')'));
    %regexp "consumes" a sequence as it checks for matches so I'm just
    %taking the first nucleotide of the motif and looking ahead to see if
    %it finds the rest after this basepair.  Then I save the positions or matches in
    %forbiddensites
end