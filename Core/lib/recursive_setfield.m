function obj = recursive_setfield(obj, fieldname,valuefcn, condition)
if ~exist("condition", "var"); condition = @(~) true; end


try
if isstruct(obj)
if condition(obj)
obj.(fieldname) = valuefcn(obj);
end
end
catch
end

child_names = fieldnames(obj);
for child_index = 1:numel(child_names)

child_name = child_names{child_index};

if isstruct(obj.(child_name)) && isscalar(obj.(child_name))
obj.(child_name) = recursive_setfield(obj.(child_name), fieldname,valuefcn, condition);
end



end