function [words wordsIndex tags tagsIndex sentenceIndex] = readDataGate2(filename)
fID = fopen(filename);

flag = 1;
% all = {};
% index = 1;
% newsentence = {};
words = [];
wordsIndex = 1;
tags = [];
tagsIndex = 1;
count = 1;
sentenceIndex = 1;
total_word_length = 0;

while flag > 0
    line = fgetl(fID);
    if line == -1
        flag = -1;
    else
        sentence = regexp(line, ' ', 'split');
        for i = 1:length(sentence)-1
            stored = [];
            for k = length(sentence{i}):-1:1
                if sentence{i}(k) ~= '_'
                    stored = [sentence{i}(k) stored];
                else
                    break
                    
                end
                
            end
            if length(stored) == 3
                stored = [stored,' '];
            elseif length(stored) == 2
                stored = [stored,'  '];
            elseif length(stored) == 1
                stored = [stored,'   '];
            end
            rest = sentence{i}(1:k-1);
            total_word_length = total_word_length + length(rest);
            words = [words rest];
            tags = [tags stored];
            
            if count ==1
                prev = 1;
                prev2 = 1;
            else
                prev = wordsIndex(count);
                prev2 = tagsIndex(count);
            end
            
            wordsIndex = [wordsIndex, length(rest)+prev];
            tagsIndex = [tagsIndex, length(stored) + prev2];
            
%             newsentence{i} = {rest, stored};
            count = count +1;
        end
        prev3 = sentenceIndex(length(sentenceIndex));
        sentenceIndex = [sentenceIndex, total_word_length + prev3];
        total_word_length = 0;
%         all{index} = newsentence;
%         index = index + 1;
    end
end

wordsIndex = wordsIndex(1:length(wordsIndex)-1);
tagsIndex = tagsIndex(1:length(tagsIndex) -1);
sentenceIndex = sentenceIndex(1:length(sentenceIndex)-1);

fclose(fID);

