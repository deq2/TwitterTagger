function tagDict = makeTagDict(properNouns, labelIndex)

% x = 1;
% for i = 1:length(data)
%     sentence = data{i};
%     for j=1:length(sentence)
%         new{x, 1} = sentence{j}{1};
%         new{x, 2} = sentence{j}{2};
%         x = x+1;
%     end
% end

freqDict = containers.Map;
[nrow ncol] = size(new);
for i = 1:nrow
%     v = findInCell(new, new{1,1});
    word = new{i,1};
    index = find(strcmp(labelIndex,new{i,2}));
    if isKey(freqDict, word)        
        w = freqDict(word);
        w(index) = w(index) + 1;
        freqDict(word) = w;
    else
        w = zeros(1,length(labelIndex));
        w(index) = w(index) + 1;
        freqDict(word) = w;
    end
    
end

tagDict = properNouns;
% keys = freqDict.keys;
% for i = 1:length(keys)
%     freq = freqDict(keys{i});
%     [m where] = max(freq);
%     if m/sum(freq) >= .9 && sum(freq)>=50
%         tagDict(keys{i}) = labelIndex(where);
%     end
% end

% 
%     function v = findInCell(c, str)
%         %Assumes a cell of strings.
%         v = [];
%         for k = 1:length(c)
%             if strcmp(c{k},str)
%                 v = [v k];
%             end
%         end
%     end
%     function freqVect = labelFreq(label, new, findVect)
%         freqVect = zeros(1, length(labelIndex));
%         for c = 1:make(findVect)
%             l = new{findVect(c), 2};
%             index = find(labelIndex==l);
%             freqVect(index) = freqVect(index) + 1;
%         end
%     end

end