function [words wordsIndex tags tagsIndex sentenceIndex] = readData3(filename)
%Reads in a tab-separated data file.
%Note this will only work

fID = fopen(filename);

index = 1;
flag = 1;
% all = {};
% i = 1;
words = [];
wordsIndex = 1;
tags = [];
tagsIndex = 1;
sentenceIndex = 1;
total_word_length = 0;

while flag >0
    word = fgetl(fID);
    if word == -1
        flag = -1;
    elseif strcmp(word,'')

        prev3 = sentenceIndex(length(sentenceIndex));
        sentenceIndex = [sentenceIndex, total_word_length + prev3];
        total_word_length = 0;
%         display('here')
%         all{i} = vect;
%         i = i + 1;
%         vect = {};
%         index = 1;
    else
        split = regexp(word, '\t', 'split');
        
        newWord = split{1};
        ending = newWord(2:length(newWord));
        first = newWord(1);
        if strcmp(ending, lower(ending))&&strcmp(first, upper(first))
            words = [words newWord];
        else
            words = [words lower(newWord)];
        end
%         vect{index,1}{1} = lower(vect{index,1}{1});
        if index == 1
            prev = 1;
            prev2 = 1;
        else
            prev = wordsIndex(index);
            prev2 = tagsIndex(index);
        end
        tag = split{2};
        tags = [tags tag];
        wordsIndex = [wordsIndex, length(newWord)+prev];
        tagsIndex = [tagsIndex, length(tag) + prev2];
        total_word_length = total_word_length + length(newWord);
        index = index + 1;
    end
end

wordsIndex = wordsIndex(1:length(wordsIndex)-1);
tagsIndex = tagsIndex(1:length(tagsIndex) -1);
sentenceIndex = sentenceIndex(1:length(sentenceIndex)-1);

fclose(fID);