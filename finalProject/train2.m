function [weights totals time timestamp] = train2(iters, words, wordsIndex, tags,...
    tagsIndex, sentenceIndex, weights, totals, time, timestamp,...
    tagDict, labelIndex)
%Iterates through laballed data iters times, and trains the weights.


for i = iters
    %Choose the order of the sentences randomly to get better performance.    
    z = randperm(length(sentenceIndex));
    shuffle = sentenceIndex(z);
    
    for s = shuffle
        index = find(sentenceIndex==s);
        if index < length(sentenceIndex)
            end_of_sentence = sentenceIndex(index+1)-1;
        else
            end_of_sentence = words(length(words));
        end
        v = wordsIndex(wordsIndex>=s);
        words_in_sentence = v(v<=end_of_sentence);
        
        for w = 1:length(words_in_sentence)
            features = get_features2(w,words_in_sentence, words, wordsIndex, end_of_sentence, tags, tagsIndex);
            thisWord = getWord(w, words_in_sentence, words, end_of_sentence);
            thisTag = '';
            tagStartIndex = find(wordsIndex==words_in_sentence(w));
            if tagStartIndex~=length(tags)
                thisTag = tags(tagsIndex(tagStartIndex):tagsIndex(tagStartIndex+1)-1);
            end
            guess = predict(features, weights, thisWord, tagDict, labelIndex);
            actual = thisTag;
            if ~strcmp(guess,actual)
                [weights, totals, timestamp, time] = ...
                update(actual, guess, features, weights, totals, timestamp, time, labelIndex);

            end
        end
    end
    
end