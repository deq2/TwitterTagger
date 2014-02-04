t =transpose([percent_wrong_by_label;percent_occ])

bar([1:25],t)
legend('Percentage of a given label tagged Incorrectly', 'Number of wrong words')
% bar(percent_wrong_by_label)
set(gca,'XTick', 1:25)

for i = 1:length(labelIndex)
    labelIndexCell{i} = labelIndex(i);
end

set(gca, 'XTickLabel', labelIndexCell)
title('Comparison of Percent Incorrect Tags by Label to Label Frequency')
xlabel('Label')
ylabel('Percent Incorrectly Labeled')