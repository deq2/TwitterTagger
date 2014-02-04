function dict = readDict(filename,dict, label)

fID = fopen(filename, 'r');

flag = 1;

while flag >0
    word = fgetl(fID);
    if word == -1
        flag = -1;
    else
        dict(lower(word)) = label;
    end
end

fclose(fID);