function tf = is_rigid_body(variable)
tf = false;
if isstruct(variable) && isscalar(variable)
if isfield(variable, 'is_rigid_body')
tf = variable.is_rigid_body;
end
end

end