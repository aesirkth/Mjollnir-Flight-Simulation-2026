function vectorquiver(ax, v,p, varargin)
if ~exist("p", "var"); p = v*0; end

if numel(v(1,:)) > 300
delta = round(numel(v)/300);
v = v(:,1:delta:end);
p = p(:,1:delta:end);
end
quiver3(ax, p(1,:), p(2,:), p(3,:), v(1,:), v(2,:), v(3,:), varargin{:});

end