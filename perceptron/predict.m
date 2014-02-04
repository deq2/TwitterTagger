function label = predict(features, weights, word, tagDict, labelIndex)
%Predicts the label of a given word, given its features.

%First check if the word is in the tag dictionary.
if isKey(tagDict, word)
    label = tagDict(word);
else
    score = zeros(1,length(labelIndex));
    for f=1:length(features)
        feat = features{f};
        if isKey(weights, feat)
            score = score + weights(feat);
        end
    end
    [m, where] = max(score);
    label = labelIndex(where);
end
