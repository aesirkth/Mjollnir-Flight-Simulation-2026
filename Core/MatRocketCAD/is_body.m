function tf = is_body(variable)
tf = false;
if isstruct(variable) && isscalar(variable)
if isfield(variable, 'is_body')
tf = variable.is_body;
end
end

end