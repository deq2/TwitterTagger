function b = anyContains(word, cell)
b = 0;
for i = 1:length(cell)
    if strfind(word, cell{i})==1
        b = 1;
    end
end