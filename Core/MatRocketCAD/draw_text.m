function draw_text(ax, obj, varargin)

p = inputParser;
p.KeepUnmatched = true;

addParameter(p, 'ColorMode', @(obj) rand(1,3), @(x) isequal(class(x), 'function_handle'));
addParameter(p, 'Condition', @(obj) true,      @(x) isequal(class(x), 'function_handle'));

parse(p,varargin{:});

axes_varargin = [fieldnames(p.Unmatched) struct2cell(p.Unmatched)]';
axes_varargin = axes_varargin(:)';


obj = update_transforms(obj);

initial_current_axes = gca;
axes(ax)
plot3(ax, 0,0,0);
initial_plotstate = ax.NextPlot();
ax.NextPlot = "add";
axis equal;
draw_obj_internal(obj, "root")
axes(initial_current_axes)
ax.NextPlot = initial_plotstate;

function draw_obj_internal(obj, name)


if isfield(p.Unmatched, 'Color')
Color = p.Unmatched.Color;    
else
Color = p.Results.ColorMode(obj);
end


text(ax, obj.position_global(1), obj.position_global(2), obj.position_global(3), name, "Color",Color, axes_varargin{:})






child_names = fieldnames(obj);
for child_number = 1:numel(child_names)
    child_name = child_names{child_number};
    if is_body(obj.(child_name))
    if p.Results.Condition(obj.(child_name))
        draw_obj_internal(obj.(child_name), child_name);
    end
    end
end
end
end