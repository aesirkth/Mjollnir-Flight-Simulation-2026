function rocket = base_aerodynamics_model(rocket, declare_dependencies)
% This model doesn't use the center-of-pressure, it instead relies on the first, second
% third and fourth moments of area of the components broadsides to calculate the moment induced upon the component
% due to the relative wind.


if declare_dependencies

%rocket = recursive_setfield(rocket,"test", @(component)check_if_aerodynamically_independent_children(component) );

rocket  = aerodynamics_from_mesh ( rocket );
rocket  = recursive_rmfield      ( rocket, @(component) (   ~(check_persistent_flag(component) || check_if_aerodynamically_independent_children(component) || check_if_rigid_body_children(component) ) && is_body(component)));
rocket  = base_update_velocity   ( rocket, true );
if ~ isfield(rocket, "atmosphere"); rocket.atmosphere = struct(); end
rocket.atmosphere.density = 1;

else



rocket  = base_update_velocity  (rocket, false);
density = rocket.atmosphere.density;
rocket  = aerodynamics_model_internal(rocket);

end


function [component] = aerodynamics_model_internal(component)

    if is_body(component)

    children = fieldnames(component);

    for child_index = 1:numel(children)
    child = children{child_index};
    if is_body(component.(child)); component.(child) = aerodynamics_model_internal(component.(child)); end
    end


    if isfield(component, 'aerodynamics')

    component.aerodynamics.wind_velocity_absolute    = (component.attitude')*component.wind_velocity_absolute;
    

    %parallel_velocity_magnitude     = sqrt(norm(component.wind_velocity_absolute)^2 - component.aerodynamics.wind_velocity_absolute*norm(component.wind_velocity_absolute)); % Source: I made it the hell up.
    
    
    
    %% Drag:
    
   
    %component.aerodynamics.skin_drag = normalize(component.wind_velocity_absolute)*sum(component.aerodynamics.friction_coefficient.*component.aerodynamics.surface_area.*parallel_velocity_magnitude.^2)*density;
    
    %component.forces.DragForce = force((component.attitude')*drag_force, [0;0;0]);
   
    
    
    
    
    %% Lift:
    component.rotation_rate_component_basis = (component.attitude')*component.rotation_rate_absolute;
    
    linear_velocity_components              = zeros(3,3,4);
    linear_rotation_components              = zeros(3,3,4);
    
    % rotation_tensor_sign = [ 0 -1  1;
    %                         -1  0 -1;
    %                          1 -1  0];
    
    rotation_rate_tensor = [ 0                                           -component.rotation_rate_component_basis(3),  component.rotation_rate_component_basis(2);
                             component.rotation_rate_component_basis(3)   0                                           -component.rotation_rate_component_basis(1);
                            -component.rotation_rate_component_basis(2)   component.rotation_rate_component_basis(1)   0                                         ];
    
    % https://en.wikipedia.org/wiki/Angular_velocity#Tensor
    
    linear_rotation_components(:,:,1) = rotation_rate_tensor.^0;
    linear_rotation_components(:,:,2) = rotation_rate_tensor.^1;
    linear_rotation_components(:,:,3) = rotation_rate_tensor.^2;
    linear_rotation_components(:,:,4) = rotation_rate_tensor.^3;
    
    
    relative_velocity_tensor = [0                                                  component.aerodynamics.wind_velocity_absolute(1)   component.aerodynamics.wind_velocity_absolute(1);
                                component.aerodynamics.wind_velocity_absolute(2)   0                                                  component.aerodynamics.wind_velocity_absolute(2);
                                component.aerodynamics.wind_velocity_absolute(3)   component.aerodynamics.wind_velocity_absolute(3)   0                                               ];
    
    
    linear_velocity_components(:,:,1) =  relative_velocity_tensor.^3;
    linear_velocity_components(:,:,2) =  relative_velocity_tensor.^2;
    linear_velocity_components(:,:,3) =  relative_velocity_tensor.^1;
    linear_velocity_components(:,:,4) =  relative_velocity_tensor.^0;
    
    crossproduct_tensor  =-[ 0  1 -1;
                            -1  0  1;
                             1 -1  0];
    

    
    


    linear_coefficients        =   ones(1,1,4);
    linear_coefficients(1,1,1) =   1;
    linear_coefficients(1,1,2) =  -3;
    linear_coefficients(1,1,3) =   3;
    linear_coefficients(1,1,4) =  -1;
    
    
    scaling_factor     = 1./(abs( linear_velocity_components(:,:,3) - (component.aerodynamics.length_scale).*linear_rotation_components(:,:,2) ) + 1);
    
    
    
    % Tensor-form of NASA's drag equation: https://www1.grc.nasa.gov/beginners-guide-to-aeronautics/drag-equation/
    lift_moment_tensor = sum(0.5 *density*component.aerodynamics.pressure_coefficient.*linear_rotation_components.*linear_velocity_components.*linear_coefficients.*component.aerodynamics.moment_of_area(:,:,2:5).*scaling_factor, 3).*crossproduct_tensor;
    % Due to duplication of area in the area-tensor, this get's halved:
    lift_force_tensor  = sum(0.5 *density*component.aerodynamics.pressure_coefficient.*linear_rotation_components.*linear_velocity_components.*linear_coefficients.*component.aerodynamics.moment_of_area(:,:,1:4).*scaling_factor, 3);
    
    lift_moment_vector = [ lift_moment_tensor(3,2) + lift_moment_tensor(2,3);
                           lift_moment_tensor(3,1) + lift_moment_tensor(1,3);
                           lift_moment_tensor(1,2) + lift_moment_tensor(2,1) ];

    
    lift_force_vector  = lift_force_tensor * [1;1;1];
    
    % Convert to force-moment-arm pair, to make visualization and static
    % margin calcs easier
  
    component.forces.LiftForce   = force_vector  ( lift_force_vector,  cross(lift_force_vector, lift_moment_vector)/(dot(lift_force_vector, lift_force_vector) + (dot(lift_force_vector, lift_force_vector) == 0 ) ));

    %component.moments.LiftMoment = moment_vector(lift_moment_vector, [0;0;0]);
    %component.forces.LiftForce   = force_vector (lift_force_vector,  [0;0;0]);
    %component.lift_force_tensor  = lift_force_tensor;
    
    end
    
    
    end

    end
end









function obj = aerodynamics_from_mesh(obj)


    if isfield(obj, "independent_aerodynamics")
    if obj.independent_aerodynamics

    temp_fig       = figure();
    temp_ax        = axes(temp_fig); temp_ax.Color = [1 1 1];
    temp_ax.XColor = [1 1 1];
    temp_ax.YColor = [1 1 1];
    temp_ax.ZColor = [1 1 1];
    copy           = obj;
    copy.position  = [0;0;0]; % aerodynamics struct that is built is one level down hence in obj's base
    copy.attitude  = eye(3);
    draw_rocket(temp_ax, copy,                ...
                "FaceColor",         [0,0,0], ...
                "LineStyle",         "none",  ...
                "TraverseCondition", @traverse_condition);
    
    
    % % Debug:
    % 
    % patch(temp_ax3, mesh, 'FaceColor',       [0 0 0], ...
    %                           'EdgeColor',       'none');
    % material('dull');
    % axis(temp_ax3, "equal")
    % xlabel(temp_ax3, "X")
    % ylabel(temp_ax3, "Y")
    % zlabel(temp_ax3, "Z")
    
    moment_of_area = zeros(3,3,5); % Rows:    Faces
                                   % Columns: x/Degree of freedom
                                   % Pages:   Degree of area-moment
    length_scale = ones(3,1);
    surface_area = zeros(3,1);
    bounds       = [temp_ax.XLim;temp_ax.YLim;temp_ax.ZLim];
    %% coordinate-transfer:
    for face      = 1:3
    
    if     face == 1; view(temp_ax, 90,0); drawnow; dimension2image_hash = ["NA"    "width"  "height"];
    elseif face == 2; view(temp_ax, 0,0 ); drawnow; dimension2image_hash = ["width" "NA"     "height"];
    else;             view(temp_ax, 0,90); drawnow; dimension2image_hash = ["width" "height"  "NA"   ];
    end
    
    shadow = getframe(temp_fig);
    shadow.cdata = flipud(shadow.cdata);
    %imagesc(shadow.cdata); drawnow; pause(10)
    
    % Warning! Busy logic up ahead.
    
    height_projection = sum(~shadow.cdata(:,:,1), 2);
    [max_pixel_height, ~] = find(height_projection, 1, 'last'  );
    [min_pixel_height, ~] = find(height_projection, 1, 'first' );
    width_projection  = sum(~shadow.cdata(:,:,1), 1);
    [~, max_pixel_width ] = find(width_projection,  1, 'last'  );
    [~, min_pixel_width ] = find(width_projection,  1, 'first' );
    
    
    for dimension = 1:3
    
    if     dimension2image_hash(dimension) == "height"
    
    %[max_mesh_height] = max(mesh.Points(:,dimension), [],1 );
    %[min_mesh_height] = min(mesh.Points(:,dimension), [],1 );
    min_mesh_height = bounds(dimension, 1);
    max_mesh_height = bounds(dimension, 2);

    pixel2height  = @(pixel )        (pixel  - min_pixel_height)*(max_mesh_height  - min_mesh_height )/(max_pixel_height - min_pixel_height) + min_mesh_height;
    height2pixel  = @(height) round( (height - min_mesh_height )*(max_pixel_height - min_pixel_height)/(max_mesh_height  - min_mesh_height ) + min_pixel_height);
    pixel_height  = pixel2height(2) - pixel2height(1);
    
    elseif dimension2image_hash(dimension) == "width"
    
    %[max_mesh_width] = max(mesh.Points(:,dimension), [],1 );
    %[min_mesh_width] = min(mesh.Points(:,dimension), [],1 );
    
    min_mesh_width = bounds(dimension, 1);
    max_mesh_width = bounds(dimension, 2);

    pixel2width   = @(pixel )        (pixel  - min_pixel_width )*(max_mesh_width   - min_mesh_width  )/(max_pixel_width  - min_pixel_width ) + min_mesh_width;
    width2pixel   = @(width ) round( (width  - min_mesh_width  )*(max_pixel_width  - min_pixel_width )/(max_mesh_width   - min_mesh_width  ) + min_pixel_width);
    pixel_width   = pixel2width (2) - pixel2width (1);
    end
    
    end
    
    
    height2width  = @(height) pixel_width *height_projection(height2pixel(height))';
    width2height  = @(width)  pixel_height*width_projection (width2pixel (width )) ;
    
    
    
    for dimension = 1:3
    
    if     dimension2image_hash(dimension) == "height"
    height_vec = min_mesh_height:pixel_height:max_mesh_height;
    surface_area(face) = pixel_height*sum( height2width(height_vec), "all");
    moment_of_area(face, dimension, 1) = pixel_height*sum( height2width(height_vec).*((height_vec).^0), "all");
    moment_of_area(face, dimension, 2) = pixel_height*sum( height2width(height_vec).*((height_vec).^1), "all");
    moment_of_area(face, dimension, 3) = pixel_height*sum( height2width(height_vec).*((height_vec).^2), "all");
    moment_of_area(face, dimension, 4) = pixel_height*sum( height2width(height_vec).*((height_vec).^3), "all");
    moment_of_area(face, dimension, 5) = pixel_height*sum( height2width(height_vec).*((height_vec).^4), "all");
    length_scale(dimension) = max(abs(max_mesh_height),abs(min_mesh_height));
    elseif dimension2image_hash(dimension) == "width"
    width_vec = min_mesh_width:pixel_width:max_mesh_width;
    surface_area(face) = pixel_width*sum( width2height(width_vec), "all");
    moment_of_area(face, dimension, 1) = pixel_width*sum( width2height(width_vec ).*((width_vec) .^0), "all");
    moment_of_area(face, dimension, 2) = pixel_width*sum( width2height(width_vec ).*((width_vec) .^1), "all");
    moment_of_area(face, dimension, 3) = pixel_width*sum( width2height(width_vec ).*((width_vec) .^2), "all");
    moment_of_area(face, dimension, 4) = pixel_width*sum( width2height(width_vec ).*((width_vec) .^3), "all");
    moment_of_area(face, dimension, 5) = pixel_width*sum( width2height(width_vec ).*((width_vec) .^4), "all");
    length_scale(dimension) = max(abs(max_mesh_width),abs(min_mesh_width));
    end
    
    
    
    
    
    
    
    
    
    % % Debug:
    % 
    % if dimension2image_hash(dimension)     == "height"
    % plot(temp_ax2, height2width(height_vec), height_vec); 
    % pixel_height = pixel_height
    % elseif dimension2image_hash(dimension) == "width"
    % plot(temp_ax2, width_vec, width2height(width_vec));
    % pixel_width = pixel_width
    % end
    % temp_ax2.NextPlot = "add";
    % scatter(temp_ax2, obj.rigid_body.center_of_mass(dimension), 1);
    % temp_ax.NextPlot = "replacechildren";
    % face
    % dimension
    % dimension2image_hash(dimension)
    % axis equal
    % drawnow; pause(10)
    
    
    end
    
    end

     
    
    
    
    obj.aerodynamics = struct();
    
    obj.aerodynamics.moment_of_area       = moment_of_area;
    obj.aerodynamics.length_scale         = length_scale;
    obj.aerodynamics.pressure_coefficient = [0.4;0.4;0.2];
    obj.aerodynamics.is_rigid_body        = true;
    %obj.aerodynamics.is_body = true;
    
    close(temp_fig);
    

    end
    end


children = fieldnames(obj);

for child_index = 1:numel(children)
    child = children{child_index};
    if isstruct(obj.(child)) && isscalar(obj.(child))
        obj.(child) = aerodynamics_from_mesh(obj.(child));
        if is_rigid_body(obj.(child))
            obj.is_rigid_body = true;
        end
    end
end 
end







function tf = traverse_condition(obj, ~)
% Draw all children and myself, so long as my children dont have
% independent aerodynamics

if isfield(obj, "independent_aerodynamics")
    tf = ~obj.independent_aerodynamics;
else 
    tf =  false;
end

end


function tf = check_persistent_flag(variable)
    if isfield(variable, 'aerodynamics_persistent_flag')
    tf = variable.aerodynamics_persistent_flag;
    else
    tf = true;
    end

end


function tf = check_if_aerodynamically_independent_children(variable)

    tf = false;
    
    child_names = fieldnames(variable);
    child_index = 1;
    while tf == 0
    
        child_name = child_names{child_index};
        if isstruct(variable.(child_name))
            if isfield(variable.(child_name), 'independent_aerodynamics'); tf = tf + variable.(child_name).independent_aerodynamics; end

            tf = tf + check_if_aerodynamically_independent_children(variable.(child_name));
        end

    child_index = child_index + 1;
    if child_index > numel(child_names); break; end
    end


    tf = tf > 0;

end




function tf = check_if_rigid_body_children(variable)
    if isfield(variable, 'is_rigid_body')
        tf = variable.is_rigid_body;
    else
        tf = false;
    end
    
    child_names = fieldnames(variable);
    child_index = 1;
    while tf == 0
    
        child_name = child_names{child_index};
        if isstruct(variable.(child_name))
        tf = tf + check_if_rigid_body_children(variable.(child_name));
        end

    child_index = child_index + 1;
    if child_index > numel(child_names); break; end
    end


    tf = tf > 0;

end


