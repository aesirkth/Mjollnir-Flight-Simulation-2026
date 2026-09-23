function s = setfield_safe(s, fields, value)
s = ensure_fields(s, fields);
s = setfield(s, fields{:}, value);


end