function assembly = recursive_set(assembly, field, value, condition)
% condition argument : true / false = @( assembly.child ) condition

if ~exist("condition", "var"); condition = @(x) true; end
if condition(assembly)
assembly.(field) = value;
end

children_names = fieldnames(assembly);
for child_index = 1:numel(children_names)
    child_name = children_names{child_index};
    if isstruct(assembly.(child_name)) && isscalar(assembly.(child_name))
    assembly.(child_name) = recursive_set(assembly.(child_name), field, value, condition);
    end
end

end