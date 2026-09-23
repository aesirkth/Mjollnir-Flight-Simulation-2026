function color = color_by_aerodynamics(obj)
persistent Color
if isempty(Color); Color = rand(1,3); end
if isfield(obj, "independent_aerodynamics")
    if obj.independent_aerodynamics
    Color = rand(1,3);
    end
end
color = Color;

end