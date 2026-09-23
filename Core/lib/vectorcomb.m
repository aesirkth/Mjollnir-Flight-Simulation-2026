function vectorcomb(ax, v,p,delta, varargin)


if ~exist("p", "var")
p = v*0;
end

if ~exist("delta", "var")
delta = round(numel(v(1,:))/100);
end


v_index = 1;
while v_index < numel(v(1,:)); v(:,v_index) = p(:,v_index); v_index = v_index + delta; end

plot3(ax, v(1,:), v(2,:), v(3,:), varargin{:});

end