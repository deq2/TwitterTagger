function vect = readData(filename)
%Reads in a tab-separated data file.

fID = fopen(filename);

index = 1;
flag = 1;
vect = {};

while flag >0
    word = fgetl(fID);
    if word == -1
        flag = -1;
    else
        vect{index, 1} = regexp(word, '\t', 'split');
        index = index + 1;
    end
end

fclose(fID);