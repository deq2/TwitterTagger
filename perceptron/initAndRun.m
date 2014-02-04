%Script to run the training and testing of the averaged perceptron
%algorithm.
% 
% data = readData2('oct27train.txt');

%Ark tag set.

% labelIndex = 'NOS^ZLMVAR!DP&TXY#@~UE$,G';

properNouns = load('properNouns');
properNouns = properNouns.properNouns;
% tagDict = makeTagDict(properNouns, labelIndex);
tagDict = containers.Map;

weights = containers.Map;

totals = containers.Map;
timestamp = containers.Map;
time = 1;

% [weights totals time timestamp] = train(data, 3, weights, totals, time, timestamp, tagDict, labelIndex);


[weights totals time timestamp] = train2(3, words, wordsIndex, tags,...
    tagsIndex, sentenceIndex,weights, totals, time, timestamp,...
    tagDict, labelIndex);

new_weights = average_weights(totals, time, timestamp, weights);


%Test algorithm against a test data set, and return the percent of
%correctly tagged tokens and the percent of correctly tagged sentences.

[percent_right percent_sent_right percent_wrong_by_label  wrong_label_hist percent_occ] =...
    testAlg(labelIndex, new_weights, tagDict, 'ritter_train.stanford');