function [weights totals time timestamp] = train(data, iters, weights, totals, time, timestamp, tagDict, labelIndex)
%Iterates through laballed data iters times, and trains the weights.


for i = iters
    %Choose the order of the sentences randomly to get better performance.
    shuffle = randperm(length(data));
    
    for s = shuffle
        sentence = data{s};
        for w = 1:length(sentence)
            features = get_features(w, sentence);
            guess = predict(features, weights, sentence{w}{1}, tagDict, labelIndex);
            actual = sentence{w}{2};
            if ~strcmp(guess,actual)
                [weights, totals, timestamp, time] = ...
                update(actual, guess, features, weights, totals, timestamp, time, labelIndex);

            end
        end
    end
    
end