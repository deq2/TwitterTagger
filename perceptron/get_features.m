function  features = get_features(i,sentence)
%Sentence is a cell array of tuples: each tuple is a word, label pair.
%get_features returns a cell array of strings. Each string is of the form
%'featureType\tFeature', for example 'i word\tdog'. These pairs are stored
%in strings so that they can be keys in the weight hashtable.

word = lower(sentence{i}{1});
l1 = length(word);
features = {};

features{end + 1} = 'bias';

if l1 >= 3
    features{end + 1} =sprintf('i suffix\t%s', word(length(word) -2:length(word)));
end

features{end + 1} = sprintf('i pref1\t%s',sentence{i}{1}(1));

if i > 1
    prev = lower(sentence{i-1}{1});
    features{end + 1} =  sprintf('i-1 tag\t%s',sentence{i-1}{2});
    features{end + 1} = sprintf('i-1 word\t%s', prev);
    features{end + 1} = sprintf('i-1 tag+i word\t%s\t%s', sentence{i-1}{2}, word);
    if length(prev)>=3
        features{end + 1} = sprintf('i-1 suffix\t%s',prev(length(prev)-2:length(prev)));
    end
end

if i > 2
    features{end + 1} = sprintf('i-2 tag\t%s', sentence{i-2}{2});
    features{end + 1} = sprintf('i-2 word\t%s', lower(sentence{i-2}{1}));
    features{end + 1} = sprintf('i-1 tag+i-2 tag\t%s\t%s',...
        sentence{i-1}{2}, sentence{i-2}{2});
end

if i < length(sentence)
    next = lower(sentence{i+1}{1});
    features{end + 1} = sprintf('i+1 word\t%s',next);
    if length(next) >= 3
        features{end + 1} = sprintf('i+1 suffix\t%s',next(length(next)-2:length(next)));
    end
end

if i < length(sentence)-1
    features{end+1} = sprintf('i+2 word\t%s', lower(sentence{i+2}{1}));
end

features{end + 1} = sprintf('i word\t%s', word);

% cword = sentence{i}{1};
% isUpper = cword(1) == upper(cword(1));
% features{end + 1} = sprintf('upper\t%s', isUpper);

