classdef word
    
    properties
        name
        labels
    end
    
    methods
        function obj = word(n, l)
            obj.name = n;
            obj.labels = l;            
        end
    end
    
end