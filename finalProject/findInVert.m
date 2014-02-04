function v = findInVert(c, str)
%Assumes a vertical vector of tags.

    v = 0;
    for k = 1:length(c)
        if strcmp(c(k, :),str)
            v = k;
        end
    end
    if v == 0
        fprintf('%s is probably a tagging error\n', str)
        v = ceil(length(c)*rand);
    end
end