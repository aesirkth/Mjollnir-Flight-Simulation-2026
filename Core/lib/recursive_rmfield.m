function obj = recursive_rmfield(obj, condition)
if ~exist("condition", "var"); condition = @(~) true; end

child_names = fieldnames(obj);
for child_index = 1:numel(child_names)

child_name = child_names{child_index};
try

if condition(obj.(child_name))
obj = rmfield(obj, child_name);
elseif isstruct(obj.(child_name)) && isscalar(obj.(child_name))
obj.(child_name) = recursive_rmfield(obj.(child_name), condition);
end
catch
end


end