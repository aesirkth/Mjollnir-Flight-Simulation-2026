function output = logger(rocket)

persistent init
persistent jsonbuffer
persistent jsonindex
persistent counter
persistent t_real
persistent time_handle
persistent t_simulation

if isempty(init)
init          = false;
jsonbuffer    = [char('[');char(1,1000000)];
jsonindex     = 1;
counter       = 1;
t_real        = 0;
time_handle   = tic;
t_simulation  = 0;
end


if exist("rocket", "var") 

dt_real        = toc(time_handle);
rocket.dt_real = dt_real;
time_handle    = tic;
t_real         = t_real+dt_real;
rocket.t_real  = t_real;
dt_simulation  = rocket.t - t_simulation;
rocket.dt      = dt_simulation;
t_simulation   = rocket.t;
rocket.realtime_margin = rocket.dt/rocket.dt_real;




if counter == 1


append = [jsonencode(rm_nonjsonfields(rocket)), ','];

if jsonindex > length(jsonbuffer); jsonbuffer(end+1000000) = ' ';disp("matrocket logger:alloc"); end

jsonbuffer (jsonindex+1:jsonindex+numel(append)) = append;
jsonindex =             jsonindex+numel(append);

end

counter = counter+1;
if counter == 6; counter = 1; end


end


if nargout > 0

outjson       = [jsonbuffer(1:jsonindex-1); ']'];
snapshots     = num2cell(jsondecode(outjson'));
assignin("base", "debug", snapshots)

if iscell(snapshots{1}); snapshots = cellfun(@(c) c{1}, snapshots, "UniformOutput",false); end % <-- matlab is sometimes inconsistent with jsondecode output it turns out...

output        = recursive_concat(snapshots);
output.dt     = output.t(2:end) - output.t(1:end-1); output.dt(end+1) = output.dt(end);

end


function outstruct = recursive_concat(snapshots)

outstruct = struct();

child_names = fieldnames(snapshots{1});

for child_index = 1:numel(child_names)
child_name = child_names{child_index};

if isstruct(snapshots{1}.(child_name))
child_snapshots = cell(size(snapshots));
for snapshot_index = 1:numel(snapshots)
try
child_snapshot = snapshots{snapshot_index}.(child_name);
catch
end

child_snapshots{snapshot_index} = child_snapshot;
end

if isscalar(child_snapshots{1})
outstruct.(child_name) = recursive_concat(child_snapshots);
end

elseif isnumeric(snapshots{1}.(child_name))
data_dimensions = ndims(snapshots{1}.(child_name));
while data_dimensions > 1; if size(snapshots{1}.(child_name), data_dimensions) == 1; data_dimensions = data_dimensions-1; else; break; end; end
outstruct.(child_name) = cell2mat(cellfun(@(c)getfield(c, child_name), reshape(snapshots, [ones(1,data_dimensions), numel(snapshots)]), 'UniformOutput', false));

end


end



end
end
