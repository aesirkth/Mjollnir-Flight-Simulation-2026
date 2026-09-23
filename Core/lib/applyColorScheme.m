function applyColorScheme(uielement, backgroundColor, textColor, borderColor)
    
    if isprop(uielement, "BackgroundColor"); uielement.BackgroundColor = backgroundColor; end
    if isprop(uielement, "Color");           uielement.Color           = backgroundColor; end
    if isprop(uielement, "ForegroundColor"); uielement.ForegroundColor = backgroundColor; end
    if isprop(uielement, "FontColor");       uielement.FontColor       = textColor;       end
    if isprop(uielement, "BorderColor");     uielement.BorderColor     = borderColor;     end

    if isprop(uielement, "Children")
        for child_index = 1:numel(uielement.Children)
            applyColorScheme(uielement.Children(child_index), backgroundColor, textColor, borderColor)
        end
    end

end
