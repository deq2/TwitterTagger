
function labelIndex = readTags(filename)
fID = fopen(filename, 'r');

flag = 1;
i = 1;
labelIndex = [];

while flag >0
    word = fgetl(fID);
    if word == -1
        flag = -1;
    else
        if length(word) == 3
            word = [word,' '];
        elseif length(word) == 2
            word = [word,'  '];
        elseif length(word) == 1
            word = [word,'   '];
        end
        length(word)
        labelIndex = [labelIndex; word];
    end
end

fclose(fID);