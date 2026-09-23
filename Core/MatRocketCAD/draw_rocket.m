function draw_rocket(ax, obj, varargin)

p = inputParser;
p.KeepUnmatched = true;

addParameter(p, 'ColorMode',         @(obj,~) rand(1,3), @(x) isequal(class(x), 'function_handle'));
addParameter(p, 'TraverseCondition', @(obj,~) true,      @(x) isequal(class(x), 'function_handle'));
addParameter(p, 'DrawCondition',     @(obj,~) true,      @(x) isequal(class(x), 'function_handle'));

parse(p,varargin{:});

axes_varargin = [fieldnames(p.Unmatched) struct2cell(p.Unmatched)]';
axes_varargin = axes_varargin(:)';


obj = update_transforms(obj);


plot3(ax, NaN,NaN,NaN);
initial_plotstate = ax.NextPlot();
ax.NextPlot = "add";
axis(ax, "equal");
draw_obj_internal(obj, "")
ax.NextPlot = initial_plotstate;

function draw_obj_internal(obj, obj_address)


if isfield(p.Unmatched, 'FaceColor')
Color = p.Unmatched.FaceColor;    
else
Color = p.Results.ColorMode(obj, obj_address);
end



if isfield(obj, "mesh") && p.Results.DrawCondition(obj, obj_address)
    mesh_path       = replace(replace(replace(obj.mesh, "//", "\"), "\\", "\"), "/","\");
    try CAD = evalin("base", "CAD"); mesh = CAD.(filename2varname(obj.mesh)); catch; mesh = stlread(mesh_path); try CAD = evalin("base", "CAD"); catch; CAD = struct(); assignin("base","CAD", CAD); end; CAD.(filename2varname(obj.mesh)) = mesh; assignin("base", "CAD", CAD); end
    new_mesh        = mesh;
    new_mesh_Points = new_mesh.Points*(obj.mesh_scale'*obj.attitude_global') + obj.position_global';
    new_mesh_tri    = triangulation(mesh.ConnectivityList, new_mesh_Points);
    
    trisurf(new_mesh_tri, axes_varargin{:}, "FaceColor", Color, 'Parent', ax);
end
    

    child_names = fieldnames(obj);
    for child_number = 1:numel(child_names)
        child_name = child_names{child_number};
        if p.Results.TraverseCondition(obj.(child_name), obj_address+"."+child_name)
        if is_body(obj.(child_name))
        draw_obj_internal(obj.(child_name), obj_address+"."+child_name);
        end
        end

    end
end
end