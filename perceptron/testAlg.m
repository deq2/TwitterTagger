function [percent_right percent_sent_right percent_wrong_by_label  wrong_label_hist percent_occ] =...
    testAlg(labelIndex, new_weights, tagDict, filename)
%Tests trained model on data in the test file dev.
dev = readData2(filename);

iters = length(dev);
numCorrect = 0;
all = 0;
numSeenBefore = 0;
allSeenBefore = 0;
numWrong = 0;
wrongUnseen = 0;
numSentCorr = 0;
totSent = 0;
wrong_label_hist = zeros(1,length(labelIndex));
freq_label = zeros(1, length(labelIndex));

for i = 1:iters
    
    sentence = dev{i};
    actual = '';
    guesses = '';
    sentCorr = true;

    for w=1:length(sentence)
        features = get_features(w, sentence);
        
        wordFeat = sprintf('i word\t%s', sentence{w}{1});
        seenBefore = false;
        if isKey(new_weights, wordFeat)
            seenBefore = true;
        end
        
        guess = predict(features, new_weights,sentence{w}{1}, tagDict, labelIndex);
        correct = sentence{w}{2};
        sentence{w}{2} = guess;
        index = find(labelIndex== correct);
        
        %Frequency of each label in dev data.
        freq_label(index) = freq_label(index) + 1;
        if strcmp(guess,correct)
            numCorrect = numCorrect + 1;
            if ~seenBefore
                numSeenBefore = numSeenBefore +1;
            end
        else            
            sentCorr = false;
            numWrong = numWrong + 1;
            if ~seenBefore
                wrongUnseen = wrongUnseen + 1;
            end
            %Frequency of incorrect tagging, by label.
            wrong_label_hist(index) = wrong_label_hist(index) + 1;
        end
        if ~seenBefore
            allSeenBefore = allSeenBefore + 1;
        end
        all = all + 1;
        if sentCorr
            numSentCorr = numSentCorr + 1;
        end
        totSent = totSent + 1;
    end

end

%The percentage of never-seen-before words that are tagged correctly.
percent_unknown_right = numSeenBefore/allSeenBefore;

%Percent correctly tagged tokens.
percent_right = numCorrect/all;

%Percent correctly tagged sentences.
percent_sent_right = numSentCorr/totSent;

%Vector of percent occurance of each label.
percent_occ = freq_label/sum(freq_label);

%Vector of percent incorrect tags, by label.
percent_wrong_by_label = wrong_label_hist./freq_label;