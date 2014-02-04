function new_weights = average_weights(totals, time, timestamp, weights)

new_weights = containers.Map;
keys = totals.keys;

for i = 1:length(keys)
    old = totals(keys{i});
    old = old + (time - timestamp(keys{i}))*weights(keys{i});
    old = old/time;
    new_weights(keys{i}) = old;
end