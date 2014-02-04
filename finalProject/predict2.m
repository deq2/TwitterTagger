function label = predict2(features, weights, time)
%Predicts the label of a given word, given its features.

labelIndex = 'NOS^ZLMVAR!DP&TXY#@~UE$,G';

score = zeros(1,length(labelIndex));
for f=1:length(features)
    feat = features{f};
    if isKey(weights, feat)
        size(weights(feat));
        weights(feat);
        size(score);
        score = score + weights(feat)/time;
    end
end
[m, where] = max(score);
label = labelIndex(where);