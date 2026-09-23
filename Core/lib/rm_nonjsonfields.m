function s2 = rm_nonjsonfields(s)


    if isstruct(s) && isscalar(s)
        s2 = struct();
        fn = fieldnames(s);
        for i = 1:numel(fn)
            f = fn{i};
                    
            field = rm_nonjsonfields(s.(f));
            if ~isempty(field); s2.(f) = field; end

        end

    elseif iscell(s)
        s2 = cell(size(s));
        for i = 1:numel(s)
            
            field = rm_nonjsonfields(s{i});
            if ~isempty(field); s2{i} = field; end

        end
    else
        if isstring(s) || ischar(s) || isnumeric(s) || islogical(s)
            s2 = s;
        else
            s2 = []; 
        end

    end
end