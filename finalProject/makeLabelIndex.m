labelIndex = {};
index = 1;
for i = 1:length(tagsIndex)-1
    aTag = tags(tagsIndex(i):tagsIndex(i+1)-1);
    m = findInCell(labelIndex,aTag);
    [nrow, ncol] = size(m);
    if nrow==0 || ncol ==0
        labelIndex{index} = aTag;
        index = index + 1;
    end
end