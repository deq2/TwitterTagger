function newAll = relabel(all)
%Relabel with labels from Gimpel et. al

for i = 1:length(all)
    sentence = all{i};
    for j = 1:length(sentence)
        label = all{i}{j}{2};
        if length(label) == 0
            all{i}{j}{2} = 'G';
        elseif strcmp(label,'NN') || strcmp(label,'NNS')
            all{i}{j}{2} = 'N';
        elseif strcmp(label,'PRP') || strcmp(label,'WP')
            all{i}{j}{2} = 'O';
        elseif strcmp(label,'NNP') || strcmp(label,'NNPS')
            all{i}{j}{2} = '^';
        elseif label(1)=='V'||strcmp(label, 'MD')
            all{i}{j}{2} = 'V';
        elseif label(1) == 'J'
            all{i}{j}{2} = 'A';
        elseif strcmp(label, 'RP')
             all{i}{j}{2} = 'T';
        elseif strcmp(label, 'RT')
            all{i}{j}{2} = '~';
        elseif label(1) == 'R' || strcmp(label, 'WRB')
            all{i}{j}{2} = 'R';
        elseif strcmp(label, 'UH')
            all{i}{j}{2} = '!';
        elseif strcmp(label, 'WDT') || strcmp(label, 'DT')...
                ||strcmp(label, 'WP$')||strcmp(label, 'PRP$')
            all{i}{j}{2} = 'D';
        elseif strcmp(label, 'IN') || strcmp(label, 'TO')
            all{i}{j}{2} = 'P';
        elseif strcmp(label, 'CC')
            all{i}{j}{2} = '&';

        elseif strcmp(label, 'EX')|| strcmp(label, 'PDT')
            all{i}{j}{2} = 'X';
        elseif strcmp(label, 'CD')
            all{i}{j}{2} = '$';
        elseif sum(isstrprop(label, 'punct'))>0 || strcmp(label, '$')
            all{i}{j}{2} = ',';
        elseif strcmp(label, 'FW')||strcmp(label, 'POS')||...
                strcmp(label, 'SYM')||strcmp(label, 'LS')
            all{i}{j}{2} = 'G';
        elseif strcmp(label, 'URL')
            all{i}{j}{2} = 'U';
        elseif strcmp(label, 'HT')
            all{i}{j}{2} = '#';
        elseif strcmp(label, 'USR')
            all{i}{j}{2} = '@';
        end
    end
    
end
    newAll = all;