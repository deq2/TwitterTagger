data1 = readData2('oct27train.txt');
data2 = readData2('daily.txt');
entire = {data1{1:length(data1)}, data2{1:length(data2)}};
labelIndex = 'NOS^ZLMVAR!DP&TXY#@~UE$,G';
all = [];
numTokes = 0;
iters = 1;

%Script used to generate the plot of correctness with respect to the data
%size. This code was also used with a slight variation to find the correct
%number of iterations for the model.

for steps = 1:100:1545
    data = entire(1:steps);
    weights = containers.Map;
    totals = containers.Map;
    timestamp = containers.Map;
    time = 1;

    [weights totals time timestamp] = train(data, 10, weights,...
        totals, time, timestamp, tagDict, labelIndex);
    new_weights = average_weights(totals, time, timestamp, weights);
    [percent_right percent_sent_right] = testAlg(labelIndex, new_weights, tagDict);
    
    %Count tokens
    if steps ==1
        sentence = data{1};
        numTokes = numTokes + length(sentence);
    else 
        for j = 0:100
            sentence = data{steps - j};
            numTokes = numTokes + length(sentence);
        end
    end
    
    
            
    all(iters, 1) = percent_right
    all(iters, 2) = percent_sent_right
    all(iters, 3) = numTokes
    iters = iters + 1;
end