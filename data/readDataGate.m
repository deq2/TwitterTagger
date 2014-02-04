function all = readDataGate(filename)
fID = fopen(filename);

flag = 1;
all = {};
index = 1;
newsentence = {};

while flag > 0
    line = fgetl(fID);
    if line == -1
        flag = -1;
    else
        sentence = regexp(line, ' ', 'split');
        for i = 1:length(sentence)-1
            stored = [];
            for k = length(sentence{i}):-1:1
                if sentence{i}(k) ~= '_'
                    stored = [sentence{i}(k) stored];
                else
                    break
                    
                end
                
            end
            if length(stored) == 3
                stored = [stored,' '];
            elseif length(stored) == 2
                stored = [stored,'  '];
            elseif length(stored) == 1
                stored = [stored,'   '];
            end
            rest = sentence{i}(1:k-1);
            newsentence{i} = {rest, stored};
        end
        all{index} = newsentence;
        index = index + 1;
    end
end

