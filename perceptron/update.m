function [weights, totals, timestamp, time] = update(actual, guess, features, weights, totals, timestamp, time, labelIndex)
%Updates the current weight, and totals, the accumulative weights.
%Timestamp is used so that the total weight does not need to be updated on
%every interaction: there are so many weights that very few weights will be
%changed on a given iteration. Timestamp(weight) is the time of the last change to
% weight.

    function updateHelp(feat, label, n)

          i = find(labelIndex==label);
          
        if isKey(weights, feat)
            %Update totals by multiplying number inters at this weight by
            %the number of time steps weight has had a certain value.
            n_iters_at_this_weight = time - timestamp(feat);
            totals(feat) = totals(feat) + n_iters_at_this_weight*weights(feat);
            label;
            
            %Update weights.
            w = weights(feat);  
            w(i) = w(i) + n;
            weights(feat) = w;
            timestamp(feat) = time;

        else
            totals(feat) = 0;
            w = zeros(1,length(labelIndex));
            w(i) = w(i) + n;
            weights(feat) = w;
            timestamp(feat) = time;
        end
        time = time + 1;
    end

for f = 1:length(features)
    updateHelp(features{f}, actual, 1);
    updateHelp(features{f}, guess, -1);
end

end