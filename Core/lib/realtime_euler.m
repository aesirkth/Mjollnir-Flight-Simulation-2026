function solution= realtime_euler(dvdt, t_span, v_init,record_spacing)

if ~exist("record_spacing", "var"); record_spacing = 1;  end


dt             = 1e-3;
t_max          = t_span(2);
t              = t_span(1);
v              =  v_init;
t_list         = zeros(1        , 1000);
v_list         = zeros(height(v), 1000);
index          = 1;
record_index   = 1;

while t < t_max
tic
dvdt_current  = dvdt(t,v);

v      = v + dvdt_current*dt;
t      = t+dt;
index  = index+1;

if rem(index, record_spacing) == 0
t_list(:,record_index) = t;
v_list(:,record_index) = v;
record_index    = record_index+1;

if record_index == width(t_list)
v_list(1, record_index+1000) = 0;
t_list(1, record_index+1000) = 0;
end

end

dt     = toc;



end

t_list = t_list(:,1:record_index);
v_list = v_list(:,1:record_index);

solution = struct();
solution.x = t_list;
solution.y = v_list;

end