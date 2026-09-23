function s = ensure_fields(s, fields)

for field_index =1:numel(fields)
subfields = fields(1:field_index);
if ~isfield_deep(s, subfields); s = setfield(s, subfields{:}, struct());

end


end