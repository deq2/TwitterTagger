function  features = get_features2(i,words_in_sentence, words, wordsIndex, end_of_sentence, tags, tagsIndex)
%Sentence is a cell array of tuples: each tuple is a word, label pair.
%get_features returns a cell array of strings. Each string is of the form
%'featureType\tFeature', for example 'i word\tdog'. These pairs are stored
%in strings so that they can be keys in the weight hashtable.

orig_word = getWord(i, words_in_sentence, words, end_of_sentence);
word = lower(orig_word);
l1 = length(word);
features = {};

features{end + 1} = 'bias';

if l1 >= 3
    features{end + 1} =sprintf('i suffix\t%s', word(length(word) -2:length(word)));
end

features{end + 1} = sprintf('i pref1\t%s',orig_word(1));

if i > 1
    prev = lower(getWord(i-1, words_in_sentence, words, end_of_sentence));
    prevTag = '';
    prevTagStartIndex = find(wordsIndex==words_in_sentence(i-1));
    if prevTagStartIndex~=length(tags)
        prevTag = tags(tagsIndex(prevTagStartIndex):tagsIndex(prevTagStartIndex+1)-1);
    end
    
    features{end + 1} =  sprintf('i-1 tag\t%s',prevTag);
    features{end + 1} = sprintf('i-1 word\t%s', prev);
    features{end + 1} = sprintf('i-1 tag+i word\t%s\t%s', prevTag, word);
    if length(prev)>=3
        features{end + 1} = sprintf('i-1 suffix\t%s',prev(length(prev)-2:length(prev)));
    end
end

if i > 2
    prev2 = lower(getWord(i-2, words_in_sentence, words, end_of_sentence));
    
    prev2TagStartIndex = find(wordsIndex==words_in_sentence(i-1));
    prev2Tag = '';
    if prev2TagStartIndex~=length(tags)
        prev2Tag = tags(tagsIndex(prev2TagStartIndex):tagsIndex(prev2TagStartIndex+1)-1);
    end
    
    
    features{end + 1} = sprintf('i-2 tag\t%s', prev2Tag);
    features{end + 1} = sprintf('i-2 word\t%s', lower(prev2));
    features{end + 1} = sprintf('i-1 tag+i-2 tag\t%s\t%s',...
        prevTag, prev2Tag);
end

if i < length(words_in_sentence)
    next = lower(getWord(i+1, words_in_sentence, words, end_of_sentence));
    
    features{end + 1} = sprintf('i+1 word\t%s',next);
    if length(next) >= 3
        features{end + 1} = sprintf('i+1 suffix\t%s',next(length(next)-2:length(next)));
    end
end

if i < length(words_in_sentence)-1
    next2 = lower(getWord(i+2, words_in_sentence, words, end_of_sentence));
    
    features{end+1} = sprintf('i+2 word\t%s', next2);
end

features{end + 1} = sprintf('i word\t%s', word);

% cword = sentence{i}{1};
% isUpper = cword(1) == upper(cword(1));
% features{end + 1} = sprintf('upper\t%s', isUpper);

