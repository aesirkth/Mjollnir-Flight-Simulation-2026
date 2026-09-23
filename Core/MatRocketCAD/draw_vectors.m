function draw_vectors(ax, obj, varargin)


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
draw_obj_internal(obj, [0;0;0]);
axes(initial_current_axes)
ax.NextPlot = initial_plotstate;

function draw_obj_internal(obj, parent_position_global)


child_names = fieldnames(obj);
for child_number = 1:numel(child_names)
    child_name = child_names{child_number};
    if is_body(obj.(child_name))
    if p.Results.Condition(obj.(child_name))


        
        if isfield(p.Unmatched, 'Color')
        Color = p.Unmatched.Color;    
        else
        Color = p.Results.ColorMode(obj);
        end

        

        vectorplot   (ax, [obj.position_global, parent_position_global],     "Color",Color, axes_varargin{:})
        vectorscatter(ax,  obj.position_global,                         "x", "Color",Color, axes_varargin{:})
        vectorscatter(ax,                       parent_position_global,      "Color",Color, axes_varargin{:})


        draw_obj_internal(obj.(child_name), obj.position_global);
    end
    end
end
end
end