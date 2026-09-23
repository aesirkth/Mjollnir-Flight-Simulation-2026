function tf = isfield_deep(s, fields)
if iscell(fields)
if numel(fields) > 1
try
tf = isfield(getfield(s, fields{1:end-1}), fields{end});
catch
tf = false;
end

else
tf = isfield(s, fields{1});
end

else
tf = isfield(s, fields);
end


end