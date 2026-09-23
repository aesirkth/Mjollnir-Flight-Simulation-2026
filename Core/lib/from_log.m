function result = from_log(log, field)

if iscell(field)
result = cell2mat(cellfun(@(c)getfield(c, field{:}), log', 'UniformOutput', false))
else
result = cell2mat(cellfun(@(c)getfield(c, fields), log', 'UniformOutput', false))
end
end