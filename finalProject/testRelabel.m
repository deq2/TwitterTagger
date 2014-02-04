labelIndex = 'NOS^ZLMVAR!DP&TXY#@~UE$,G';
for i = 1:length(all)
    for j = 1:length(all{i})
        if length(all{i}{j}{2}) ~= 1
            all{i}{j}{2}
        end
    end
end