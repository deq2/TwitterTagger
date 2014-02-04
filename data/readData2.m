function all = readData2(filename)
%Reads in a tab-separated data file.
%Interesting: not getting last sentence.

fID = fopen(filename);

index = 1;
flag = 1;
all = {};
i = 1;
vect = {};

while flag >0
    word = fgetl(fID);
    if word == -1
        flag = -1;
    elseif strcmp(word,'')
%         display('here')
        all{i} = vect;
        i = i + 1;
        vect = {};
        index = 1;
    else
        vect{index, 1} = regexp(word, '\t', 'split');
        
        newWord = vect{index,1}{1};
        ending = newWord(2:length(newWord));
        first = newWord(1);
        if strcmp(ending, lower(ending))&&strcmp(first, upper(first))
            vect{index,1}{1} = newWord;
        else
            vect{index,1}{1} = lower(newWord);
        end
%         vect{index,1}{1} = lower(vect{index,1}{1});
        index = index + 1;
    end
end

fclose(fID);