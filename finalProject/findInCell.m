function v = findInCell(c, ele)
v = [];
for i = 1:length(c)
    if strcmp(c{i}, ele)
        v = [v i];
    end
end