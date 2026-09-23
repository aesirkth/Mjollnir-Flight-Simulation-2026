function s = rmfield_deep(s, fields)
if iscell(fields)
if numel(fields) > 1

s = setfield(s, fields{1:end-1}, rmfield( getfield(s, fields{1:end-1}) , fields{end}));

else
s = rmfield(s, fields{1});
end

else
s = rmfield(s, fields);
end


end